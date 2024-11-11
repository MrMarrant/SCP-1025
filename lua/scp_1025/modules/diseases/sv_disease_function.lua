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

SCP_1025_CONFIG.Diseases = {
    ["common_cold"] = function (ply) scp_1025.CommonCold(ply) end,
    ["aids"] = function (ply) scp_1025.CommonCold(ply) end,
}

--[[
* Shoot with the gun depend on the ammo type
* @param disease : string
* @param ply : Player
--]]
function scp_1025.CallDisease(disease, ply)
    SCP_1025_CONFIG.Diseases[disease](ply)
end

function scp_1025.CommonCold(ply)
end

function scp_1025.Aids(ply)
end

net.Receive(SCP_1025_CONFIG.CallDisease, function(len, ply)
    local disease = net.ReadString()
    scp_1025.CallDisease(disease, ply)
end)