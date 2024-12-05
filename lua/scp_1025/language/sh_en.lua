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

    -- Asthma
    asthma = "You feel a tightness in your chest, you have trouble breathing, you need to take your inhaler quick ...",

    -- Rabies Disease
    rabies_phase2 = "You feel dizzy and confused.",
    rabies_phase2_hydrophobia = "You feel dizzy and confused, you have a total phobia of water, even hearing someone talk about water terrifies you.",
    rabies_phase3_aggressive = "You have an irresistible urge to attack the people around you ...",
    rabies_phase3_paralized = "You feel your body becoming increasingly stiff ...",
    rabies_phase3_symptom_paralized = "Your body stiffens ...",

    -- Schizophrenia Disease
    schizophrenia_crisis = "You are in a crisis, you see things that are not there, you hear voices that are not there, you feel things that are not ...",

    schizophrenia_talking_voice_v1_1 = "Look at what he's doing again, he thinks he's being discreet.",
    schizophrenia_talking_voice_v1_2 = "So pathetic, he thinks no one knows. But I know.",
    schizophrenia_talking_voice_v1_3 = "Why are you still here? Move! Do something for once!",
    schizophrenia_talking_voice_v1_4 = "He can't. He's too weak, as always.",

    schizophrenia_talking_voice_v2_1 = "Stop, stop talking! You're scaring him.",
    schizophrenia_talking_voice_v2_2 = "We're not scaring him; we're showing him the truth.",
    schizophrenia_talking_voice_v2_3 = "What truth? You're just making him paranoid.",
    schizophrenia_talking_voice_v2_4 = "Paranoid? Ha! He's already paranoid. We're just helping him to see it.",


    schizophrenia_talking_voice_v3_1 = "Listen to us! We're the only ones who truly understand you.",
    schizophrenia_talking_voice_v3_2 = "But be careful... they're everywhere. Do you see them? In the shadows, right there.",
    schizophrenia_talking_voice_v3_3 = "No, they're not real. Ignore them, focus!",
    schizophrenia_talking_voice_v3_4 = "Focus? Ha! Like that would change anything. Everything's already ruined.",

    schizophrenia_talking_voice_v4_1 = "Look in the mirror. Look closely. Is that you?",
    schizophrenia_talking_voice_v4_2 = "Don't let them control you. But they're watching... they're listening.",
    schizophrenia_talking_voice_v4_3 = "No, you're safe here. Breathe. You're strong.",
    schizophrenia_talking_voice_v4_4 = "He's broken. Just a puppet wandering in a world that doesn't want him.",

    -- Paranoid
    paranoid = "You get the impression that anyone could have been infected by SCP-1025. Everyone is a suspect ...",

    -- Form
    error_form = "Error",
    ok_form = "OK",

    -- Other
    chromium = "You are using the base branch version.\nI strongly recommend using the chromium branch x86-64 version\ninstead for better stability for SCP-1025.",
}

scp_1025.AddLanguage("en", LANG_EN)