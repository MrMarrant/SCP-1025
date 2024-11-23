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

local function ChatPrint(ply, index)
    ply:ChatPrint(scp_1025.GetTranslation(index))
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
    timer.Create("SCP1025.BlurEffect." .. ply:EntIndex(), duration, 1, function()
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

    timer.Remove("SCP1025.CommonCold." .. ply:EntIndex())
    timer.Remove("SCP1025.BlurEffect." .. ply:EntIndex())
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.CreateBlurEffect")
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025.RabiesPhase3")
    hook.Remove("Think", "Think.SCP1025.CreateBlinkEye")
    hook.Remove("HUDPaint", "HUDPaint.SCP1025.CreateBlinkEye")
    ply:ConCommand("pp_dof 0")
end

--[[
* Set the myopia for the player.
* @Player ply The player to set the myopia.
--]]
function scp_1025.Myopia(ply) -- TODO : Empecher le joueur d'utiliser la commande
    ply:ConCommand("pp_dof_initlength 10")
    ply:ConCommand("pp_dof_spacing 100")
    ply:ConCommand("pp_dof 1")
end

function scp_1025.KleineLevin(ply)
    scp_1025.CreateBlinkEye(SCP_1025_CONFIG.Settings.KleineLevinDurationBlink)
    scp_1025.CreateBlurEffect(ply, 2)
end

function scp_1025.RabiesPhase3(ply)
    local tab = SCP_1025_CONFIG.Settings.DefaultColorModify
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