<#macro termsAcceptance>
    <#if termsAcceptanceRequired??>
        <div class="form-group terms-acceptance">
            <div class="checkbox-wrapper">
                <input type="checkbox" id="termsAccepted" name="termsAccepted" class="checkbox-input" required>
                <label for="termsAccepted" class="checkbox-label">
                    <span class="checkbox-custom"></span>
                    <span class="checkbox-text">
                        ${msg("termsTitle")}
                        <#if kcSanitize(msg("termsText"))?has_content>
                            <a href="#" onclick="window.open('${termsUrl}', 'terms', 'width=600,height=500,scrollbars=yes'); return false;" class="terms-link">
                                ${msg("termsText")}
                            </a>
                        </#if>
                    </span>
                </label>
            </div>
        </div>
    </#if>
</#macro>