<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=true; section>
    <#if section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <div class="verify-email-container">
                <div class="verify-icon">
                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z" stroke="#5ec4cd" stroke-width="2" fill="none"/>
                        <polyline points="22,6 12,13 2,6" stroke="#5ec4cd" stroke-width="2" fill="none"/>
                    </svg>
                </div>
                
                <h1 class="verify-title">Check your email</h1>
                <p class="verify-message">
                    We've sent a verification link to <strong>${user.email}</strong>.
                    Please check your email and click the link to verify your account.
                </p>
                
                <div class="verify-actions">
                    <a href="${url.loginAction}" class="btn btn-primary">
                        I've verified my email
                    </a>
                    <a href="${url.loginUrl}" class="btn btn-secondary">
                        Back to login
                    </a>
                </div>
                
                <div class="resend-container">
                    <p class="resend-text">Didn't receive the email?</p>
                    <form action="${url.loginAction}" method="post">
                        <input type="hidden" name="action" value="resend">
                        <button type="submit" class="resend-link">Resend verification email</button>
                    </form>
                </div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>