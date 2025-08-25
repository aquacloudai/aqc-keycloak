<#macro userProfileFormFields>
    <#assign currentGroup="">

    <#list profile.attributes as attribute>
        <#assign groupName = attribute.group!"">
        <#if groupName != currentGroup>
            <#assign currentGroup=groupName>
            <#if currentGroup != "">
                <div class="pf-c-form__group-label">
                    <div class="pf-c-form__group-label-main">
                        <label class="pf-c-form__label" for="${groupName}">
                            <span class="pf-c-form__label-text">${advancedMsg(groupName)!groupName}</span>
                        </label>
                    </div>
                </div>
            </#if>
        </#if>

        <#nested "beforeField" attribute>

        <div class="form-group">
            <#assign fieldType = (attribute.html5DataType)!"">
            <#if fieldType == "datetime-local">
                <#assign fieldType = "datetime-local">
            <#elseif fieldType == "time">
                <#assign fieldType = "time">
            <#elseif fieldType == "date">
                <#assign fieldType = "date">
            <#else>
                <#assign fieldType = "text">
            </#if>

            <label for="${attribute.name}" class="form-label">
                ${advancedMsg(attribute.displayName!'')!attribute.name}
                <#if attribute.required>*</#if>
            </label>

            <#if attribute.annotations.inputType?? && attribute.annotations.inputType == "textarea">
                <textarea id="${attribute.name}" name="${attribute.name}" 
                          class="form-control <#if messagesPerField.existsError('${attribute.name}')>error</#if>"
                          aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
                          <#if attribute.readOnly>disabled</#if>
                          <#if attribute.autocomplete?has_content>autocomplete="${attribute.autocomplete}"</#if>
                          placeholder="${advancedMsg(attribute.displayName!'')!attribute.name}">${(attribute.value!'')}</textarea>
            <#else>
                <input type="${fieldType}" id="${attribute.name}" name="${attribute.name}" 
                       value="${(attribute.value!'')}" 
                       class="form-control <#if messagesPerField.existsError('${attribute.name}')>error</#if>"
                       aria-invalid="<#if messagesPerField.existsError('${attribute.name}')>true</#if>"
                       <#if attribute.readOnly>disabled</#if>
                       <#if attribute.autocomplete?has_content>autocomplete="${attribute.autocomplete}"</#if>
                       placeholder="${advancedMsg(attribute.displayName!'')!attribute.name}" />
            </#if>

            <#if messagesPerField.existsError('${attribute.name}')>
                <div class="alert alert-error">
                    <span>${kcSanitize(messagesPerField.get('${attribute.name}'))?no_esc}</span>
                </div>
            </#if>
        </div>

        <#nested "afterField" attribute>
    </#list>
</#macro>