<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "title">
        ${msg("webauthn-error-title")}
    <#elseif section = "header">
        ${msg("webauthn-error-title")}
    <#elseif section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <div class="error-container">
                <div class="error-icon">
                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 1L3 5V11C3 16.55 6.84 21.74 12 23C17.16 21.74 21 16.55 21 11V5L12 1Z" stroke="#dc2626" stroke-width="2" stroke-linejoin="round"/>
                        <line x1="15" y1="9" x2="9" y2="15" stroke="#dc2626" stroke-width="2"/>
                        <line x1="9" y1="9" x2="15" y2="15" stroke="#dc2626" stroke-width="2"/>
                    </svg>
                </div>
                
                <h1 class="error-title">Passkey Authentication Failed</h1>
                
                <#if message?has_content>
                    <div class="error-message">
                        ${kcSanitize(message.summary)?no_esc}
                    </div>
                <#else>
                    <div class="error-message">
                        We couldn't authenticate your passkey. This could happen for several reasons:
                        <ul class="error-reasons">
                            <li>The authentication was cancelled</li>
                            <li>Your device doesn't support the required security features</li>
                            <li>The passkey might have been removed from your device</li>
                            <li>There was a temporary network or system issue</li>
                        </ul>
                    </div>
                </#if>
                
                <div class="error-actions">
                    <a href="${url.loginUrl}" class="btn btn-primary">
                        Try Again
                    </a>
                    <#if realm.resetPasswordAllowed>
                        <a href="${url.loginResetCredentialsUrl}" class="btn btn-secondary">
                            Reset Password Instead
                        </a>
                    </#if>
                </div>
                
                <div class="help-section">
                    <h3>Troubleshooting Tips</h3>
                    <div class="help-grid">
                        <div class="help-item">
                            <div class="help-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M9 12L11 14L15 10" stroke="var(--aq-accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <circle cx="12" cy="12" r="9" stroke="var(--aq-accent)" stroke-width="2"/>
                                </svg>
                            </div>
                            <div class="help-content">
                                <h4>Check Your Device</h4>
                                <p>Make sure your fingerprint sensor or face unlock is working properly.</p>
                            </div>
                        </div>
                        
                        <div class="help-item">
                            <div class="help-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <rect x="2" y="3" width="20" height="14" rx="2" ry="2" stroke="var(--aq-accent)" stroke-width="2"/>
                                    <line x1="8" y1="21" x2="16" y2="21" stroke="var(--aq-accent)" stroke-width="2"/>
                                    <line x1="12" y1="17" x2="12" y2="21" stroke="var(--aq-accent)" stroke-width="2"/>
                                </svg>
                            </div>
                            <div class="help-content">
                                <h4>Browser Support</h4>
                                <p>Ensure you're using a compatible browser that supports WebAuthn.</p>
                            </div>
                        </div>
                        
                        <div class="help-item">
                            <div class="help-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" stroke="var(--aq-accent)" stroke-width="2"/>
                                    <path d="M9.09 9C9.3251 8.33167 9.78915 7.76811 10.4 7.40913C11.0108 7.05016 11.7289 6.91894 12.4272 7.03871C13.1255 7.15849 13.7588 7.52152 14.2151 8.06353C14.6713 8.60553 14.9211 9.29152 14.92 10C14.92 12 11.92 13 11.92 13" stroke="var(--aq-accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                    <path d="M12 17H12.01" stroke="var(--aq-accent)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </div>
                            <div class="help-content">
                                <h4>Need Help?</h4>
                                <p>Contact support if you continue experiencing issues with passkey authentication.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>