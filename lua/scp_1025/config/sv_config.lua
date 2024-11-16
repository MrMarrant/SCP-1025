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

-- AddNetworkString
util.AddNetworkString(SCP_1025_CONFIG.NetVar.IndexPage)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.CallDisease)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.AddCustomDisease)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.ErrorMessage)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.CreateCustomDisease)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.ConfirmMenu)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.DeleteCustomDisease)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.RemoveCustomDisease)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.UpdateTableDisease)
util.AddNetworkString(SCP_1025_CONFIG.NetVar.CloseMenu)

hook.Add( "PlayerDeath", "SCP1025.PlayerDeath", function(victim)
    scp_1025.CloseMenu(victim)
end)

-- TODO : A vérifier si je dois initialiser quand un joueur se co, je sais pas.
-- hook.Add("PlayerInitialSpawn", "SCP1025.PlayerInitialSpawn", function (ply)
    
-- end)