<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "form">
        <div class="login-container">
            <div class="aquacloud-logo-container">
                <img src="${url.resourcesPath}/img/logo.png" alt="AquaCloud" class="aquacloud-logo">
            </div>
            
            <div class="error-container">
                <div class="error-icon">
                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="12" r="10" stroke="#dc2626" stroke-width="2"/>
                        <line x1="15" y1="9" x2="9" y2="15" stroke="#dc2626" stroke-width="2"/>
                        <line x1="9" y1="9" x2="15" y2="15" stroke="#dc2626" stroke-width="2"/>
                    </svg>
                </div>
                
                <h1 class="error-title">Something went wrong</h1>
                
                <#if message?has_content>
                    <div class="error-message">
                        ${kcSanitize(message.summary)?no_esc}
                    </div>
                <#else>
                    <div class="error-message">
                        An unexpected error occurred. Please try again or contact support if the problem persists.
                    </div>
                </#if>
                
                <div class="error-actions">
                    <a href="${url.loginUrl}" class="btn btn-primary">
                        Try Again
                    </a>
                    <a href="${url.loginUrl}" class="btn btn-secondary">
                        Back to Login
                    </a>
                </div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>