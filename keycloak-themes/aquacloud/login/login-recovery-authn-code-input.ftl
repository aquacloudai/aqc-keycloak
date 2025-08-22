<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Use Recovery Code</h1>
            <p class="welcome-subtitle">Enter one of your backup recovery codes to sign in.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <form id="kc-recovery-code-form" action="${url.loginAction}" method="post">
                <div class="form-group recovery-form-group">
                    <label for="recovery-authn-code" class="recovery-label">Recovery Code</label>
                    <input id="recovery-authn-code" 
                           name="recovery-authn-code" 
                           autocomplete="off" 
                           type="text" 
                           class="form-control recovery-input" 
                           autofocus 
                           placeholder="Enter recovery code"
                           pattern="[A-Za-z0-9\-]{8,16}"/>
                    <div class="recovery-help-text">
                        Recovery codes are typically 8-16 characters long and may contain letters, numbers, and dashes.
                    </div>
                </div>

                <div id="kc-form-buttons">
                    <input class="btn btn-primary btn-block btn-lg" 
                           type="submit" 
                           value="Sign In with Recovery Code"/>
                </div>
            </form>
            
            <div class="auth-alternatives">
                <div class="alternative-methods">
                    <p>Try another way:</p>
                    <a href="${url.loginUrl}" class="alt-method-link">← Use authenticator app</a>
                </div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>