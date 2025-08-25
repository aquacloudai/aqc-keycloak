<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<#import "register-commons.ftl" as registerCommons>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm'); section>
    <#if section = "header">
        <#if messageHeader??>
            ${kcSanitize(messageHeader)?no_esc}
        <#else>
            ${msg("registerTitle")}
        </#if>
    <#elseif section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Create Account</h1>
            <p class="welcome-subtitle">Join AquaCloud to get started with secure authentication.</p>
            
            <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
                <@userProfileCommons.userProfileFormFields; callback, attribute>
                    <#if callback = "afterField">
                        <#-- Password field with visibility toggle -->
                        <#if attribute.name == "password">
                            <div class="form-group">
                                <label for="password" class="password-label">
                                    ${msg("password")} <#if attribute.required>*</#if>
                                </label>
                                <div class="password-input-wrapper">
                                    <input type="password" id="password" class="form-control" name="password" 
                                           autocomplete="new-password"
                                           aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"
                                           placeholder="${msg('password')}" />
                                    <button type="button" class="password-visibility-toggle" onclick="togglePasswordVisibility('password')" aria-label="Toggle password visibility">
                                        <svg class="eye-open" width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M1 12S5 4 12 4s11 8 11 8-4 8-11 8S1 12 1 12z" stroke="var(--aq-text-muted)" stroke-width="2"/>
                                            <circle cx="12" cy="12" r="3" stroke="var(--aq-text-muted)" stroke-width="2"/>
                                        </svg>
                                        <svg class="eye-closed" width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="display: none;">
                                            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" stroke="var(--aq-text-muted)" stroke-width="2"/>
                                            <line x1="1" y1="1" x2="23" y2="23" stroke="var(--aq-text-muted)" stroke-width="2"/>
                                        </svg>
                                    </button>
                                </div>
                                <#if messagesPerField.existsError('password')>
                                    <div class="alert alert-error">
                                        <span>${kcSanitize(messagesPerField.get('password'))?no_esc}</span>
                                    </div>
                                </#if>
                            </div>
                        <#elseif attribute.name == "password-confirm">
                            <div class="form-group">
                                <label for="password-confirm" class="password-label">
                                    ${msg("passwordConfirm")} <#if attribute.required>*</#if>
                                </label>
                                <div class="password-input-wrapper">
                                    <input type="password" id="password-confirm" class="form-control" name="password-confirm" 
                                           autocomplete="new-password"
                                           aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                           placeholder="${msg('passwordConfirm')}" />
                                    <button type="button" class="password-visibility-toggle" onclick="togglePasswordVisibility('password-confirm')" aria-label="Toggle password confirmation visibility">
                                        <svg class="eye-open" width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M1 12S5 4 12 4s11 8 11 8-4 8-11 8S1 12 1 12z" stroke="var(--aq-text-muted)" stroke-width="2"/>
                                            <circle cx="12" cy="12" r="3" stroke="var(--aq-text-muted)" stroke-width="2"/>
                                        </svg>
                                        <svg class="eye-closed" width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" style="display: none;">
                                            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24" stroke="var(--aq-text-muted)" stroke-width="2"/>
                                            <line x1="1" y1="1" x2="23" y2="23" stroke="var(--aq-text-muted)" stroke-width="2"/>
                                        </svg>
                                    </button>
                                </div>
                                <#if messagesPerField.existsError('password-confirm')>
                                    <div class="alert alert-error">
                                        <span>${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</span>
                                    </div>
                                </#if>
                            </div>
                        </#if>
                    </#if>
                </@userProfileCommons.userProfileFormFields>

                <@registerCommons.termsAcceptance/>

                <#if recaptchaRequired??>
                    <div class="form-group">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </#if>

                <div id="kc-form-buttons">
                    <input class="btn btn-primary btn-block btn-lg" type="submit" value="${msg("doRegister")}"/>
                </div>

                <div class="back-to-login">
                    <a href="${url.loginUrl}" class="back-link">← ${msg("backToLogin")}</a>
                </div>
            </form>
        </div>

        <script>
            function togglePasswordVisibility(fieldId) {
                const field = document.getElementById(fieldId);
                const button = field.nextElementSibling;
                const eyeOpen = button.querySelector('.eye-open');
                const eyeClosed = button.querySelector('.eye-closed');
                
                if (field.type === 'password') {
                    field.type = 'text';
                    eyeOpen.style.display = 'none';
                    eyeClosed.style.display = 'block';
                } else {
                    field.type = 'password';
                    eyeOpen.style.display = 'block';
                    eyeClosed.style.display = 'none';
                }
            }
        </script>
    </#if>
</@layout.registrationLayout>