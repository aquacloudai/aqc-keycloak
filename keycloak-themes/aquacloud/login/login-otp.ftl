<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Two-Factor Authentication</h1>
            <p class="welcome-subtitle">Please enter your authentication code from your authenticator app.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                <div class="form-group otp-form-group">
                    <label for="otp" class="otp-label">Authentication Code</label>
                    <input id="otp" 
                           name="otp" 
                           autocomplete="off" 
                           type="text" 
                           class="form-control otp-input" 
                           autofocus 
                           placeholder="000000"
                           maxlength="6"
                           pattern="[0-9]{6}"
                           inputmode="numeric"/>
                    <div class="otp-help-text">
                        Enter the 6-digit code from your authenticator app
                    </div>
                </div>

                <div id="kc-form-buttons">
                    <input class="btn btn-primary btn-block btn-lg" 
                           name="login" 
                           id="kc-login" 
                           type="submit" 
                           value="Verify"/>
                </div>
            </form>
            
            <div class="back-to-login">
                <a href="${url.loginUrl}" class="back-link">← Back to login</a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>