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
	self:SetModel(SCP_1025_CONFIG.Models.Coke)
	self:RebuildPhysics()
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

function ENT:Eat(ply)
	hook.Call("OnGlucideConsumption", nil, ply, SCP_1025_CONFIG.Settings.CokeGlycemiaValue)
	ply:EmitSound(SCP_1025_CONFIG.Sounds.Eat, 75, math.random( 90, 110 ))
	self:Remove()
end

function ENT:Use(ply)
	if (not IsValid(ply)) then return end
	if (not ply.scp_1025_Glycemia) then return end

	self:Eat(ply)
end

function ENT:Touch(ent)
	if (not IsValid(ent)) then return end
	if (not ent:IsPlayer()) then return end
	if (not ent.scp_1025_Glycemia) then return end
	if (not ent.scp_1025_IsSleeping) then return end

	self:Eat(ent)
end