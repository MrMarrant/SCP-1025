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
<title>Index Page</title>
<style>
    body {
        overflow: hidden;
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
        top: 10px;
        right: -10px;
        border-radius: 5px;
        background-color: #000000;
        margin-bottom: 0.5em;
        transition: all 0.3s ease;
        position: absolute;
        width: %frem;
        height: 5em;
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
    <button class="DeletePageButton" onclick='DeletePage()'>Close</button>
</div>

<div class="disease-column">
]]

SCP_1025_CONFIG.IndexFooterPage = [[
</div>

<div class="footer-text">Illustrated by Coltan Press<br>1948</div>
<script>
    function DeletePage() {
        console.log("RUNLUA:scp_1025.CloseBook()")
    }

    function OpenPage(page) {
        console.log("RUNLUA:scp_1025.OpenDescriptionPage('"+page+"')")
    }
</script>

</body>
]]

SCP_1025_CONFIG.DescriptionPage = [[
<head>
    <title>Description Disease</title>
    <style>
        body {
            margin: 0;
            font-family: "Lumios Typewriter Old";
            src: url("asset://garrysmod/addons/scp_1025/resource/fonts/LumiosTypewriter-Old.ttf") format("truetype");
            background: url("asset://garrysmod/addons/scp_1025/materials/img_scp_1025/page.png") no-repeat center center fixed;
            background-size: cover;
            overflow: hidden;
        }
    
        h1 {
            position: absolute;
            left: 30px;
            margin-top: 10px;
            font-size: %frem;
        }
        button {
            color: white;
            background: none;
            border: none;
            padding: 0;
            font: inherit;
            outline: inherit;
            font-size: %frem;
            width: inherit;
            height: inherit;
        }
        button:hover {
            cursor: pointer;
            color: #e2e2e2;
        }
        .close {
            top: 10px;
            border-radius: 5px;
            background-color: #000000;
            margin-bottom: 0.5em;
        }
        .close:hover {
            width: %frem;
        }
        .index {
            margin-top: 100px;
            right: -10px;
            background-color: #424242;
        }
        .index:hover {
            width: %frem;
        }
        .index, .close {
            transition: all 0.3s ease;
            text-align: center;
            position: absolute;
            right: -10px;
            align-content: center;
            width: %frem;
            height: 5em;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .content {
            position: absolute;
            top: 100px;
            left: 30px;
            width: %dpx;
            font-size: 1.5rem;
        }
    </style>
</head>
<body>
    <h1>%s</h1>
    <div class="close">
        <button class="DeletePageButton" onclick='DeletePage()'>Close</button>
    </div>
    <div class="index">
        <button class="IndexButton" onclick='OpenIndex()'>Index</button>
    </div>
    <div class="content">
        <p>
]]

SCP_1025_CONFIG.DescriptionFooterPage = [[
        </p>
    </div>
    <script>
        function DeletePage() {
            console.log("RUNLUA:scp_1025.CloseBook()")
        }

        function OpenIndex() {
            console.log("RUNLUA:scp_1025.OpenIndexPage()")
        }
    </script>
</body>
]]

--[[
* Open the index page of the book.
* @Player ply The player to set the page.
--]]
function scp_1025.IndexPage()
    local ply = LocalPlayer()
    local page = string.format(SCP_1025_CONFIG.BasePage, scp_1025.FontSizeResolution(3), SCP_1025_CONFIG.ScrW * 0.4, scp_1025.FontSizeResolution(2), scp_1025.FontSizeResolution(2), scp_1025.FontSizeResolution(10), scp_1025.FontSizeResolution(10.5), scp_1025.FontSizeResolution(2))
    local i = 1
    for k, v in pairs(SCP_1025_CONFIG.DiseaseAvailable) do
        if (k == "writer_block") then
            local displayed = math.random(1, SCP_1025_CONFIG.Settings.ProbabilityWriter) == 1 and true or false
            if (not displayed) then continue end
        end
        page = page .. "<button onclick='OpenPage(\"" .. k .. "\")'>" .. v.name .. " ......." .. i .. "</button>"
        i = i + 1
    end
    page = page .. SCP_1025_CONFIG.IndexFooterPage
    scp_1025.CreateDHTMLPage(ply, page, SCP_1025_CONFIG.ScrW * 0.5, SCP_1025_CONFIG.ScrH * 0.95, false)
end

--[[
* Open the description page of the disease.
* @Player ply The player to set the page.
* @string disease The disease to display.
--]]
function scp_1025.DescriptionPage(ply, disease)
    scp_1025.DeletePage()
    local diseaseSelect = SCP_1025_CONFIG.DiseaseAvailable[disease]
    local page = string.format(SCP_1025_CONFIG.DescriptionPage, scp_1025.FontSizeResolution(2), scp_1025.FontSizeResolution(2), scp_1025.FontSizeResolution(10.5), scp_1025.FontSizeResolution(10.5), scp_1025.FontSizeResolution(10), SCP_1025_CONFIG.ScrW * 0.35, diseaseSelect.name)
    page = page .. diseaseSelect.description .. SCP_1025_CONFIG.DescriptionFooterPage
    scp_1025.CreateDHTMLPage(ply, page, SCP_1025_CONFIG.ScrW * 0.5, SCP_1025_CONFIG.ScrH * 0.95, false)
    ply:EmitSound(Sound(SCP_1025_CONFIG.Sounds.TurnPage), 90, math.random( 90, 110 )) --! Ne sera joué que coté client
end

--[[
* Open the description page of the disease and set the disease to the player.
* @string disease The disease to display.
--]]
function scp_1025.OpenDescriptionPage(disease)
    local ply = LocalPlayer()
    scp_1025.DescriptionPage(ply, disease)
    ply:EmitSound(Sound(SCP_1025_CONFIG.Sounds.DiseaseRead), 90, math.random( 90, 110 ))
    scp_1025.CreateBlurEffect(ply, 8)

    net.Start(SCP_1025_CONFIG.NetVar.CallDisease)
    net.WriteString(disease)
    net.SendToServer()
end

--[[
* Open the index page from the html page.
--]]
function scp_1025.OpenIndexPage()
    local ply = LocalPlayer()
    scp_1025.IndexPage()
    ply:EmitSound(Sound(SCP_1025_CONFIG.Sounds.TurnIndex), 90, math.random( 90, 110 )) --! Ne sera joué que coté client
end

--[[
* Create a DHTML page.
* @Player ply The player to set the page.
* @string content The page content.
--]]
function scp_1025.CreateDHTMLPage(ply, content, w, h, canClose)
    scp_1025.DeletePage(ply)

    local frame = vgui.Create("DFrame")
    frame:SetSize(w, h)
    frame:Center()
    frame:SetTitle("")
    frame:MakePopup()
    frame:SetDraggable(canClose)
    frame:ShowCloseButton(canClose)
    local width, height = frame:GetSize()
    height = canClose and height - 30 or height

    -- Create the DHTML panel
    local dhtml = vgui.Create("DHTML", frame)
    dhtml:SetSize(width, height)
    dhtml:SetHTML(content)
    dhtml:SetAllowLua(true)
    dhtml:RequestFocus()
    if (canClose) then dhtml:Dock(BOTTOM) end

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
* Close the book and play a sound.
--]]
function scp_1025.CloseBook()
    local ply = LocalPlayer()
    scp_1025.DeletePage()
    ply:EmitSound(Sound(SCP_1025_CONFIG.Sounds.CloseBook), 90, math.random( 90, 110 )) --! Ne sera joué que coté client
    hook.Call("OnCloseBookSCP1025", nil, ply)
end

--[[
* Convert the size of the font to the resolution of the screen.
* @float size The size to convert.
--]]
function scp_1025.FontSizeResolution(size)
    return math.Round(size * (SCP_1025_CONFIG.ScrH / SCP_1025_CONFIG.HIdealResolution), 1)
end

-- Net Messages
net.Receive(SCP_1025_CONFIG.NetVar.IndexPage, function()
    local ply = LocalPlayer()
    if (not IsValid(ply)) then return end

    scp_1025.IndexPage(ply)
end)