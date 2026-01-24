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

local LANG_RU = {
    warningsettings = "Только Супер Админы могут изменить эти значения, все остальные роли ничего не сделают.",
    adminaccess = "Вам нужно быть Админом или Супер Админом чтобы получить доступ к этому меню.",
    fillall = "Пожалуста заполните все поля.",
    funcdontexist = "Вызов функции не существует.",
    needoneparam = "Фызов функции должен иметь только один параметр.",
    diseaseexist = "Болезнь уже существует.",
    confirmcreation = "Болезнь была создана.",
    confirmdelete = "Болезнь была полностю удалена.",
    indexempty = "Выбор индекса пуст.",

    -- CONTEXT MENU
    adddisease = "Добавить пользовательскую болезнь.",
    removedisease = "Удалить пользовательскую болезнь.",

    -- Asthma
    asthma = "Ты чувствуешь напряжение в своей груди, у тебя проблемы с дыханием, тебе надо быстро взять ингалятор ...",

    -- Rabies Disease
    rabies_phase2 = "Ты чуствуеш головокружение и растерянность.",
    rabies_phase2_hydrophobia = "Ты чуствуеш головокружение и растерянность, у тебя настоящая фобия воды, даже разговори про воду пугают тебя.",
    rabies_phase3_aggressive = "У тебя есть непреодолимое влечение атаковать людей вокруг тебя ...",
    rabies_phase3_paralized = "Ты чуствуешь становится более жестче ...",
    rabies_phase3_symptom_paralized = "Твое тело напряжено ...",

    -- Schizophrenia Disease
    schizophrenia_crisis = "Ты в кризисе, ты видишь вещи которых там нету, ты слишыш голоса которых там нету, ты чуствуеш вещи которых не существует ...",

    schizophrenia_talking_voice_v1_1 = "Посмотри что он делает опять, он думает что он действует осмотрительно.",
    schizophrenia_talking_voice_v1_2 = "Такой жалкий, он думает что никто не узнает. Но я знаю.",
    schizophrenia_talking_voice_v1_3 = "Почему ты до сих пор здесь? Двигайся! Зделай что нибудь!",
    schizophrenia_talking_voice_v1_4 = "Он не может. Он очень слаб, как всегда.",

    schizophrenia_talking_voice_v2_1 = "Перкрати, прекрати разговаривать! Ты его пугаешь.",
    schizophrenia_talking_voice_v2_2 = "Мы не пугаем его; мы показиваем ему правду.",
    schizophrenia_talking_voice_v2_3 = "Какую правду? Ты просто делаешь его параноидом.",
    schizophrenia_talking_voice_v2_4 = "Паранойдом? Ха! Он уже параноид. Мы ему просто помогаем увидеть это.",


    schizophrenia_talking_voice_v3_1 = "Послушай нас! Только мы по-настоящему понимаем вас.",
    schizophrenia_talking_voice_v3_2 = "Но будь осторожен... они повсюду. Ты видешь их? В тенях, прямо там.",
    schizophrenia_talking_voice_v3_3 = "Нет, они не настоящие. Игноируй их, фокусируйся!",
    schizophrenia_talking_voice_v3_4 = "Фокусируйся? Ха! Вот так может изменить что угодно. Уже всë разрушено.",

    schizophrenia_talking_voice_v4_1 = "Посмотри в зеркало. Посмотри поближе. Это ты?",
    schizophrenia_talking_voice_v4_2 = "Не давай им контролировать тебя. Но они смотрят... они слушают.",
    schizophrenia_talking_voice_v4_3 = "Нет, ты безопасен тут. Дышы. Ты сильный.",
    schizophrenia_talking_voice_v4_4 = "Он сломанный. Как кукла блуждающая в мире которое не хочет его.",

    -- Paranoid
    paranoid = "У тебя впечитления что SCP-1025 мог заразить кого угодно. Все подозрительны ...",

    -- Form
    error_form = "Ошибка",
    ok_form = "Хорошо",

    -- Other
    chromium = "Вы используете версию из базовой ветки.\nЯ настоятельно рекомендую использовать версию из ветки chromium x86-64\nдля большей стабильности SCP-1025.",

    -- SCP-500
    consume_scp500 = "Ты употребил SCP-500, ты чуствуешь лучше, как никогда.",
    remaining_pills = "Оставшиеся таблетки : ",
}

scp_1025.AddLanguage("ru", LANG_RU)