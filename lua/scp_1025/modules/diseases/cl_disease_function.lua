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
* Create a blur effect for the player.
* @Player ply The player to set the disease.
* @number duration The duration of the blur effect.
--]]
function scp_1025.CreateBlurEffect(ply, duration)
    hook.Add( "RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025", function()
        DrawMotionBlur( 0.4, 0.8, 0.01 )
    end )
    timer.Create("SCP1025.BlurEffect." .. ply:EntIndex(), duration, 1, function()
        hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025")
    end)
end

--[[
* Clear the diseases for the player.
* @Player ply The player to clear diseases.
--]]
function scp_1025.ClearDiseases(ply)
    timer.Remove("SCP1025.CommonCold." .. ply:EntIndex())
    timer.Remove("SCP1025.BlurEffect." .. ply:EntIndex())
    hook.Remove("RenderScreenspaceEffects", "RenderScreenspaceEffects.SCP1025")
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

--[[
* Set the gastroenteritis for the player.
* @Player ply The player to set the disease.
--]]
function scp_1025.Gastroenteritis(ply)
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

net.Receive(SCP_1025_CONFIG.NetVar.Gastroenteritis, function()
    local ply = LocalPlayer()
    scp_1025.Gastroenteritis(ply)
end)