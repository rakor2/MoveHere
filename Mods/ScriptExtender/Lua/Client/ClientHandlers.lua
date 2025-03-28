function MoveCharacter(axis, value, stepMod)

    pos = _C().Visual.Visual.WorldTransform.Translate

    if axis == 'x' then
        pos.x = value
        pos[1] = pos[1] + (pos.x/stepMod)
    elseif axis == 'y' then
        pos.y = value
        pos[2] = pos[2] + (pos.y/stepMod)
    elseif axis == 'z' then
        pos.z = value
        pos[3] = pos[3] + (pos.z/stepMod)
    end

    _C().Visual.Visual.WorldTransform.Translate = {pos[1], pos[2], pos[3]}

end


---All my homies hate mathing quats
-------------------------------------------------------------------AI{
function RotateCharacter(axis, value, rotMod)

    local rot = _C().Visual.Visual.WorldTransform.RotationQuat
    local currentQuat = {rot[1], rot[2], rot[3], rot[4]}
    
    local rotationAngle = value / rotMod
    local axisVec = {0, 0, 0}
    
    if axis == 'x' then
        axisVec = {1, 0, 0}
    elseif axis == 'y' then
        axisVec = {0, 1, 0}
    elseif axis == 'z' then
        axisVec = {0, 0, 1}
    end

    local quatToAngle = Ext.Math.QuatRotateAxisAngle(currentQuat, axisVec, rotationAngle)
    
    _C().Visual.Visual.WorldTransform.RotationQuat = quatToAngle

end
--------------------------------------------------------------------}

function SavePos()
    posSaved = _C().Visual.Visual.WorldTransform.Translate
    rotSaved = _C().Visual.Visual.WorldTransform.RotationQuat
    return posSaved, rotSaved
end

function LoadPos()
    _C().Visual.Visual.WorldTransform.Translate = posSaved
    _C().Visual.Visual.WorldTransform.RotationQuat = rotSaved
end