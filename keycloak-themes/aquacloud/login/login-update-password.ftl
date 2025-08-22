<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Update Password</h1>
            <p class="welcome-subtitle">Please enter your new password below.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <form id="kc-passwd-update-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                <div class="form-group">
                    <label for="password-new" class="password-label">New Password</label>
                    <input type="password" 
                           id="password-new" 
                           name="password-new" 
                           class="form-control" 
                           autofocus 
                           autocomplete="new-password"
                           placeholder="Enter new password" />
                </div>

                <div class="form-group">
                    <label for="password-confirm" class="password-label">Confirm Password</label>
                    <input type="password" 
                           id="password-confirm" 
                           name="password-confirm" 
                           class="form-control"
                           autocomplete="new-password"
                           placeholder="Confirm new password" />
                </div>

                <div class="password-requirements">
                    <h4>Password Requirements:</h4>
                    <ul>
                        <li>At least 8 characters long</li>
                        <li>Contains uppercase and lowercase letters</li>
                        <li>Contains at least one number</li>
                        <li>Contains at least one special character</li>
                    </ul>
                </div>

                <div id="kc-form-buttons">
                    <input class="btn btn-primary btn-block btn-lg" 
                           type="submit" 
                           value="Update Password" />
                </div>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>