---AahzLib
---Ext.OnNextTick, but variable ticks
---@param ticks integer
---@param fn function
function TickTimer(ticks, fn)
    local ticksPassed = 0
    local eventID
    eventID = Ext.Events.Tick:Subscribe(function()
        ticksPassed = ticksPassed + 1
        if ticksPassed >= ticks then
            fn()
            Ext.Events.Tick:Unsubscribe(eventID)
        end
    end)
end






---YL



--Extracts name from a template, S_Player_ShadowHeart_3ed74f06-3c60-42dc-83f6-f034cb47c679 will return Player ShadowHeart
--Osi.DisplayName or whatever is bad, becasuse for some templates (most of them) it returns simple names like Elf or Goblin
---@param templateName string
---@return string
function ExtractDisplayName(templateName)
    if not templateName or templateName == "" then
        return "Unknown"
    end
    
    templateName = templateName:gsub("_%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$", "")

    local prefixes = {"S_", "GLO_", "BASE_", "GOB_", "LOW_", "CINE_", "FOR_", "WYR_", "PUZ_", "CAMP_", "CAMP_",
    "GUS_", "QUEST_", "ORIGIN_", "UNI_", "TEST_", "LOOT_", "TUT_", "WLD_", "INTRO_", "UND_", "EPI_", "TEMP_",
    "MOO_", "END_", "CAMP_", "CAMP_", "TWN_", "PLA_", "COL_", "SCL_"}
    for _, prefix in ipairs(prefixes) do
        if templateName:sub(1, #prefix) == prefix then
            templateName = templateName:sub(#prefix + 1)
        end
    end
    
    for _, prefix in ipairs(prefixes) do
        if templateName:sub(1, #prefix) == prefix then
            templateName = templateName:sub(#prefix + 1)
        end
    end

    templateName = templateName:gsub("_", " ")
    
    return templateName
end




--Shorts UUIDs.
---@param uuid string
---@param howmuchleft number
---@return ShortUuid string
function UUIDShortner(uuid, howmuchleft)
    if type(uuid) ~= "string" then
        return "?"
    end
    
    return string.sub(uuid, 1, howmuchleft)
end




--Gets templates by type
---@param type string
---@return string
function GetTemplates(type)
    templatesCache = {}
    if templatesCache[type] then
        return templatesCache[type]
    end

    local templates = Ext.Template.GetAllRootTemplates()
    
    local vanillaTemplates = {}
    for _, templateData in pairs(templates) do
        if templateData.TemplateType == type then
            table.insert(vanillaTemplates, templateData)
        end
    end
    
    templatesCache[type] = vanillaTemplates
    return vanillaTemplates
end