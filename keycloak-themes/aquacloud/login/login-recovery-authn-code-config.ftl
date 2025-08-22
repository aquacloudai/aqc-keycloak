<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <h1 class="welcome-title">Setup Recovery Codes</h1>
            <p class="welcome-subtitle">Generate backup codes to access your account if you lose your authenticator.</p>
            
            <#if message?has_content && (message.type != 'success')>
                <div class="alert alert-${message.type}">
                    <span>${kcSanitize(message.summary)?no_esc}</span>
                </div>
            </#if>
            
            <div class="recovery-setup-container">
                <div class="recovery-info">
                    <div class="info-box">
                        <h3>About Recovery Codes</h3>
                        <ul>
                            <li>Each recovery code can only be used once</li>
                            <li>Store these codes in a safe place</li>
                            <li>You can use them to sign in if you lose access to your authenticator</li>
                            <li>Generate new codes anytime from your account settings</li>
                        </ul>
                    </div>
                </div>
                
                <form action="${url.loginAction}" method="post">
                    <div id="kc-form-buttons">
                        <input class="btn btn-primary btn-block btn-lg" 
                               type="submit" 
                               value="Generate Recovery Codes"/>
                        <a class="btn btn-secondary btn-block" 
                           href="${url.loginAction}">Skip for now</a>
                    </div>
                </form>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>