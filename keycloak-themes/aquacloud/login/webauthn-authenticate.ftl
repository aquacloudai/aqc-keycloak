<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "title">
        ${msg("webauthn-login-title")}
    <#elseif section = "header">
        ${msg("webauthn-login-title")}
    <#elseif section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Sign in with Passkey</h1>
            <p class="welcome-subtitle">Use your fingerprint, face, or security key to sign in securely.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <div class="webauthn-container">
                <form id="webauth" action="${url.loginAction}" method="post">
                    <input type="hidden" id="clientDataJSON" name="clientDataJSON"/>
                    <input type="hidden" id="authenticatorData" name="authenticatorData"/>
                    <input type="hidden" id="signature" name="signature"/>
                    <input type="hidden" id="credentialId" name="credentialId"/>
                    <input type="hidden" id="userHandle" name="userHandle"/>
                    <input type="hidden" id="error" name="error"/>

                    <div class="webauthn-info">
                        <div class="passkey-icon">
                            <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M7 10V7C7 4.79086 8.79086 3 11 3C13.2091 3 15 4.79086 15 7V10" stroke="var(--aq-accent)" stroke-width="2" stroke-linecap="round"/>
                                <path d="M6 10H16C17.1046 10 18 10.8954 18 12V18C18 19.1046 17.1046 20 16 20H6C4.89543 20 4 19.1046 4 18V12C4 10.8954 4.89543 10 6 10Z" stroke="var(--aq-accent)" stroke-width="2"/>
                                <circle cx="11" cy="15" r="1" fill="var(--aq-accent)"/>
                                <path d="M20 8L22 10L20 12" stroke="var(--aq-accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M20 10H18" stroke="var(--aq-accent)" stroke-width="2" stroke-linecap="round"/>
                            </svg>
                        </div>
                        <h3>Ready to authenticate</h3>
                        <p>Click the button below and follow the prompts on your device.</p>
                    </div>

                    <#if authenticators?has_content>
                        <div class="authenticators-list">
                            <h4>Available authenticators:</h4>
                            <#list authenticators.authenticators as authenticator>
                                <div class="authenticator-item">
                                    <div class="authenticator-icon">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <rect x="4" y="6" width="16" height="12" rx="2" stroke="var(--aq-text-secondary)" stroke-width="2"/>
                                            <circle cx="12" cy="12" r="2" fill="var(--aq-text-secondary)"/>
                                        </svg>
                                    </div>
                                    <div class="authenticator-details">
                                        <div class="authenticator-label">${authenticator.label!\"Authenticator\"}</div>
                                        <div class="authenticator-meta">
                                            <#if authenticator.transports?? && authenticator.transports?has_content>
                                                <span class="transport">${authenticator.transports}</span>
                                            </#if>
                                            <#if authenticator.createdDate?? && authenticator.createdDate?has_content>
                                                <span class="created-date">Added ${authenticator.createdDate}</span>
                                            </#if>
                                        </div>
                                    </div>
                                </div>
                            </#list>
                        </div>
                    </#if>

                    <div id="kc-form-buttons">
                        <input id="authenticateWebAuthnButton" class="btn btn-primary btn-block btn-lg" type="button" autofocus="autofocus" value="${msg('webauthn-doAuthenticate')}" />
                        <#if realm.resetPasswordAllowed>
                            <div class="alternative-auth">
                                <a href="${url.loginResetCredentialsUrl}" class="alt-method-link">Forgot your password?</a>
                            </div>
                        </#if>
                    </div>
                </form>
                
                <div class="back-to-login">
                    <a href="${url.loginUrl}" class="back-link">← Back to login</a>
                </div>
            </div>
        </div>
        
        <script>
            // Use native WebAuthn API instead of external library
            
            const authButton = document.getElementById('authenticateWebAuthnButton');
            const form = document.getElementById('webauth');
            
            authButton.addEventListener('click', function() {
                authButton.disabled = true;
                authButton.value = 'Authenticating...';
                
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
                
                const input = {
                    <#if challenge??>
                        challenge: base64urlToUint8Array('${challenge}'),
                    </#if>
                    <#if userVerification??>
                        userVerification: '${userVerification}',
                    </#if>
                    <#if rpId??>
                        rpId: '${rpId}',
                    </#if>
                    <#if authenticators?? && authenticators.authenticators?has_content>
                        allowCredentials: [
                            <#list authenticators.authenticators as authenticator>
                                {
                                    id: base64urlToUint8Array('${authenticator.credentialId!''}'),
                                    type: 'public-key'
                                    <#if authenticator.transports?has_content>
                                        ,transports: [${authenticator.transports}]
                                    </#if>
                                }<#if authenticator_has_next>,</#if>
                            </#list>
                        ],
                    </#if>
                    timeout: 30000
                };
                
                // Use native WebAuthn API
                if (!navigator.credentials || !navigator.credentials.get) {
                    document.getElementById('error').value = 'WebAuthn not supported';
                    form.submit();
                    return;
                }

                navigator.credentials.get({
                    publicKey: input
                }).then(credential => {
                    const response = credential.response;
                    
                    // Convert ArrayBuffer to base64
                    function arrayBufferToBase64(buffer) {
                        const binary = String.fromCharCode(...new Uint8Array(buffer));
                        return btoa(binary);
                    }
                    
                    document.getElementById('clientDataJSON').value = arrayBufferToBase64(response.clientDataJSON);
                    document.getElementById('authenticatorData').value = arrayBufferToBase64(response.authenticatorData);
                    document.getElementById('signature').value = arrayBufferToBase64(response.signature);
                    document.getElementById('credentialId').value = credential.id;
                    document.getElementById('userHandle').value = response.userHandle ? arrayBufferToBase64(response.userHandle) : '';
                    
                    form.submit();
                }).catch(err => {
                    console.error('WebAuthn authentication failed:', err);
                    document.getElementById('error').value = err.toString();
                    authButton.disabled = false;
                    authButton.value = '${msg("webauthn-doAuthenticate")}';
                });
            });
        </script>
    </#if>
</@layout.registrationLayout>