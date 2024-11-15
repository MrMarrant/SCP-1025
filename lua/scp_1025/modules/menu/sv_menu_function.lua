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

local function IsNewDiseaseValid(func, name, description, index, ply)
    if (not ply:IsAdmin()) then
        scp_1025.ErrorMesage(ply, "warningsettings")
        return false
    end
    -- check if params are not empty
    if (func == "" or name == "" or description == "" or index == "") then
        scp_1025.ErrorMesage(ply, "fillall")
        return false
    end
    if (SCP_1025_CONFIG.CustomDiseaseType[index] or SCP_1025_CONFIG.DiseaseAvailable[index]) then
        scp_1025.ErrorMesage(ply, "diseaseexist")
        return false
    end
    -- verify if the function exist
    if not _G[func] then
        scp_1025.ErrorMesage(ply, "funcdontexist")
        return false
    -- -- verify if the function has a one parameter
    elseif debug.getinfo(_G[func]).nparams != 1 then
        scp_1025.ErrorMesage(ply, "needoneparam")
        return false
    end
    return true
end

local function CreateDisease(func, name, description, index, caller)
    if not IsNewDiseaseValid(func, name, description, index, caller) then return end

    SCP_1025_CONFIG.CustomDiseaseType[index] = {name = name, description = description, func = func}
    SCP_1025_CONFIG.DiseaseAvailable[index] = {name = name, description = description}
    SCP_1025_CONFIG.Diseases[index] = function (ply) _G[func](ply) end

    scp_1025.CreateJson(func, name, description, index)

    -- Met à jour les clients
    net.Start(SCP_1025_CONFIG.NetVar.CreateCustomDisease)
    net.WriteString(func)
    net.WriteString(name)
    net.WriteString(description)
    net.WriteString(index)
    net.Broadcast()

    -- Confirmation Coté joueur
    net.Start(SCP_1025_CONFIG.NetVar.ConfirmMenu)
    net.WriteString("confirmcreation")
    net.Send(caller)
end

local function DeleteCustomDisease(ply, index)
    if (not ply:IsAdmin()) then
        scp_1025.ErrorMesage(ply, "warningsettings")
        return false
    end

    SCP_1025_CONFIG.CustomDiseaseType[index] = nil
    SCP_1025_CONFIG.DiseaseAvailable[index] = nil
    SCP_1025_CONFIG.Diseases[index] = nil
    
    scp_1025.UpdateJson(SCP_1025_CONFIG.DiseaseAvailable)
    -- TODO : Remove client to
    net.Start(SCP_1025_CONFIG.NetVar.DeleteCustomDisease)
    net.WriteString(index)
    net.Broadcast()

    -- Confirmation Coté joueur
    net.Start(SCP_1025_CONFIG.NetVar.ConfirmMenu)
    net.WriteString("confirmdelete")
    net.Send(ply)
end

function scp_1025.CreateJson(func, name, description, index)
    -- DIRECTORY DATA FOLDER
    if not file.Exists(SCP_1025_CONFIG.Paths.FolderData, "DATA") then
        file.CreateDir(SCP_1025_CONFIG.Paths.FolderData)
    end
    local fileFind = file.Read(SCP_1025_CONFIG.Paths.DataJson) or ""
    local SERVER_VALUES = util.JSONToTable(fileFind) or {}

    SERVER_VALUES[index] = {
        name = name,
        description = description,
        func = func
    }
    file.Write(SCP_1025_CONFIG.Paths.DataJson, util.TableToJSON(SERVER_VALUES, true))
end

function scp_1025.UpdateJson(data)
    if not file.Exists(SCP_1025_CONFIG.Paths.FolderData, "DATA") then
        file.CreateDir(SCP_1025_CONFIG.Paths.FolderData)
    end
    file.Write(SCP_1025_CONFIG.Paths.DataJson, util.TableToJSON(data, true))
end

function scp_1025.ErrorMesage(ply, message)
    net.Start(SCP_1025_CONFIG.NetVar.ErrorMessage)
    net.WriteString(message)
    net.Send(ply)
end

function TestSCP1025(ply)
    print("ah oui oui")
end

-- NET MESSAGES
net.Receive(SCP_1025_CONFIG.NetVar.AddCustomDisease, function(len, ply)
    local func = net.ReadString()
    local name = net.ReadString()
    local description = net.ReadString()
    local index = net.ReadString()

    CreateDisease(func, name, description, index, ply)
end)

net.Receive(SCP_1025_CONFIG.NetVar.RemoveCustomDisease, function(len, ply)
    local index = net.ReadString()
    DeleteCustomDisease(ply, index)
end)