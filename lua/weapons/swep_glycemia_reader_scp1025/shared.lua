-- SCP-055, A representation of a paranormal object on a fictional series on the game Garry's Mod.
-- Copyright (C) 2023  MrMarrant aka BIBI.

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

AddCSLuaFile()
AddCSLuaFile( "cl_init.lua" )

SWEP.Slot = 0
SWEP.SlotPos = 1

SWEP.Spawnable = true

SWEP.Category = "Diabetes Stuff"
SWEP.ViewModel = Model("")
SWEP.WorldModel = Model(SCP_1025_CONFIG.Models.GlycemiaReader)

SWEP.ViewModelFOV = 65
SWEP.HoldType = "normal"
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.DrawAmmo = false

-- Variables Personnal to this weapon --
-- [[ STATS WEAPON ]]
SWEP.PrimaryCooldown = SCP_1025_CONFIG.Settings.DelayGlycemiaReader

function SWEP:Initialize()
	self:SetHoldType( self.HoldType )
end

function SWEP:PrimaryAttack()
	if CLIENT then return end

	local ply = self:GetOwner()
	local glycemia = ply.scp_1025_Glycemia or "1.2"

	ply:ChatPrint(glycemia .. " g/L")
	ply:EmitSound(SCP_1025_CONFIG.Sounds.GlycemiaReader, 75, math.random( 90, 110 ))
	self:SetNextPrimaryFire(CurTime() + self.PrimaryCooldown)
end

function SWEP:SecondaryAttack()
	if CLIENT then return end

	local ply = self:GetOwner()
	ply:DropWeapon(self)
end