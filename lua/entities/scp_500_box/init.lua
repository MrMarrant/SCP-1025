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
	self:SetModel(SCP_1025_CONFIG.Models.Pill)
	self:RebuildPhysics()
	self:InitVar()
	self.Delay = CurTime()
end

-- Initialise the physic of the entity
function ENT:RebuildPhysics()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:PhysWake()
end

-- Use specially for the physics sounds
function ENT:PhysicsCollide( data, physobj )
	if data.DeltaTime > 0.2 then
		if data.Speed > 250 then
			self:EmitSound("physics/plastic/plastic_box_impact_hard" .. math.random(1, 4) .. ".wav", 75, math.random( 100, 110 ))
		else
			self:EmitSound("physics/plastic/plastic_box_impact_soft" .. math.random(1, 4) .. ".wav", 75, math.random( 100, 110 ))
		end
	end
end

function ENT:Consume(ply)
	if (not IsValid(ply)) then return end
	local cur = CurTime()
	if (self.Delay > cur ) then return end
	self.Delay = cur + SCP_1025_CONFIG.Settings.DelayGlycemiaReader
	local count_pills = self:GetRemainingPills()

	scp_1025.ClearDiseases(ply)
	count_pills = count_pills - 1
	self:SetRemainingPills(count_pills)
	if (count_pills <= 0) then
		self:EmitSound("physics/plastic/plastic_box_break" .. math.random(1, 2) .. ".wav", 75, math.random( 100, 110 ))
		self:Remove()
	end
	ply:ChatPrint(scp_1025.GetTranslation("consume_scp500"))
	ply:ChatPrint(scp_1025.GetTranslation("remaining_pills") .. count_pills)
end

function ENT:Use(ply)
	if (not IsValid(ply)) then return end

	self:Consume(ply)
end

function ENT:Touch(ent)
	if (not IsValid(ent)) then return end
	if (not ent:IsPlayer()) then return end
	if (not ent.scp_1025_IsSleeping) then return end

	self:Consume(ent)
end

-- Intialise every var related to the entity
function ENT:InitVar( )
	self:SetRemainingPills(SCP_1025_CONFIG.Settings.PillsNumber)
end