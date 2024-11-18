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
    ["schizophrenia"] = function (ply) scp_1025.Schizophrenia(ply) end,
    ["gastroenteritis"] = function (ply) scp_1025.Gastroenteritis(ply) end,
    ["myopia"] = function (ply) scp_1025.Myopia(ply) end,
    ["rabies"] = function (ply) scp_1025.Rabies(ply) end,
    ["huntington"] = function (ply) scp_1025.Huntington(ply) end,
    ["polio"] = function (ply) scp_1025.Polio(ply) end,
    ["diabetes"] = function (ply) scp_1025.Diabetes(ply) end,
    ["kleine_levin"] = function (ply) scp_1025.KleineLevin(ply) end,
    ["pica"] = function (ply) scp_1025.Pica(ply) end,
}

for key, value in pairs(SCP_1025_CONFIG.CustomDisease) do
    SCP_1025_CONFIG.Diseases[key] = function (ply) _G[value.func](ply) end
end

--[[
* Call the disease for the player.
* @string disease The disease
* @Player ply The player to set the disease.
--]]
function scp_1025.CallDisease(disease, ply)
    if (not ply:Alive()) then return end
    SCP_1025_CONFIG.Diseases[disease](ply)
    hook.Call("SCP1025.CallDisease", nil, ply, disease) --? In case some dev wants to do something on disease call
end

-- TODO : Eternuement régulier toutes les 80-120s
function scp_1025.CommonCold(ply)
    local minDuration = SCP_1025_CONFIG.Settings.MinCommonCold
    local maxDuration = SCP_1025_CONFIG.Settings.MaxCommonCold
    local sneezeSounds = SCP_1025_CONFIG.Sounds.Sneezing
    if (not timer.Exists("SCP1025.CommonCold." .. ply:EntIndex())) then
        timer.Create("SCP1025.CommonCold." .. ply:EntIndex(), math.random(minDuration, maxDuration), SCP_1025_CONFIG.Settings.Repetitions, function ()
            if (not ply:IsValid()) then timer.Remove("SCP1025.CommonCold") return end
            ply:EmitSound(sneezeSounds[math.random(#sneezeSounds)])
            timer.Adjust("SCP1025.CommonCold", math.random(minDuration, maxDuration))
        end)
    end
end

function scp_1025.Schizophrenia(ply)
end

function scp_1025.Gastroenteritis(ply)
end

function scp_1025.Myopia(ply)
end

function scp_1025.Rabies(ply)
end

function scp_1025.Huntington(ply)
end

function scp_1025.Polio(ply)
end

function scp_1025.Diabetes(ply)
end

function scp_1025.KleineLevin(ply)
end

function scp_1025.Pica(ply)
end

function scp_1025.ClearDiseases(ply)
    timer.Remove("SCP1025.CommonCold." .. ply:EntIndex())
end

net.Receive(SCP_1025_CONFIG.NetVar.CallDisease, function(len, ply)
    local disease = net.ReadString()
    scp_1025.CallDisease(disease, ply)
end)