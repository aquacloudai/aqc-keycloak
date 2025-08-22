<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Reset Password</h1>
            <p class="welcome-subtitle">Enter your email address and we'll send you a link to reset your password.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <form id="kc-reset-password-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                <div class="form-group">
                    <label for="username" class="reset-label">Email Address</label>
                    <input type="text" 
                           id="username" 
                           name="username" 
                           class="form-control" 
                           autofocus 
                           value="${(auth.attemptedUsername!'')}"
                           placeholder="name@company.com" />
                </div>

                <div id="kc-form-buttons">
                    <input class="btn btn-primary btn-block btn-lg" 
                           type="submit" 
                           value="Send Reset Link"/>
                </div>
            </form>
            
            <div class="back-to-login">
                <a href="${url.loginUrl}" class="back-link">← Back to login</a>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>