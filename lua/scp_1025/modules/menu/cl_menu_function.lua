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

SCP_1025_CONFIG.AddDiseaseMenu = [[
<head>
    <title>Add Disease</title>
    <style>
        body {
            margin-left: 10px;
            color: #ffffff;
            background: url("asset://garrysmod/addons/scp_1025/materials/img_scp_1025/add_disease.png") no-repeat center center fixed;
            background-size: cover;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <h1>SCP-1025</h1>
    <h2>Add disease</h2>

    <form name="formdisease" action="javascript:CreateDisease()">
        <label for="dname">Disease name:</label><br>
        <input type="text" id="dname" name="dname" placeholder="Influenza"><br><br>
        <label for="ddescription">Disease description:</label><br>
        <textarea  type="text" id="ddescription" name="ddescription" rows="8" cols="50" placeholder='Flu, also called influenza, is an infection of the nose, throat and lungs, which are part of the respiratory system. The flu is caused by a virus. Influenza viruses are different from the "stomach flu" viruses that cause diarrhea and vomiting.'></textarea><br><br>
        <label for="dfunction">Disease function to call:<br>
            <b>- The function must exist.<br>
            - The function must have only one parameter who should receive a player.<br>
            - The function must be in the global scope.<br>
            - The function must be in the form of 'function(ply) ... end'.<br>
            - The function must not be contained in an array.<br>
            - The function must be executable SERVER side.<br>
            - Enter the function name without brackets.</b>
        </label><br>
        <input type="text" id="dfunction" name="dfunction" placeholder='InfectWithFlu'><br><br>
        <label for="dindex">Index name:<br>(Do not add spaces)</label><br>
        <input type="text" id="dindex" name="dindex" placeholder='flu'><br><br><br>
        <input class="submit" type="submit" value="Confirm">
    </form>
    <script>
        // Check if every parameter are not empty
        function IsFormValid(func, name, description, index) {
            if (func == "" || name == "" || description == "" || index == "") {
                console.log("RUNLUA:scp_1025.AlertChat('fillall')")
                return false;
            }
            return true;
        }
        // Format the text for remove the ' character
        // TODO : A retest
        function FormatText(func, name, description, index) {
            func = func.replace(/'/g, "\\'");
            name = name.replace(/'/g, "\\'");
            description = description.replace(/'/g, "\\'");
            index = index.replace(/'/g, "\\'");
            return [func, name, description, index];
        }
        function CreateDisease() {
            let form = document.formdisease;
            let [func, name, description, index] = [form.dfunction.value, form.dname.value, form.ddescription.value, form.dindex.value];
            isValid = IsFormValid(func, name, description, index);
            if (isValid) {
                [func, name, description, index] = FormatText(func, name, description, index)
                console.log("RUNLUA:scp_1025.CreateDisease('"+func+"', '"+name+"', '"+description+"', '"+index+"')");
            }
        }
    </script>
</body>
]]

SCP_1025_CONFIG.RemoveHeaderMenu = [[
 <head>
    <title>Add Disease</title>
    <style>
        body {
            margin-left: 10px;
            color: #ffffff;
            background: url("asset://garrysmod/addons/scp_1025/materials/img_scp_1025/add_disease.png") no-repeat center center fixed;
            background-size: cover;
            overflow: hidden;
        }
        .disease-column {
            gap: 0px 100px;
            display: flex;
            flex-direction: column;
            max-height: -webkit-fill-available;
            flex-wrap: wrap;
            align-items: center;
            margin-bottom: 100px;
        }
        .disease-element {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 10px;
        }
        .no-disease {
            width: 117px;
            height: 100px;
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            margin: auto;
        }
    </style>
</head>
<body>
    <h1>SCP-1025</h1>
    <h2>Remove disease</h2>
    <div class="disease-column">
 ]]

 SCP_1025_CONFIG.RemoveFooterMenu = [[
     </div>
    <script>
        function RemoveDisease(index) {
            console.log("RUNLUA:scp_1025.RemoveDisease('"+index+"')")
        }
    </script>
</body>
 ]]

 --[[
* Open the remove disease menu.
--]]
function scp_1025.OpenRemoveMenu()
    local ply = LocalPlayer()
    if (not ply:IsAdmin()) then scp_1025.AlertChat("adminaccess") return end
    local page = SCP_1025_CONFIG.RemoveHeaderMenu

    for k, v in pairs(SCP_1025_CONFIG.CustomDisease) do
        page = page .. "<div class="disease-element"><p>" .. v.name .. "</p> <button onclick='RemoveDisease(\"" .. k .. "\")'>Remove</button></div>"
    end
    if (next(SCP_1025_CONFIG.CustomDisease) == nil) then
        page = page .. '<p class="no-disease">Aucune maladies.</p>'
    end

    page = page .. SCP_1025_CONFIG.RemoveFooterMenu
    scp_1025.CreateDHTMLPage(ply, page, SCP_1025_CONFIG.ScrW * 0.8, SCP_1025_CONFIG.ScrH * 0.8, true)
end

--[[
* Open the add disease menu.
--]]
function scp_1025.OpenAddMenu()
    local ply = LocalPlayer()
    if (ply:IsAdmin()) then
        scp_1025.CreateDHTMLPage(ply, SCP_1025_CONFIG.AddDiseaseMenu, SCP_1025_CONFIG.ScrW * 0.8, SCP_1025_CONFIG.ScrH * 0.8, true)
    else
        scp_1025.AlertChat("adminaccess")
    end
end

--[[
* Create a disease with the function, name, description and index.
* @string func The function to call.
* @string name The name of the disease.
* @string description The description of the disease.
* @string index The index of the disease.
--]]
function scp_1025.CreateDisease(func, name, description, index)
    local isValid = scp_1025.IsNewDiseaseValid(func, name, description, index)
    if (isValid) then
        net.Start(SCP_1025_CONFIG.NetVar.AddCustomDisease)
        net.WriteString(func)
        net.WriteString(name)
        net.WriteString(description)
        net.WriteString(index)
        net.SendToServer()
    end
end

--[[
* Remove a custom disease.
* @string index The index of the disease.
--]]
function scp_1025.RemoveDisease(index)
    if (index == "") then 
        scp_1025.AlertChat("indexempty")
        return
    end
    net.Start(SCP_1025_CONFIG.NetVar.RemoveCustomDisease)
    net.WriteString(index)
    net.SendToServer()
end

--[[
* Check if all parameters are valid.
* @string func The function to call.
* @string name The name of the disease.
* @string description The description of the disease.
* @string index The index of the disease.
--]]
function scp_1025.IsNewDiseaseValid(func, name, description, index)
    local ply = LocalPlayer()
    -- check if params are not empty
    if (func == "" or name == "" or description == "" or index == "") then
        scp_1025.AlertChat("fillall")
        return false
    end
    if (SCP_1025_CONFIG.CustomDisease[index]) then
        scp_1025.AlertChat("diseaseexist")
        return false
    end
    return true
end

--[[
* Create a notificatino message to the screen of the player.
* @string message The message to display.
* @number|nil notiftype The type notification icon to display.
--]]
function scp_1025.AlertChat(message, notiftype)
    notiftype = notiftype or NOTIFY_ERROR
    notification.AddLegacy(scp_1025.GetTranslation(message), notiftype, 4)
    -- LocalPlayer():ChatPrint(scp_1025.GetTranslation(mesage))
end

-- NET RECEIVE
net.Receive(SCP_1025_CONFIG.NetVar.CreateCustomDisease, function()
    local name = net.ReadString()
    local description = net.ReadString()
    local func = net.ReadString()
    local index = net.ReadString()

    SCP_1025_CONFIG.CustomDisease[index] = {name = name, description = description}
    SCP_1025_CONFIG.DiseaseAvailable[index] = {name = name, description = description}
end)

net.Receive(SCP_1025_CONFIG.NetVar.ConfirmMenu, function()
    local message = net.ReadString()
    scp_1025.AlertChat(message, NOTIFY_GENERIC)
    scp_1025.DeletePage()
end)

net.Receive(SCP_1025_CONFIG.NetVar.ErrorMessage, function()
    local message = net.ReadString()
    scp_1025.AlertChat(message)
end)

net.Receive(SCP_1025_CONFIG.NetVar.DeleteCustomDisease, function()
    local index = net.ReadString()
    SCP_1025_CONFIG.CustomDisease[index] = nil
    SCP_1025_CONFIG.DiseaseAvailable[index] = nil
end)

net.Receive(SCP_1025_CONFIG.NetVar.UpdateTableDisease, function()
    local CustomDisease = net.ReadTable()
    local DiseaseAvailable = net.ReadTable()
    SCP_1025_CONFIG.CustomDisease[index] = CustomDisease
    SCP_1025_CONFIG.DiseaseAvailable[index] = DiseaseAvailable
end)

net.Receive(SCP_1025_CONFIG.NetVar.CloseMenu, function()
    scp_1025.DeletePage()
end)

-- HOOKs
hook.Add("PopulateToolMenu", "PopulateToolMenu.SCP1025", function()
    spawnmenu.AddToolMenuOption("Utilities", "SCP-1025", "SCP1025_Menu", "Settings", "", "", function(panel)
        local AddDisease = vgui.Create("DButton")
        AddDisease:SetPos( 5, 5 )
        AddDisease:SetText(scp_1025.GetTranslation("adddisease"))
        AddDisease:SetSize( 250, 30 )
        AddDisease.DoClick = function()
            scp_1025.OpenAddMenu()
        end

        local RemoveDisease = vgui.Create("DButton")
        RemoveDisease:SetPos( 5, 5 )
        RemoveDisease:SetText(scp_1025.GetTranslation("removedisease"))
        RemoveDisease:SetSize( 250, 30 )
        RemoveDisease.DoClick = function()
            -- TODO
        end

        panel:Clear()
        panel:ControlHelp(scp_1025.GetTranslation("warningsettings"))
        panel:AddItem(AddDisease)
        panel:AddItem(RemoveDisease)
    end)
end)