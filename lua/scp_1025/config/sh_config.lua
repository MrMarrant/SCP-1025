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

-- NET VAR
SCP_1025_CONFIG.NetVar = {}
SCP_1025_CONFIG.NetVar.IndexPage = "SCP_1025_CONFIG.NetVar.IndexPage"
SCP_1025_CONFIG.NetVar.CallDisease = "SCP_1025_CONFIG.NetVar.CallDisease"
SCP_1025_CONFIG.NetVar.AddCustomDisease = "SCP_1025_CONFIG.NetVar.AddCustomDisease"
SCP_1025_CONFIG.NetVar.ErrorMessage = "SCP_1025_CONFIG.NetVar.ErrorMessage"
SCP_1025_CONFIG.NetVar.CreateCustomDisease = "SCP_1025_CONFIG.NetVar.CreateCustomDisease"
SCP_1025_CONFIG.NetVar.ConfirmMenu = "SCP_1025_CONFIG.NetVar.ConfirmMenu"
SCP_1025_CONFIG.NetVar.DeleteCustomDisease = "SCP_1025_CONFIG.NetVar.DeleteCustomDisease"
SCP_1025_CONFIG.NetVar.RemoveCustomDisease = "SCP_1025_CONFIG.NetVar.RemoveCustomDisease"

-- Model Path
SCP_1025_CONFIG.Models = {}
SCP_1025_CONFIG.Models.ModelBook = "models/scp_1025/scp_1025.mdl"

-- TODO : Sounds
--Sound Path
SCP_1025_CONFIG.Sounds = {}
SCP_1025_CONFIG.Sounds.OpenBookSound = "scp_1025/open_book.wav"
SCP_1025_CONFIG.Sounds.CloseBookSound = "scp_1025/close_book.wav"

-- JSON Path
SCP_1025_CONFIG.Paths = {}
SCP_1025_CONFIG.Paths.FolderData = "scp_1025"
SCP_1025_CONFIG.Paths.DataJson = "scp_1025/custom_disease.json"

-- Default Diseases
SCP_1025_CONFIG.DiseaseAvailable = {
    common_cold = {
        name = "Common Cold",
        description = "The common cold is a viral infection of your nose and throat (upper respiratory tract). It's usually harmless, although it might not feel that way. Many types of viruses can cause a common cold.",
    },
    aids = {
        name = "HIV/AIDS",
        description = "HIV (human immunodeficiency virus) is a virus that attacks cells that help the body fight infection, making a person more vulnerable to other infections and diseases. It is spread by contact with certain bodily fluids of a person with HIV, most commonly during",
    }
}

-- Custom Diseases
SCP_1025_CONFIG.CustomDiseaseType = util.JSONToTable(file.Read(SCP_1025_CONFIG.Paths.DataJson) or "") or {}

-- Merge Diseases
SCP_1025_CONFIG.DiseaseAvailable = table.Merge(SCP_1025_CONFIG.DiseaseAvailable, SCP_1025_CONFIG.CustomDiseaseType)