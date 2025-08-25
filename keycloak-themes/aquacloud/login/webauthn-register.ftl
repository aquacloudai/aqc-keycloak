<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "title">
        ${msg("webauthn-registration-title")}
    <#elseif section = "header">
        ${msg("webauthn-registration-title")}
    <#elseif section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Set up Passkey</h1>
            <p class="welcome-subtitle">Register a passkey to secure your account with biometrics or security keys.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <div class="webauthn-container">
                <div class="webauthn-setup-steps">
                    <div class="setup-step">
                        <div class="step-number">1</div>
                        <div class="step-content">
                            <h3>Choose your method</h3>
                            <p>You can use your device's built-in biometrics (fingerprint, face, etc.) or a security key.</p>
                        </div>
                    </div>
                    
                    <div class="setup-step">
                        <div class="step-number">2</div>
                        <div class="step-content">
                            <h3>Follow device prompts</h3>
                            <p>Your browser will guide you through the setup process for your chosen method.</p>
                        </div>
                    </div>
                    
                    <div class="setup-step">
                        <div class="step-number">3</div>
                        <div class="step-content">
                            <h3>Secure access</h3>
                            <p>Once set up, you can sign in quickly and securely without passwords.</p>
                        </div>
                    </div>
                </div>

                <form id="register" action="${url.loginAction}" method="post">
                    <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                    <input type="hidden" id="attestationObject" name="attestationObject"/>
                    <input type="hidden" id="publicKeyCredentialId" name="publicKeyCredentialId"/>
                    <input type="hidden" id="authenticatorLabel" name="authenticatorLabel"/>
                    <input type="hidden" id="transports" name="transports"/>
                    <input type="hidden" id="error" name="error"/>

                    <div class="form-group">
                        <label for="authenticatorLabel" class="device-label">Passkey Name (Optional)</label>
                        <input type="text" 
                               id="authenticatorLabelInput" 
                               name="authenticatorLabelInput" 
                               class="form-control device-input"
                               placeholder="My Device"
                               autocomplete="off" />
                        <div class="help-text">
                            Give this passkey a name to help you identify it later.
                        </div>
                    </div>

                    <div class="webauthn-info">
                        <div class="passkey-icon">
                            <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M12 1L3 5V11C3 16.55 6.84 21.74 12 23C17.16 21.74 21 16.55 21 11V5L12 1Z" stroke="var(--aq-accent)" stroke-width="2" stroke-linejoin="round"/>
                                <path d="M9 12L11 14L15 10" stroke="var(--aq-accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </div>
                        <h3>Ready to register</h3>
                        <p>Click the button below to start setting up your passkey.</p>
                    </div>

                    <div id="kc-form-buttons">
                        <input id="registerWebAuthnButton" class="btn btn-primary btn-block btn-lg" type="button" autofocus="autofocus" value="${msg('webauthn-doRegister')}" />
                        <#if isAppInitiatedAction??>
                            <a class="btn btn-secondary btn-block" href="${url.loginAction}">
                                ${msg("doCancel")}
                            </a>
                        </#if>
                    </div>
                </form>
                
                <div class="back-to-login">
                    <a href="${url.loginUrl}" class="back-link">← Back to login</a>
                </div>
            </div>
        </div>
        
        <script>
            const registerButton = document.getElementById('registerWebAuthnButton');
            const form = document.getElementById('register');
            const labelInput = document.getElementById('authenticatorLabelInput');
            
            registerButton.addEventListener('click', function() {
                registerButton.disabled = true;
                registerButton.value = 'Setting up...';
                
                // Set the label from input
                document.getElementById('authenticatorLabel').value = labelInput.value || 'AquaCloud Passkey';
                
                // Simplified approach following Keycloak's pattern
                const input = {
                    challenge: '${challenge!""}',
                    userid: '${userid!""}',
                    username: '${username!""}',
                    signatureAlgorithms: [
                        <#if signatureAlgorithms?has_content>
                            <#list signatureAlgorithms as sigAlg>
                                ${sigAlg?c}<#if sigAlg_has_next>,</#if>
                            </#list>
                        <#else>
                            -7, -257
                        </#if>
                    ],
                    rpEntityName: '${rpEntityName!"AquaCloud"}',
                    rpId: '${rpId!"localhost"}',
                    attestationConveyancePreference: '${attestationConveyancePreference!"not specified"}',
                    authenticatorAttachment: '${(authenticatorSelection.authenticatorAttachment)!"not specified"}',
                    requireResidentKey: '${(authenticatorSelection.requireResidentKey)!"not specified"}',
                    userVerificationRequirement: '${(authenticatorSelection.userVerification)!"not specified"}',
                    createTimeout: ${(timeout!30000)?c},
                    excludeCredentialIds: '${excludeCredentialIds!""}'
                };
                
                registerByWebAuthn(input);
            });
            
            // Simplified WebAuthn registration function based on Keycloak's approach
            function registerByWebAuthn(input) {
                // Check if WebAuthn is supported
                if (!window.PublicKeyCredential) {
                    document.getElementById('error').value = 'WebAuthn not supported';
                    form.submit();
                    return;
                }
                
                // Helper function to convert base64url to Uint8Array
                function base64urlToUint8Array(base64url) {
                    const base64 = base64url.replace(/-/g, '+').replace(/_/g, '/');
                    const padded = base64.padEnd(base64.length + (4 - base64.length % 4) % 4, '=');
                    const binary = atob(padded);
                    const bytes = new Uint8Array(binary.length);
                    for (let i = 0; i < binary.length; i++) {
                        bytes[i] = binary.charCodeAt(i);
                    }
                    return bytes;
                }
                
                const publicKey = {
                    challenge: base64urlToUint8Array(input.challenge),
                    rp: {id: input.rpId, name: input.rpEntityName},
                    user: {
                        id: base64urlToUint8Array(input.userid),
                        name: input.username,
                        displayName: input.username
                    },
                    pubKeyCredParams: input.signatureAlgorithms.map(alg => ({type: 'public-key', alg: alg})),
                    timeout: input.createTimeout
                };
                
                // Add attestation if specified
                if (input.attestationConveyancePreference !== 'not specified') {
                    publicKey.attestation = input.attestationConveyancePreference;
                }
                
                // Configure authenticator selection
                const authenticatorSelection = {};
                let isAuthenticatorSelectionSpecified = false;
                
                if (input.authenticatorAttachment !== 'not specified') {
                    authenticatorSelection.authenticatorAttachment = input.authenticatorAttachment;
                    isAuthenticatorSelectionSpecified = true;
                }
                
                if (input.requireResidentKey !== 'not specified') {
                    authenticatorSelection.requireResidentKey = input.requireResidentKey === 'Yes';
                    isAuthenticatorSelectionSpecified = true;
                }
                
                if (input.userVerificationRequirement !== 'not specified') {
                    authenticatorSelection.userVerification = input.userVerificationRequirement;
                    isAuthenticatorSelectionSpecified = true;
                }
                
                if (isAuthenticatorSelectionSpecified) {
                    publicKey.authenticatorSelection = authenticatorSelection;
                }
                
                // Add excluded credentials if any
                if (input.excludeCredentialIds && input.excludeCredentialIds.length > 0) {
                    publicKey.excludeCredentials = input.excludeCredentialIds.split(',').map(id => ({
                        id: base64urlToUint8Array(id.trim()),
                        type: 'public-key'
                    }));
                }
                
                navigator.credentials.create({
                    publicKey: publicKey
                }).then(credential => {
                    const response = credential.response;
                    
                    // Convert ArrayBuffer to base64url (which Keycloak expects)
                    function arrayBufferToBase64url(buffer) {
                        const binary = String.fromCharCode(...new Uint8Array(buffer));
                        return btoa(binary)
                            .replace(/\+/g, '-')
                            .replace(/\//g, '_')
                            .replace(/=/g, '');
                    }
                    
                    document.getElementById('clientDataJSON').value = arrayBufferToBase64url(response.clientDataJSON);
                    document.getElementById('attestationObject').value = arrayBufferToBase64url(response.attestationObject);
                    document.getElementById('publicKeyCredentialId').value = credential.id;
                    
                    if (response.getTransports) {
                        document.getElementById('transports').value = JSON.stringify(response.getTransports());
                    }
                    
                    form.submit();
                }).catch(err => {
                    console.error('WebAuthn registration failed:', err);
                    document.getElementById('error').value = err.toString();
                    registerButton.disabled = false;
                    registerButton.value = '${msg("webauthn-doRegister")}';
                });
            }
        </script>
    </#if>
</@layout.registrationLayout>