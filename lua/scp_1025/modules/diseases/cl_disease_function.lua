-- SCP-1025, A representation of a paranormal object on a fictional series on the game Garry's Mod.
-- Copyright (C) 2024  MrMarrant aka BIBI.

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

--[[
* Create a froze effect clientside.
* @Player ply The player.
--]]
local function FrozeEffect(ply)
    local frozePlayer = {}
    for _, playerGet in ipairs(player.GetAll()) do
        if playerGet != ply and playerGet:Alive() then
            frozePlayer[playerGet] = {
                pos = playerGet:GetPos(),
                ang = playerGet:EyeAngles()
            }
        end
    end

    hook.Add("PostPlayerDraw", "PostPlayerDraw.SCP1025.FrozeEffect", function(drawPly)
        if frozePlayer[drawPly] then
            local data = frozePlayer[drawPly]
            drawPly:SetPos(data.pos)
            drawPly:SetEyeAngles(data.ang)
        end
    end)
end

--[[
* Display a moving text for the player.
* @Player ply The player.
--]]
local function DisplayMovingText(ply)
    local maxDialog = SCP_1025_CONFIG.SchizophreniaMaxDialog
    local durationTotalSpeaking = SCP_1025_CONFIG.SchizophreniaDurationSpeaking
    local duration = durationTotalSpeaking / maxDialog
    local index = 1
    local textTodisplay = {}
    local dialogVersion = math.random(1, maxDialog)
    for var = 1, 4 do
        textTodisplay[var] = scp_1025.GetTranslation("schizophrenia_talking_voice_v" .. dialogVersion .. "_" .. var)
    end

    timer.Create("SCP1025.Schizophrenia.Talking", duration + 1, maxDialog, function()
        if (not IsValid(ply)) then return end
        if (not ply:Alive()) then return end

        local movingPanelText = vgui.Create("DPanel.SCP1025.MovingText")
        movingPanelText:SetInitValue(textTodisplay[index], duration)
        ply.scp_1025_MovingPanel = movingPanelText
        if (index == 1) then timer.Adjust("SCP1025.Schizophrenia.Talking", duration) end
        if (index == maxDialog) then ply:StopSound(SCP_1025_CONFIG.Sounds.TalkingVoice) end
        index = index + 1
    end)
end

--[[
* Get most of entites in a radius define around an entity.
* @Vector pos The position.
* @number radius The radius.
* @Entity ent The entity.
--]]
local function GetInSphereEnts(pos, radius, ent)
    local entsFound = ents.FindInSphere(pos, radius)
    local tableFilter = {}
    if (ent) then
        for key, value in ipairs(entsFound) do
            if (value != ent and (value:IsPlayer() or value:IsNPC() or value:IsNextBot() or value:GetClass() == "prop_physics")) then
                table.insert(tableFilter, value)
            end
        end
    end
    return tableFilter, entsFound
end

--[[
* Return a random number of elements from a table.
* @table tbl The table.
* @number numElements The number of elements to return in the table.
--]]
local function GetRandomElementsFromTable(tbl, numElements)
    if not istable(tbl) or #tbl == 0 then
        return {}
    end

    numElements = math.min(numElements, #tbl)
    local tempTable = table.Copy(tbl)
    local selectedElements = {}

    for i = 1, numElements do
        local randomIndex = math.random(1, #tempTable)
        table.insert(selectedElements, tempTable[randomIndex])
        table.remove(tempTable, randomIndex)
    end

    return selectedElements
end

--[[
* Return a random number of elements from a table.
* @table tbl The table.
* @number numElements The number of elements to return in the table.
--]]
local function SetRandomModel(tbl)
    local modelsPlayer = table.Copy(SCP_1025_CONFIG.Settings.SchizophreniaModelsPlayer)
    local modelsProps = table.Copy(SCP_1025_CONFIG.Settings.SchizophreniaModelsProps)

    for key, value in ipairs(tbl) do
        value.scp_1025_OldModel = value:GetModel()
        if (value:IsPlayer() or value:IsNPC() or value:IsNextBot()) then
            value:SetModel(modelsPlayer[math.random(#modelsPlayer)])
        else
            value:SetModel(modelsProps[math.random(#modelsProps)])
        end
    end
end

--[[
* Make every ent in the table return to their old model.
* @table tbl The table.
--]]
local function ResetModel(tbl)
    for key, value in ipairs(tbl) do
        if (value.scp_1025_OldModel) then
            value:SetModel(value.scp_1025_OldModel)
        end
    end
end

--[[
* Display a text for the player.
* @Player ply The player to display the text.
* @string index The index translation.
--]]
local function ChatPrint(ply, index)
    ply:ChatPrint(scp_1025.GetTranslation(index))
end

--[[
* Play a sound for the player.
* @Player ply The player to set the disease.
* @string soundName The name of the sound.
--]]
local function PlaySoundClient(ply, soundName, loop)
    loop = loop or false
    if (loop) then ply:StartLoopingSound(soundName)
    else ply:EmitSound(soundName, 75, math.random( 90, 110 )) end
end

--[[
* Create a blur effect for the player.
* @Player ply The player to set the disease.
* @number duration The duration of the blur effect.
--]]
function scp_1025.CreateBlurEffect(ply, duration, sfx)
    sfx = sfx or false
    hook.Add( "RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.CreateBlurEffect", function()
        DrawMotionBlur( 0.4, 0.8, 0.01 )
    end )
    timer.Create("SCP1025.BlurEffect", duration, 1, function()
        hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.CreateBlurEffect")
    end)
    if (sfx) then ply:EmitSound(SCP_1025_CONFIG.Sounds.Dizzy, 75, math.random( 90, 110 )) end
end

--[[
* Create a blink eye effect for the player.
* @number duration The duration of the blink eye effect.
* @boolean oneSide If the blink eye effect is only on one side.
* @boolean wasClose If the blink eye effect is close.
--]]
function scp_1025.CreateBlinkEye(duration, oneSide, wasClose)
    --? Clear all previous blink eye effect.
    hook.Remove("Think", "Think.SCP1025.CreateBlinkEye")
    hook.Remove("HUDPaint", "HUDPaint.SCP1025.CreateBlinkEye")

    local w = SCP_1025_CONFIG.ScrW
    local h = SCP_1025_CONFIG.ScrH
    local minUp = -0.5
    local maxUp = 0
    local minDown = 1
    local maxDown = 0.5
    local currentUp = minUp
    local currentDown = minDown
    oneSide = oneSide or false
    wasClose = wasClose or false

    hook.Add("HUDPaint", "HUDPaint.SCP1025.CreateBlinkEye", function()
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, h * currentUp, w, h * 0.5)
        surface.DrawRect(0, h * currentDown, w, h * 0.5)
    end)

    local startTime = CurTime()

    hook.Add("Think", "Think.SCP1025.CreateBlinkEye", function()
        local currentTime = CurTime()
        local progress = math.Clamp((currentTime - startTime) / duration, 0, 1)
        if (wasClose) then
            currentUp = Lerp(progress, maxUp, minUp)
            currentDown = Lerp(progress, maxDown, minDown)
        else
            currentUp = Lerp(progress, minUp, maxUp)
            currentDown = Lerp(progress, minDown, maxDown)
        end

        if progress >= 1 then
            if (not wasClose and not oneSide) then
                wasClose = true
                startTime = CurTime()
                progress = 0
            elseif (not oneSide) then
                hook.Remove("Think", "Think.SCP1025.CreateBlinkEye")
            end
        end
    end)
end

--[[
* Clear the diseases for the player.
* @Player ply The player to clear diseases.
--]]
function scp_1025.ClearDiseases(ply)
    if not (IsValid(ply)) then return end

    timer.Remove("SCP1025.BlurEffect")
    timer.Remove("SCP1025.SchizophreniaEndCrisis")
    timer.Remove("SCP1025.Schizophrenia.Talking")
    timer.Remove("SCP1025.WriterBlock.EPITAPH")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.CreateBlurEffect")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.RabiesPhase3")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.StartSchizophreniaCrisis")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.SchizophreniaCrisis")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.DOYOUHEARIT")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.WriterBlock")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.Paranoid")
    hook.Remove("PreDrawHalos", "PreDrawHalos.SCP1025.SchizophreniaCrisis")
    hook.Remove("PostPlayerDraw", "PostPlayerDraw.SCP1025.FrozeEffect")
    hook.Remove("Think", "Think.SCP1025.Myopia")
    hook.Remove("Think", "Think.SCP1025.CreateBlinkEye")
    hook.Remove("HUDPaint", "HUDPaint.SCP1025.CreateBlinkEye")
    ply:ConCommand("pp_dof 0")
    ply:StopSound(SCP_1025_CONFIG.Sounds.HalluSchizophreniaCrisis)
    ply:StopSound(SCP_1025_CONFIG.Sounds.TalkingVoice)
    ply:StopSound(SCP_1025_CONFIG.Sounds.SOMETHINGWRICKED)
    ply:StopSound(SCP_1025_CONFIG.Sounds.EPITAPH)
    scp_1025.DeletePage()

    if (ply.scp_1025_MovingPanel) then
        ply.scp_1025_MovingPanel:Remove()
    end

    if (ply.scp_1025_EntsSchizophrenia) then
        ResetModel(ply.scp_1025_EntsSchizophrenia)
    end
    ply.scp_1025_EntsSchizophrenia = nil
    ply.scp_1025_MovingPanel = nil
    ply.scp_1025_WriterBlock = nil
    ply.scp_1025_Paranoid = nil
end

--[[
* Set the myopia for the player.
* @Player ply The player to set the myopia.
--]]
function scp_1025.Myopia(ply)
    hook.Add( "Think", "Think.SCP1025.Myopia", function()
        if (not IsValid(ply)) then return end

        ply:ConCommand("pp_dof_initlength 10")
        ply:ConCommand("pp_dof_spacing 100")
        ply:ConCommand("pp_dof 1")
    end)
end

--[[
* Create a blink effect and blur for the player.
* @Player ply The player to set the myopia.
--]]
function scp_1025.KleineLevin(ply)
    scp_1025.CreateBlinkEye(SCP_1025_CONFIG.Settings.KleineLevinDurationBlink)
    scp_1025.CreateBlurEffect(ply, 2)
end

--[[
* Apply an overlay to the player that progressively changes the color of the screen.
* @Player ply The player to set the overlay.
--]]
function scp_1025.RabiesPhase3(ply)
    local tab = table.Copy(SCP_1025_CONFIG.Settings.DefaultColorModify)
    local colorToReach = SCP_1025_CONFIG.Settings.ColorColorToReach
    local fromColor = tab["$pp_colour_colour"]
    local startTime = CurTime()
    local duration = SCP_1025_CONFIG.Settings.RabiesPhase3Duration

    hook.Add( "RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.RabiesPhase3", function()
        local currentTime = CurTime()
        local progress = math.Clamp((currentTime - startTime) / duration, 0, 1)

        tab["$pp_colour_colour"] = Lerp(progress, fromColor, colorToReach)
        DrawMaterialOverlay("models/props_lab/tank_glass001", 0.01)
        DrawColorModify(tab)
    end )
end

--[[
* Apply moving text, special overlay and halo effect to nearby entities.
* @Player ply The player to set the design.
--]]
function scp_1025.SchizophreniaCrisis(ply)
    local startTimeCrisis = CurTime()
    local durationStart = 5
    local colorsa = table.Copy(SCP_1025_CONFIG.Settings.DefaultColorCrisis)
    local totalDuration = SCP_1025_CONFIG.Settings.SchizophreniaDurationCrisis

    ply:EmitSound(SCP_1025_CONFIG.Sounds.HalluSchizophreniaCrisis, 75, math.random( 90, 110 ))
    ChatPrint(ply, "schizophrenia_crisis")
    scp_1025.CreateBlurEffect(ply, totalDuration, SCP_1025_CONFIG.Sounds.Dizzy)

    hook.Add( "RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.StartSchizophreniaCrisis", function()
        local currentTime = CurTime()
        local progress = math.Clamp((currentTime - startTimeCrisis) / durationStart, 0, 1)

        colorsa["$pp_colour_brightness"] = Lerp(progress, 10, -0.3)
        if (progress >= 1) then
            DisplayMovingText(ply)
            hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.StartSchizophreniaCrisis")
        end
        DrawColorModify(colorsa)
    end )

    local startTime = CurTime()
    local variance = SCP_1025_CONFIG.Settings.SchizophreniaVariance
    local from = 5
    local to = 10
    local firstSide = true

    hook.Add("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.SchizophreniaCrisis", function()
        local currentTime = CurTime()
        local progress = math.Clamp((currentTime - startTime) / variance, 0, 1)

        if (firstSide) then
            colorsa["$pp_colour_contrast"] = Lerp(progress, from, to)
        else
            colorsa["$pp_colour_contrast"] = Lerp(progress, to, from)
        end
        if (progress >= 1) then
            startTime = CurTime()
            progress = 0
            firstSide = not firstSide
        end
        DrawColorModify(colorsa)
    end)

    local color = SCP_1025_CONFIG.Settings.SchizophreniaColorHalo
    local delayHalo = SCP_1025_CONFIG.Settings.SchizophreniaDelayHalo
    local radius = SCP_1025_CONFIG.Settings.SchizophreniaRadiusHalo
    local CurT = CurTime()
    local durationHalo = CurT + delayHalo
    local entsFound = GetRandomElementsFromTable(GetInSphereEnts(ply:GetPos(), radius, ply), 10)
    ply.scp_1025_EntsSchizophrenia = entsFound
    SetRandomModel(entsFound)

    hook.Add( "PreDrawHalos", "PreDrawHalos.SCP1025.SchizophreniaCrisis", function()
        if (not IsValid(ply)) then return end

        CurT = CurTime()
        if (CurT > durationHalo) then
            if (entsFound) then ResetModel(entsFound) end
            entsFound = GetRandomElementsFromTable(GetInSphereEnts(ply:GetPos(), radius, ply), 10)
            ply.scp_1025_EntsSchizophrenia = entsFound
            SetRandomModel(entsFound)
            durationHalo = CurT + delayHalo
        end
        halo.Add( entsFound, color, 1, 1, 2 )
    end)

    timer.Create("SCP1025.SchizophreniaEndCrisis", totalDuration, 1, function()
        hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.SchizophreniaCrisis")
        hook.Remove("PreDrawHalos", "PreDrawHalos.SCP1025.SchizophreniaCrisis")
        ply:StopSound(SCP_1025_CONFIG.Sounds.HalluSchizophreniaCrisis)
    end)
end

--[[
* ARE WE FUN ALREADY?
* @Player ply YEAAAAAAAA, THIS GUY IS FUNNY
--]]
function scp_1025.WriterBlock(ply)
    ply.scp_1025_WriterBlock = true
    ply:StartLoopingSound(SCP_1025_CONFIG.Sounds.SOMETHINGWRICKED)
end

--[[
* GET THE FUCK FROM HERE
* @Player ply PARANOIA IS THE NEW DISEASE
--]]
function scp_1025.DOYOUHEARIT(ply)
    local tab = table.Copy(SCP_1025_CONFIG.Settings.WriterBlockColors)
    local ClModel = ClientsideModel(SCP_1025_CONFIG.Models.Writer)
    local duration = SCP_1025_CONFIG.Settings.WriterBlockDurationTalk
    local durationColor = 40
    local startTime = CurTime()
    local posAdd = 30
    ClModel:SetModelScale(1)
    ClModel:SetNoDraw(true)
    FrozeEffect(ply)

    hook.Add( "RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.DOYOUHEARIT", function()
        if (not IsValid(ply)) then return end

        local posPlayer = ply:GetPos()
        local currentTime = CurTime()
        local timePassed = currentTime - startTime
        local progress = 1 - math.Clamp(timePassed / (duration - 5), 0, 1)
        if (timePassed >= 5) then
            timeReal = timePassed - 5
            local progressColor = math.Clamp(timeReal / durationColor, 0, 0.5)
            tab["$pp_colour_contrast"] = progressColor
        end

        if (timePassed >= duration - 1) then
            local timeNewPos = timePassed - (duration - 1)
            posAdd = Lerp(timeNewPos / 1, 30, 0)
        end

        DrawColorModify(tab)
        DrawSobel(0.1)
        cam.Start3D()
            render.SetStencilEnable(true)
            render.SetStencilWriteMask(1)
            render.SetStencilTestMask(1)
            render.SetStencilReferenceValue(1)
            render.SetStencilFailOperation(STENCIL_KEEP)
            render.SetStencilZFailOperation(STENCIL_KEEP)
            render.SuppressEngineLighting(true)
            render.DepthRange(0, 0.01)
            ClModel:SetPos(posPlayer + Vector((400 * progress) + posAdd, 0, 55))
            ClModel:SetAngles(Angle(0, -90, 0))
            ClModel:DrawModel()
            render.DepthRange(0, 1)
            render.MaterialOverride()
            render.SuppressEngineLighting(false)
            render.SetStencilEnable(false)
        cam.End3D()
    end )

    ply:EmitSound(SCP_1025_CONFIG.Sounds.EPITAPH)

    timer.Create("SCP1025.WriterBlock.EPITAPH", duration, 1, function()
        hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.DOYOUHEARIT")
        hook.Remove("PostPlayerDraw", "PostPlayerDraw.SCP1025.FrozeEffect")
        ply.scp_1025_WriterBlock = nil
        net.Start(SCP_1025_CONFIG.NetVar.EndWriterBlock)
        net.SendToServer()
    end)
end

--[[
* Create a paranoid effect for the player.
* @Player ply The player to set the disease.
--]]
function scp_1025.Paranoid(ply)
    scp_1025.CreateBlurEffect(ply, 4)
    ChatPrint(ply, "paranoid")

    local startTime = CurTime()
    local tab = table.Copy(SCP_1025_CONFIG.Settings.ParanoidColors)
    local delay = SCP_1025_CONFIG.Settings.ParanoidDelayOverlay
    local to = SCP_1025_CONFIG.Settings.ParanoidToColor

    hook.Add("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.Paranoid", function()
        local currentTime = CurTime()
        local timePassed = currentTime - startTime
        local progress = math.Clamp(timePassed / delay, 0, 1)

        tab["$pp_colour_colour"] = Lerp(progress, 1, to)

        DrawColorModify(tab)
    end )
end

-- NET VARS
net.Receive(SCP_1025_CONFIG.NetVar.ClearDisease, function()
    local ply = LocalPlayer()
    scp_1025.ClearDiseases(ply)
end)

net.Receive(SCP_1025_CONFIG.NetVar.Myopia, function()
    local ply = LocalPlayer()
    scp_1025.Myopia(ply)
end)

net.Receive(SCP_1025_CONFIG.NetVar.KleineLevin, function()
    local ply = LocalPlayer()
    scp_1025.KleineLevin(ply)
end)

net.Receive(SCP_1025_CONFIG.NetVar.CreateBlinkEye, function()
    local duration = net.ReadFloat()
    local oneSide = net.ReadBool()
    local wasClose = net.ReadBool()

    scp_1025.CreateBlinkEye(duration, oneSide, wasClose)
end)

net.Receive(SCP_1025_CONFIG.NetVar.CreateBlurEffect, function()
    local ply = LocalPlayer()
    local duration = net.ReadFloat()
    local sfx = net.ReadBool()

    scp_1025.CreateBlurEffect(ply, duration, sfx)
end)

net.Receive(SCP_1025_CONFIG.NetVar.RabiesPhase3, function()
    local ply = LocalPlayer()
    scp_1025.RabiesPhase3(ply)
end)

net.Receive(SCP_1025_CONFIG.NetVar.ChatPrint, function()
    local ply = LocalPlayer()
    local index = net.ReadString()

    ChatPrint(ply, index)
end)

net.Receive(SCP_1025_CONFIG.NetVar.SchizophreniaCrisis, function()
    local ply = LocalPlayer()
    scp_1025.SchizophreniaCrisis(ply)
    DisplayMovingText(ply)
    PlaySoundClient(ply, SCP_1025_CONFIG.Sounds.HalluSchizophreniaCrisis, false)
end)

net.Receive(SCP_1025_CONFIG.NetVar.SchizophreniaTalking, function()
    local ply = LocalPlayer()
    DisplayMovingText(ply)
    PlaySoundClient(ply, SCP_1025_CONFIG.Sounds.TalkingVoice, true)
end)

net.Receive(SCP_1025_CONFIG.NetVar.WriterBlock, function()
    local ply = LocalPlayer()
    scp_1025.WriterBlock(ply)
end)

net.Receive(SCP_1025_CONFIG.NetVar.Paranoid, function()
    local ply = LocalPlayer()

    scp_1025.Paranoid(ply)
end)

net.Receive(SCP_1025_CONFIG.NetVar.ClearBlurEffect, function(len, ply)
    timer.Remove("SCP1025.BlurEffect")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.CreateBlurEffect")
end)

-- HOOKS
hook.Add("OnCloseBookSCP1025", "OnCloseBookSCP1025.SCP1025", function(ply)
    if (ply.scp_1025_WriterBlock) then
        local refract = 0
        local startTime = CurTime()
        local duration = SCP_1025_CONFIG.Settings.WriterBlockDurationOverlay
        ply:EmitSound(SCP_1025_CONFIG.Sounds.NONONONO, 90)
        hook.Add( "RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.WriterBlock", function()
            local currentTime = CurTime()
            local progress = math.Clamp((currentTime - startTime) / duration, 0, 1)
            refract = Lerp(progress, 0, 1)

            DrawMaterialOverlay("models/props_c17/fisheyelens", refract)
            if (progress >= 1) then
                hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.WriterBlock")
                ply:StopSound(SCP_1025_CONFIG.Sounds.SOMETHINGWRICKED)
                scp_1025.DOYOUHEARIT(ply)
            end
        end )
    end
end)