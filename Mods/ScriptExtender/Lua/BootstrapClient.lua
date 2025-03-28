Ext.Require("Shared/_init.lua")
Ext.Require("Client/_init.lua")

ModuleUUID = "19b3d5e4-571c-e513-0669-74ccb70d6479"

function SaveSettings()

    settings = {
        savedStyle = styleSettings.selectedStyle
    }

    json = Ext.Json.Stringify(settings)

    Ext.IO.SaveFile("MoveHere/Settings.json", json)
end

local function LoadSettings()
    local json = Ext.IO.LoadFile("MoveHere/Settings.json")
    if json then
        local settings = Ext.Json.Parse(json)
        if settings and settings.savedStyle then
            styleSettings.selectedStyle = settings.savedStyle
        end
    end
end


LoadSettings()

Ext.Require("Client/_init.lua")

MHMain = nil
