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

SCP_1025_CONFIG.ScrW = ScrW()
SCP_1025_CONFIG.ScrH = ScrH()
SCP_1025_CONFIG.WIdealResolution = 1920
SCP_1025_CONFIG.HIdealResolution = 1080

-- Split the children of a container into side-by-side columns of a maximum height.
-- Equivalent to a wrapping flex column, which is not supported by the Awesomium browser of the base branch.
SCP_1025_CONFIG.WrapColumnsScript = [[
<script>
    function WrapColumns(id, maxHeight) {
        var container = document.getElementById(id);
        var items = [];
        var heights = [];
        var nodes = container.childNodes;
        for (var i = nodes.length - 1; i >= 0; i--) {
            if (nodes[i].nodeType != 1) container.removeChild(nodes[i]);
        }
        for (var j = 0; j < nodes.length; j++) {
            items.push(nodes[j]);
            heights.push(nodes[j].offsetHeight);
        }

        var column = null;
        var height = 0;
        for (var k = 0; k < items.length; k++) {
            if (!column || (height > 0 && height + heights[k] > maxHeight)) {
                column = document.createElement("div");
                column.className = "wrap-column";
                container.appendChild(column);
                height = 0;
            }
            column.appendChild(items[k]);
            height += heights[k];
        }
    }
</script>
]]

hook.Add( "OnScreenSizeChanged", "OnScreenSizeChanged.SCP1025", function( oldWidth, oldHeight )
    SCP_1025_CONFIG.ScrW = ScrW()
    SCP_1025_CONFIG.ScrH = ScrH()
end )

surface.CreateFont( "SCP01025_Book", {
    font = "Lumios Typewriter Old",
    size = 15
} )

surface.CreateFont( "SCP01025_Error", {
    font = "CenterPrintText",
    size = 20
} )

surface.CreateFont( "SCP01025_MT1", {
    font = "Arial",
    size = 40,
} )
surface.CreateFont( "SCP01025_MT2", {
    font = "Arial",
    size = 35,
} )
surface.CreateFont( "SCP01025_MT3", {
    font = "Arial",
    size = 45,
} )
surface.CreateFont( "SCP01025_MT4", {
    font = "Arial",
    size = 30,
} )
surface.CreateFont( "SCP01025_MT5", {
    font = "Arial",
    size = 38,
} )
surface.CreateFont( "SCP01025_MT6", {
    font = "Arial",
    size = 25,
} )
surface.CreateFont( "SCP01025_MTFinal", {
    font = "Akbar",
    size = 150,
} )

SCP_1025_CONFIG.FontEffect = {}
for var = 1, 6 do
    SCP_1025_CONFIG.FontEffect[var] = "SCP01025_MT" .. var
end