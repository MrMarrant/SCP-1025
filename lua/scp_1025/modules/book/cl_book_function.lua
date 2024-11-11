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

SCP_1025_CONFIG.BasePage = [[
<head>
<title>Common Diseases</title>
<style>
    body {
        margin: 0;
        font-family: "Lumios Typewriter Old";
        src: url("asset://garrysmod/addons/scp_1025/resource/fonts/LumiosTypewriter-Old.ttf") format("truetype");
        background: url("asset://garrysmod/addons/scp_1025/materials/img_scp_1025/page.png") no-repeat center center fixed;
        background-size: cover;
        display: flex;
        flex-direction: column;
        align-items: center;
        color: #333;
    }

    h1 {
        margin-top: 10px;
        text-align: center;
        font-size: %frem;
        line-height: 1.2;
    }

    hr {
        margin-top: 15px;
        margin-bottom: 30px;
        width: %dpx;
        border: none;
        border-top: 3px solid #333;
    }
    .disease-column {
        gap: 0px 100px;
        display: flex;
        flex-direction: column;
        max-height: 1000px;
        flex-wrap: wrap;
        align-items: center;
    }

    .footer-text {
        text-align: center;
        padding-bottom: 100px;
        position: absolute;
        font-size: %frem;
        bottom: 0;
    }

    button {
        background: none;
        border: none;
        padding: 0;
        font: inherit;
        outline: inherit;
        font-size: %frem;
    }

    button:hover {
    cursor: pointer;
    color: blue;
    }

    .QuitButton {
    background-color: #000000;
    position: absolute;
    right: 0;
    width: %frem;
    height: 3em;
    display: grid;
    margin-top: 3em;
    }
    .QuitButton:hover {
        width: %frem;
    }
    .DeletePageButton {
        font-size: %frem;
        color: #ffffff;
    }
    .DeletePageButton:hover {
        color: #e2e2e2;
    }
</style>
</head>
<body>

<h1>The<br>Encyclopedia<br>of<br>Common<br>Diseases</h1>
<hr>
<div class="QuitButton">
    <button class="DeletePageButton" onclick='DeletePage()'>Quit</button>
</div>

<div class="disease-column">
]]

SCP_1025_CONFIG.FooterPage = [[
</div>

<div class="footer-text">Illustrated by Coltan Press<br>1948</div>
<script>
    function DeletePage() {
        console.log("RUNLUA:scp_1025.DeletePage()")
    }

    function OpenPage(page) {
        console.log("RUNLUA:scp_1025.OpenDiseasePage('"+page+"')")
    }
</script>

</body>
]]

--[[
* Open the index page of the book.
* @Player ply The player to set the page.
--]]
function scp_1025.IndexPage(ply)
    local page = string.format(SCP_1025_CONFIG.BasePage, scp_1025.FontSizeResolution(3), SCP_1025_CONFIG.ScrW * 0.4, scp_1025.FontSizeResolution(2), scp_1025.FontSizeResolution(2), scp_1025.FontSizeResolution(10), scp_1025.FontSizeResolution(10.5), scp_1025.FontSizeResolution(1.5))
    local i = 1
    for k, v in pairs(SCP_1025_CONFIG.DiseaseType) do
        page = page .. "<button onclick='OpenPage(\"" .. k .. "\")'>" .. v.name .. " ......." .. i .. "</button>"
        i = i + 1
    end
    page = page .. SCP_1025_CONFIG.FooterPage
    scp_1025.CreateDHTMLPage(ply, page)
end

--[[
* Open the description page of the disease.
* @Player ply The player to set the page.
* @string disease The disease to display.
--]]
function scp_1025.DescriptionPage(ply, disease)
    scp_1025.DeletePage()
    -- TODO : Faire la page de description
end

function scp_1025.OpenDiseasePage(disease)
    local ply = LocalPlayer()
    scp_1025.DescriptionPage(ply, disease)

    net.Start(SCP_1025_CONFIG.CallDisease)
    net.WriteString(disease)
    net.SendToServer()
end

--[[
* Create a DHTML page.
* @Player ply The player to set the page.
* @string content The page content.
--]]
function scp_1025.CreateDHTMLPage(ply, content)
    scp_1025.DeletePage(ply)

    local frame = vgui.Create("DFrame")
    frame:SetSize(SCP_1025_CONFIG.ScrW * 0.5, SCP_1025_CONFIG.ScrH * 0.95)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    local width, height = frame:GetSize()

    -- Crée le panneau DHTML
    local dhtml = vgui.Create("DHTML", frame)
    dhtml:SetSize(width, height)
    dhtml:SetHTML(content)
    dhtml:SetAllowLua(true)
    dhtml:RequestFocus()

    ply.scp_1025_CurrentPage = frame
end

--[[
* Delete the current page.
--]]
function scp_1025.DeletePage()
    local ply = LocalPlayer()
    if (ply.scp_1025_CurrentPage) then
        ply.scp_1025_CurrentPage:Remove()
        ply.scp_1025_CurrentPage = nil
    end
end

--[[
* Delete the current page.
* @float size The size to convert.
--]]
function scp_1025.FontSizeResolution(size)
    return math.Round(size * (SCP_1025_CONFIG.ScrH / SCP_1025_CONFIG.HIdealResolution), 1)
end

-- Net Messages
net.Receive(SCP_1025_CONFIG.IndexPage, function()
    local ply = LocalPlayer()
    if (not IsValid(ply)) then return end

    scp_1025.IndexPage(ply)
end)