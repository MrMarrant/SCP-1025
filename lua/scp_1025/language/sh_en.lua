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

local LANG_EN = {
    warningsettings = "Only Super Admins can change these values, all other roles will do nothing.",
    adminaccess = "You need to be Admin or Super Admin to access this menu.",
    durationprops_description = "Time before a props disappears.",
    fillall = "Please fill all the fields.",
    funcdontexist = "The function call doesn't exist.",
    needoneparam = "The function call needs to have only one parameter.",
    diseaseexist = "The disease already exist.",
    confirmcreation = "The disease has been created.",
    confirmdelete = "The disease has been fully remove.",
    indexempty = "The index choose is empty.",

    -- CONTEXT MENU
    adddisease = "Add custom disease",
    removedisease = "Remove custom disease",

    -- Rabies Disease
    rabies_phase2 = "You feel dizzy and confused.",
    rabies_phase2_hydrophobia = "You feel dizzy and confused, you have a total phobia of water, even hearing someone talk about water terrifies you.",
    rabies_phase3_aggressive = "You have an irresistible urge to attack the people around you ...",
    rabies_phase3_paralized = "You feel your body becoming increasingly stiff ...",
    rabies_phase3_symptom_paralized = "Your body stiffens ...",

    -- Schizophrenia Disease
    schizophrenia_crisis = "You are in a crisis, you see things that are not there, you hear voices that are not there, you feel things that are not ...",
}

scp_1025.AddLanguage("en", LANG_EN)