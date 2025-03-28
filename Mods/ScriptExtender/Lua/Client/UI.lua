function MHMain(mhMCM)

    if MHMain ~= nil then return end
    MHMain = mhMCM

    mhw = Ext.IMGUI.NewWindow("Move Here")
    mhw.Open = false

    mhw.OnClose = function ()
        mhw.Open = false
    end

    -- dhw:SetSize({545, 500})
    mhw.AlwaysAutoResize = true
    mhw.NoResize = false
    mhw.Closeable = true
    mhw.NoScrollbar = true

    MCM.SetKeybindingCallback('mh_toggle_window', function()
        mhw.Open = not mhw.Open
    end)


    MHIguiWindow(mhw)


    local openMH = mhMCM:AddButton("Open")
    openMH.IDContext = "openButton2"
    openMH.SameLine = false
    openMH.OnClick = function()
        mhw.Open = not mhw.Open
    end
    

    local styleCombo = mhMCM:AddCombo("Style")
    styleCombo.IDContext = "StyleSwitchCombo2"
    styleCombo.Options = StyleNames
    styleCombo.SelectedIndex = styleSettings.selectedStyle - 1

    styleCombo.OnChange = function(combo)
        styleSettings.selectedStyle = combo.SelectedIndex + 1
        ApplyStyle(mhw, styleSettings.selectedStyle)
        SaveSettings()
    end


    ApplyStyle(mhw, styleSettings.selectedStyle)

end

function MHIguiWindow(mhw)

    ViewportSize = Ext.IMGUI.GetViewportSize()
    mhw:SetPos({ViewportSize[1]/6, ViewportSize[2]/10})

    stepMod = 1500
    -- local stepModifier = mhw:AddInputScalar("Mod", 100)
    -- stepModifier.IDContext = "mod"
    -- stepModifier.SameLine = false
    -- stepModifier.OnChange = function(value)
    --     stepMod = stepModifier.Value[1]
    -- end


    local sepa = mhw:AddSeparatorText("Position")


    local stemModSlider = mhw:AddSliderInt("Mod", 0, 1, 3000, 1) --default, min, max, step
    stemModSlider.IDContext = "modSlider"
    stemModSlider.SameLine = false
    stemModSlider.Components = 1
    stemModSlider.Value = {1500, 0, 0, 0}
    stemModSlider.OnChange = function()
        stepMod = stemModSlider.Value[1]
    end
    
    local posX = mhw:AddSlider("W/E", 0, -100, 100, 1)
    posX.IDContext = "sliderX"
    posX.SameLine = false
    posX.Components = 1
    posX.Value = {0, 0, 0, 0}
    posX.OnChange = function()
        local value = posX.Value[1]
        MoveCharacter("x", value, stepMod)
        posX.Value = {0, 0, 0, 0}
    end
    
    local posY = mhw:AddSlider("D/U", 0, -100, 100, 1)
    posY.IDContext = "sliderY"
    posY.SameLine = false
    posY.Components = 1
    posY.Value = {0, 0, 0, 0}
    posY.OnChange = function()
        local value = posY.Value[1]
        MoveCharacter("y", value, stepMod)
        posY.Value = {0, 0, 0, 0}
    end
    
    local posZ = mhw:AddSlider("S/N", 0, -100, 100, 1)
    posZ.IDContext = "sliderZ"
    posZ.SameLine = false
    posZ.Components = 1
    posZ.Value = {0, 0, 0, 0}
    posZ.OnChange = function()
        local value = posZ.Value[1]
        MoveCharacter("z", value, stepMod)
        posZ.Value = {0, 0, 0, 0}
    end
    
    local sepa = mhw:AddSeparatorText("Rotation")

    rotMod = 1500
    local rotationModSlider = mhw:AddSliderInt("Mod", 0, 1, 3000, 1)
    rotationModSlider.IDContext = "rotModSlider"
    rotationModSlider.SameLine = false
    rotationModSlider.Components = 1
    rotationModSlider.Value = {1500, 0, 0, 0}
    rotationModSlider.OnChange = function()
        rotMod = rotationModSlider.Value[1]
    end
    
    local rotX = mhw:AddSlider("Pitch", 0, -100, 100, 1)
    rotX.IDContext = "rotX"
    rotX.SameLine = false
    rotX.Components = 1
    rotX.Value = {0, 0, 0, 0}
    rotX.OnChange = function()
        local value = rotX.Value[1]
        RotateCharacter("x", value, rotMod)
        rotX.Value = {0, 0, 0, 0}
    end
    
    local rotY = mhw:AddSlider("Yaw", 0, -100, 100, 1)
    rotY.IDContext = "rotY"
    rotY.SameLine = false
    rotY.Components = 1
    rotY.Value = {0, 0, 0, 0}
    rotY.OnChange = function()
        local value = rotY.Value[1]
        RotateCharacter("y", value, rotMod)
        rotY.Value = {0, 0, 0, 0}
    end
    
    local rotZ = mhw:AddSlider("Roll", 0, -100, 100, 1)
    rotZ.IDContext = "rotZ"
    rotZ.SameLine = false
    rotZ.Components = 1
    rotZ.Value = {0, 0, 0, 0}
    rotZ.OnChange = function()
        local value = rotZ.Value[1]
        RotateCharacter("z", value, rotMod)
        rotZ.Value = {0, 0, 0, 0}
    end
    
    local resetRot = mhw:AddButton("Reset")
    resetRot.IDContext = "resetrot"
    resetRot.SameLine = false
    resetRot.OnClick = function()
        _C().Visual.Visual.WorldTransform.RotationQuat = {0.0, 0.5, 0.0, 0.8}
    end

    local sepa = mhw:AddSeparatorText("Saving loading")


    local savePosBtn = mhw:AddButton("Save")
    savePosBtn.IDContext = "savepos"
    savePosBtn.SameLine = false
    savePosBtn.OnClick = function()
        SavePos()
    end
    
    local loadPosBtn = mhw:AddButton("Load")
    loadPosBtn.IDContext = "locadpos"
    loadPosBtn.SameLine = true
    loadPosBtn.OnClick = function()
        LoadPos()
    end

    -- local sepa = mhw:AddSeparatorText("Scale")
    

    -- local scaleAllSlider = mhw:AddSlider("", 0, -100, 100, 0.001)
    --     scaleAllSlider.OnChange = function(value)
    --         SliderChange(value, function(step) 
    --            ChangeObjectScale("x", step)
    --            ChangeObjectScale("y", step)
    --            ChangeObjectScale("z", step)
    --        end, 0.001)
    --    end
       
    --     local resetAllScaleButton = mhw:AddButton("Reset all axes")
    --     resetAllScaleButton.SameLine = true
    --     resetAllScaleButton.OnClick = function()
    --     resetObjectScale()
    --    end
   
    --    -- Individual axes sliders _ai
    --    local scaleZSlider = mhw:AddSlider("", 0, -100, 100, 0.001)
    --    scaleZSlider.OnChange = function(value)
    --        SliderChange(value, function(step) ChangeObjectScale("z", step) end, 0.001)
    --    end
       
    --    local resetScaleZButton = mhw:AddButton("Reset length")
    --    resetScaleZButton.SameLine = true
    --    resetScaleZButton.OnClick = function()
    --        resetObjectScaleAxis("z")
    --    end
   
    --    local scaleYSlider = mhw:AddSlider("", 0, -100, 100, 0.001)
    --    scaleYSlider.OnChange = function(value)
    --        SliderChange(value, function(step) ChangeObjectScale("y", step) end, 0.001)
    --    end
       
    --    local resetScaleYButton = mhw:AddButton("Reset height")
    --    resetScaleYButton.SameLine = true
    --    resetScaleYButton.OnClick = function()
    --        resetObjectScaleAxis("y")
    --    end
   
    --    local scaleXSlider = mhw:AddSlider("", 0, -200, 200, 0.001)
    --    scaleXSlider.OnChange = function(value)
    --        SliderChange(value, function(step) ChangeObjectScale("x", step) end, 0.001)
    --    end
       
    --    local resetScaleXButton = mhw:AddButton("Reset width")
    --    resetScaleXButton.SameLine = true
    --    resetScaleXButton.OnClick = function()
    --        resetObjectScaleAxis("x")
    --    end
   
    --    local resetScaleButton = mhw:AddButton("Reset all")
    --    resetScaleButton.OnClick = function()
    --        resetObjectScale()
    --    end
    
end

Mods.BG3MCM.IMGUIAPI:InsertModMenuTab(ModuleUUID, "Move Here", MHMain)