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

local LANG_FR = {
    warningsettings = "Seuls les superadministrateurs peuvent modifier ces valeurs, tous les autres rôles ne feront rien",
    adminaccess = "Vous devez être Admin ou Super Admin pour accéder à ce menu",
    fillall = "Veuillez remplir tous les champs.",
    funcdontexist = "L'appel de fonction n'existe pas",
    needoneparam = "L'appel de fonction ne doit avoir qu'un seul paramètre",
    diseaseexist = "La maladie existe déjà",
    confirmcreation = "La maladie a été créée",
    confirmdelete = "La maladie a été entièrement supprimée",
    indexempty = "L'index choisi est vide",

    -- MENU CONTEXTUEL
    adddisease = "Ajouter une maladie personnalisée",
    removedisease = "Supprimer une maladie personnalisée",

    -- Asthma
    asthma = "Vous ressentez une tension dans la poitrine, vous avez du mal à respirer, vous devez prendre votre inhalateur rapidement ...",

    -- Rabies Disease
    rabies_phase2 = "Vous vous sentez étourdi et confus",
    rabies_phase2_hydrophobia = "Vous vous sentez étourdi et confus, vous avez une phobie totale de l'eau, le simple fait d'entendre quelqu'un parler d'eau vous terrifie",
    rabies_phase3_aggressive = "Vous avez une envie irrésistible d'attaquer les gens autour de vous...",
    rabies_phase3_paralized = "Vous sentez que votre corps devient de plus en plus raide ...",
    rabies_phase3_symptom_paralized = "Votre corps se raidit ...",

    -- Schizophrénie
    schizophrenia_crisis = "Vous êtes en crise, vous voyez des choses qui n'existent pas, vous entendez des voix qui n'existent pas, vous ressentez des choses qui n'existent pas ...",

    schizophrenia_talking_voice_v1_1 = "Regardez ce qu'il fait encore, il se croit discret",
    schizophrenia_talking_voice_v1_2 = "Si pathétique, il pense que personne ne sait. Mais je le sais.",
    schizophrenia_talking_voice_v1_3 = "Pourquoi es-tu encore là ? Bouge ! Fais quelque chose pour une fois !",
    schizophrenia_talking_voice_v1_4 = "Non, il ne peut pas. Il est trop faible, comme toujours.",

    schizophrenia_talking_voice_v2_1 = "Arrête, arrête de parler ! Tu lui fais peur",
    schizophrenia_talking_voice_v2_2 = "On ne lui fait pas peur, on lui montre la vérité",
    schizophrenia_talking_voice_v2_3 = "Quelle vérité ? Vous le rendez juste paranoïaque",
    schizophrenia_talking_voice_v2_4 = "Paranoïaque ? Ha ! Il est déjà paranoïaque. Nous l'aidons juste à s'en rendre compte",


    schizophrenia_talking_voice_v3_1 = "Écoutez-nous ! Nous sommes les seuls à vous comprendre vraiment",
    schizophrenia_talking_voice_v3_2 = "Mais fais attention... ils sont partout. Tu les vois ? Dans l'ombre, juste là.",
    schizophrenia_talking_voice_v3_3 = "Non, ils ne sont pas réels. Ignorez-les, concentrez-vous !",
    schizophrenia_talking_voice_v3_4 = "Se concentrer ? Ha ! Comme si ça pouvait changer quoi que ce soit. Tout est déjà foutu.",

    schizophrenia_talking_voice_v4_1 = "Regarde-toi dans le miroir. Regarde bien. Est-ce que c'est toi ?",
    schizophrenia_talking_voice_v4_2 = "Ne les laisse pas te contrôler. Mais ils regardent... ils écoutent.",
    schizophrenia_talking_voice_v4_3 = "Non, tu es en sécurité ici. Respire. Tu es fort.",
    schizophrenia_talking_voice_v4_4 = "Il est brisé. Juste une marionnette errant dans un monde qui ne veut pas de lui.",

    -- Paranoïaque
    paranoid = "Vous avez l'impression que n'importe qui a pu être infecté par SCP-1025. Tout le monde est suspect...",

    -- Form
    error_form = "Erreur",
    ok_form = "OK",

    -- Other
    chromium = "Je vous recommende vivement d'utiliser plutot la branche\nchromium x86-64 pour une meilleur stabilité de SCP-1025",

    -- SCP-500
    consume_scp500 = "Vous avez consommé SCP-500, vous vous sentez mieux, comme jamais auparavant.",
    remaining_pills = "Pilules restantes : ",
}

scp_1025.AddLanguage("fr", LANG_FR)