<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Setup Authenticator</h1>
            <p class="welcome-subtitle">Configure your authenticator app for two-factor authentication.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <#-- Debug: Check if totp object is available -->
            <#if !totp??>
                <div class="alert alert-error">
                    <span>TOTP configuration object is not available. Please try refreshing the page or contact support.</span>
                </div>
            </#if>
            
            <div class="totp-setup-container">
                <div class="setup-steps">
                    <div class="setup-step">
                        <div class="step-number">1</div>
                        <div class="step-content">
                            <h3>Download an authenticator app</h3>
                            <p>We recommend Google Authenticator, Authy, or Microsoft Authenticator.</p>
                        </div>
                    </div>
                    
                    <div class="setup-step">
                        <div class="step-number">2</div>
                        <div class="step-content">
                            <h3>Scan the QR code</h3>
                            <div class="qr-code-container">
                                <#if totp?? && totp.totpSecretQrCode??>
                                    <img id="kc-totp-secret-qr-code" src="data:image/png;base64,${totp.totpSecretQrCode}" alt="QR Code for TOTP setup" class="qr-code">
                                <#else>
                                    <div class="qr-code-placeholder">
                                        <p>QR Code not available. Please use the manual entry key below.</p>
                                    </div>
                                </#if>
                            </div>
                            <div class="manual-key-container">
                                <p class="manual-key-label">Can't scan? Enter this key manually:</p>
                                <div class="manual-key">
                                    <#if totp?? && totp.totpSecretEncoded??>
                                        <code>${totp.totpSecretEncoded}</code>
                                        <button type="button" class="copy-key-btn" onclick="copyToClipboard('${totp.totpSecretEncoded}')">
                                            Copy
                                        </button>
                                    <#else>
                                        <code>Manual key not available</code>
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="setup-step">
                        <div class="step-number">3</div>
                        <div class="step-content">
                            <h3>Enter the verification code</h3>
                            <p>Enter the 6-digit code from your authenticator app to complete setup.</p>
                        </div>
                    </div>
                </div>
                
                <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
                    <#if totp?? && totp.totpSecret??>
                        <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                    </#if>
                    
                    <div class="form-group">
                        <label for="totp" class="totp-verify-label">Verification Code</label>
                        <input type="text" 
                               id="totp" 
                               name="totp" 
                               autocomplete="off" 
                               class="form-control totp-verify-input"
                               placeholder="000000"
                               maxlength="6"
                               pattern="[0-9]{6}"
                               inputmode="numeric"
                               autofocus />
                    </div>
                    
                    <div class="form-group">
                        <label for="userLabel" class="device-label">Device Name (Optional)</label>
                        <input type="text" 
                               id="userLabel" 
                               name="userLabel" 
                               class="form-control device-input"
                               placeholder="My Phone"
                               value="${totp.otpCredentialName!''}" />
                    </div>

                    <div id="kc-form-buttons">
                        <input class="btn btn-primary btn-block btn-lg" 
                               type="submit" 
                               value="Complete Setup"/>
                        <a class="btn btn-secondary btn-block" 
                           href="${url.loginAction}">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
        
        <script>
            function copyToClipboard(text) {
                navigator.clipboard.writeText(text).then(function() {
                    const btn = event.target;
                    const originalText = btn.textContent;
                    btn.textContent = 'Copied!';
                    btn.classList.add('copied');
                    setTimeout(function() {
                        btn.textContent = originalText;
                        btn.classList.remove('copied');
                    }, 2000);
                });
            }
        </script>
    </#if>
</@layout.registrationLayout>