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

AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel(SCP_1025_CONFIG.Models.ModelBook)
	self:RebuildPhysics()
	self:Paranoid()
end

-- Initialise the physic of the entity
function ENT:RebuildPhysics()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:PhysWake()
end

-- EVERY 60 seconds, choose a player in range of the entity and make him paranoid (if more than one, choose the one furthest from the entity).
-- The more players, the higher the probability of making a player paranoid.
-- At least 3 players are needed to make a player paranoid, with a starting probability of 30%.
-- Rises to 70% for 10 players
function ENT:Paranoid()
	local radius = SCP_1025_CONFIG.Settings.ParanoidRadius
	local minChance = SCP_1025_CONFIG.Settings.ParanoidMinChance
	local maxChance = SCP_1025_CONFIG.Settings.ParanoidMaxChance
	local minPlayers = SCP_1025_CONFIG.Settings.ParanoidMinPlayers
	local maxPlayers = SCP_1025_CONFIG.Settings.ParanoidMaxPlayers

	timer.Create("SCP1025.Paranoid." .. self:EntIndex(), SCP_1025_CONFIG.Settings.ParanoidDelay, 0, function()
		local playersCatch = scp_1025.GetInSpherePlayers(self:GetPos(), radius)
		local playersCount = math.Clamp(#playersCatch, 0, maxPlayers)
		if (playersCount >= minPlayers) then
			local prob = Lerp((playersCount - minPlayers) / (maxPlayers - minPlayers), minChance, maxChance)
			local chance = math.random(1, 100)
			if (chance <= prob) then
				self:MakeParanoid(playersCatch)
			end
		end
	end)
end

-- Make a player paranoid
-- If the player is already paranoid, the function will not make him paranoid
-- if none is found, the function will not make any player paranoid
function ENT:MakeParanoid(tbl)
	local playerParanoidFound = false

	while (not playerParanoidFound and #tbl >= 1) do
		local furfarthestPlayer = scp_1025.GetFarthestEnt(tbl, self)
		if (not IsValid(furfarthestPlayer)) then return end
		if (not furfarthestPlayer:Alive()) then return end

		tbl[furfarthestPlayer:EntIndex()] = nil
		if (not furfarthestPlayer.scp_1025_Paranoid) then
			furfarthestPlayer.scp_1025_Paranoid = true
			playerParanoidFound = true
			net.Start(SCP_1025_CONFIG.NetVar.Paranoid)
			net.Send(furfarthestPlayer)
		end
	end
end

-- Use specially for the physics sounds
function ENT:PhysicsCollide(data, physobj)
	if data.DeltaTime > 0.2 then
		if data.Speed > 250 then
			self:EmitSound("physics/plastic/plastic_box_impact_hard" .. math.random(1, 4) .. ".wav", 75, math.random( 100, 110 ))
		else
			self:EmitSound("physics/plastic/plastic_box_impact_soft" .. math.random(1, 4) .. ".wav", 75, math.random( 100, 110 ))
		end
	end
end

function ENT:Use(ply)
	if (not IsValid(ply)) then return end
	if (ply.scp_1025_WriterBlock) then return end

	scp_1025.OpenBook(ply)
	self:EmitSound(Sound(SCP_1025_CONFIG.Sounds.OpenBook), 90, math.random( 90, 110 ))
end

function ENT:OnRemove()
	timer.Remove("SCP1025.Paranoid." .. self:EntIndex())
end