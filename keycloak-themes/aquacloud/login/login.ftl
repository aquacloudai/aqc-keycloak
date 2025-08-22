<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false displayMessage=true; section>
    <#if section = "header">
        <#-- Logo will be handled in the form section -->
    <#elseif section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Welcome back.</h1>
            <p class="welcome-subtitle">Log in to your account below.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="form-group">
                    <input tabindex="1" 
                           id="username" 
                           class="form-control" 
                           name="username" 
                           value="${(login.username!'')}" 
                           type="text" 
                           autofocus 
                           autocomplete="off"
                           placeholder="name@company.com" />
                </div>

                <div class="form-group">
                    <input tabindex="2" 
                           id="password" 
                           class="form-control" 
                           name="password" 
                           type="password" 
                           autocomplete="off"
                           placeholder="Password" />
                </div>

                <div id="kc-form-buttons">
                    <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                    <input tabindex="4" 
                           class="btn btn-primary btn-block btn-lg" 
                           name="login" 
                           id="kc-login" 
                           type="submit" 
                           value="Sign In"/>
                </div>
            </form>
            
            <#if realm.resetPasswordAllowed>
                <div class="reset-password-container">
                    <span class="help-text">Need help logging in? </span>
                    <a tabindex="5" href="${url.loginResetCredentialsUrl}" class="reset-link">Reset your password</a>
                </div>
            </#if>

            
        </div>
    </#if>
</@layout.registrationLayout>