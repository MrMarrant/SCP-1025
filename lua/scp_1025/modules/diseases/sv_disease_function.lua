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

SCP_1025_CONFIG.Diseases = {
    ["common_cold"] = function (ply) scp_1025.CommonCold(ply) end,
    ["schizophrenia"] = function (ply) scp_1025.Schizophrenia(ply) end,
    ["gastroenteritis"] = function (ply) scp_1025.Gastroenteritis(ply) end,
    ["myopia"] = function (ply) scp_1025.Myopia(ply) end,
    ["rabies"] = function (ply) scp_1025.Rabies(ply) end,
    ["huntington"] = function (ply) scp_1025.Huntington(ply) end,
    ["asthma"] = function (ply) scp_1025.Asthma(ply) end,
    ["diabetes"] = function (ply) scp_1025.Diabetes(ply) end,
    ["kleine_levin"] = function (ply) scp_1025.KleineLevin(ply) end,
    ["pica"] = function (ply) scp_1025.Pica(ply) end,
    ["writer_block"] = function (ply) scp_1025.WriterBlock(ply) end,
}

for key, value in pairs(SCP_1025_CONFIG.CustomDisease) do
    SCP_1025_CONFIG.Diseases[key] = function (ply) _G[value.func](ply) end
end

--[[
* Play a sound for the player.
* @Player ply The player to set the disease.
* @string soundName The name of the sound.
--]]
local function PlaySoundClient(ply, soundName)
    net.Start(SCP_1025_CONFIG.NetVar.PlaySoundClient)
    net.WriteString(soundName)
    net.Send(ply)
end

--[[
* Set the sleep for the player (blink eye effect and freeze).
* @Player ply The player to set to sleep.
--]]
local function Sleep(ply)
    local eyeAngle = ply:EyeAngles()
    local Direction = Angle(90, eyeAngle.y, eyeAngle.r)

    scp_1025.CreateBlinkEye(ply, 1, true, false)
    ply:SetEyeAngles(Direction)
    ply:Freeze(true)
    ply.scp_1025_IsSleeping = true
end

--[[
* UnSleep a plyer and make him blink like he open eyes.
* @Player ply The player to unsleep.
--]]
local function UnSleep(ply)
    ply:StopSound(SCP_1025_CONFIG.Sounds.Snoring)
    ply:Freeze(false)
    scp_1025.CreateBlinkEye(ply, 1, true, true)
    ply.scp_1025_IsSleeping = nil
end

--[[
* Chatprint clienside.
* @Player ply The player to display the message.
* @string index The index of the message.
--]]
local function ChatPrint(ply, index)
    net.Start(SCP_1025_CONFIG.NetVar.ChatPrint)
    net.WriteString(index)
    net.Send(ply)
end

--[[
* Call the disease for the player.
* @string disease The disease
* @Player ply The player to set the disease.
--]]
local function CallDisease(disease, ply)
    if (not ply:Alive()) then return end
    SCP_1025_CONFIG.Diseases[disease](ply)
    hook.Call("SCP1025.CallDisease", nil, ply, disease) --? In case some dev wants to do something on disease call
end

--[[
* Set the common cold for the player (sneezing sound).
* @Player ply The player to set the disease.
--]]
function scp_1025.CommonCold(ply)
    local minDuration = SCP_1025_CONFIG.Settings.MinCommonCold
    local maxDuration = SCP_1025_CONFIG.Settings.MaxCommonCold
    local sneezeSounds = SCP_1025_CONFIG.Sounds.Sneezing
    if (not timer.Exists("SCP1025.CommonCold." .. ply:EntIndex())) then
        timer.Create("SCP1025.CommonCold." .. ply:EntIndex(), math.random(minDuration, maxDuration), SCP_1025_CONFIG.Settings.CommonColdRepetitions, function ()
            if (not ply:IsValid()) then timer.Remove("SCP1025.CommonCold") return end
            ply:EmitSound(sneezeSounds[math.random(#sneezeSounds)], 75, math.random( 100, 110 ))
            timer.Adjust("SCP1025.CommonCold", math.random(minDuration, maxDuration))
        end)
    end
end

-- TODO : Symptomes : Tout les X secondes, hallucinations auditives (Voix racontant du non-sens) avec des vertiges
-- TODO : Symptomes : Une fois de manière random en plus d'une hallucination auditive, 
-- TODO : le joueur peut faire une crise qui rajoute des hallucinations visuelles (Objets qui bougent, etc) avec overlay couleur saturée.
-- TODO : Avec l'ajout d'une aura sur les autres joueurs ou des entités au pif.
function scp_1025.Schizophrenia(ply)
    local delay = SCP_1025_CONFIG.Settings.SchizophreniaDelay
    local interval = SCP_1025_CONFIG.Settings.SchizophreniaInterval
    timer.Create("SCP1025.Schizophrenia.", delay + math.random(-interval, interval),0, function()
        if (not IsValid(ply)) then return end

        hook.Call("SchizophreniaSymptom", nil, ply)
    end)
end

--[[
* Set the gastroenteritis for the player (vomiting effect/decals and blur).
* @Player ply The player to set the disease.
--]]
function scp_1025.Gastroenteritis(ply)
    local minDuration = SCP_1025_CONFIG.Settings.MinGastroenteritis
    local maxDuration = SCP_1025_CONFIG.Settings.MaxGastroenteritis

    if (not timer.Exists("SCP1025.Gastroenteritis." .. ply:EntIndex())) then
        timer.Create("SCP1025.Gastroenteritis." .. ply:EntIndex(), math.random(minDuration, maxDuration), SCP_1025_CONFIG.Settings.RepetitionsGastroenteritis, function ()
            if (not ply:IsValid()) then return end

            scp_1025.Vomiting(ply)
            scp_1025.CreateBlurEffect(ply, 4)

            timer.Adjust("SCP1025.Gastroenteritis", math.random(minDuration, maxDuration))
        end)
    end
end

--[[
* Set the myopia for the player (blur effect).
* @Player ply The player to set the disease.
--]]
function scp_1025.Myopia(ply)
    net.Start(SCP_1025_CONFIG.NetVar.Myopia)
    net.Send(ply)
end

--[[
* Apply the rabies for the player (paralized/rage effect with overlay).
* @Player ply The player to set the disease.
--]]
function scp_1025.Rabies(ply)
    local delay = SCP_1025_CONFIG.Settings.RabiesDelay
    local interval = SCP_1025_CONFIG.Settings.RabiesInterval
    ply.scp_1025_Rabies = ply.scp_1025_Rabies or 1

    timer.Create("SCP1025.Rabies." .. ply:EntIndex(), delay + math.random(-interval, interval), 1, function()
        if (not IsValid(ply)) then return end

        hook.Call("NextPhaseRabies", nil, ply)
    end)
end

--[[
* Set the huntington for the player (random movement/shoot/eyesangle).
* @Player ply The player to set the disease.
--]]
function scp_1025.Huntington(ply)
    ply.scp_1025_Huntington = true
    local delay = SCP_1025_CONFIG.Settings.HuntingtonDelay
    local interval = math.random(1, SCP_1025_CONFIG.Settings.HuntingtonInterval)
    local delaySymptom = math.random(delay - interval, delay + interval)

    timer.Create( "SCP1025.Huntington." .. ply:EntIndex(), delaySymptom, 0, function()
        if (not IsValid(ply)) then return end
        if (not ply.scp_1025_Huntington) then return end

        hook.Call("NextSymptomHuntington", nil, ply)
        timer.Adjust("SCP1025.Huntington." .. ply:EntIndex(), math.random(delay - interval, delay + interval))
    end )
end

--[[
* Set the asthma for the player (sprint slowdown effect).
* @Player ply The player to set the disease.
--]]
function scp_1025.Asthma(ply)
    local oldRunSpeed = ply:GetRunSpeed()
    ply.scp_1025_IsRunning = false
    ply.scp_1025_SprintTime = 0
    ply.scp_1025_RecoverTime = nil
    local minRunSpeed = SCP_1025_CONFIG.Settings.MinRunSpeed
    local sprintDuration = SCP_1025_CONFIG.Settings.SprintDuration

    hook.Add("Think", "SCP1025.AsthmaSprint." .. ply:EntIndex(), function()
        if (not IsValid(ply)) then return end

        local cur = CurTime()
        local sprintTime = ply.scp_1025_SprintTime
        local recoverTime = ply.scp_1025_RecoverTime
        if (recoverTime) then
            if (cur > recoverTime) then
                ply.scp_1025_RecoverTime = nil
                ply.scp_1025_SprintTime = 0
                -- TODO : Ajouter un son de souffle
            end
        else
            if ply:KeyDown(IN_SPEED) and ply:IsOnGround() then
                ply.scp_1025_IsRunning = true
                ply:SetRunSpeed(math.Clamp(oldRunSpeed * (1 - sprintTime / sprintDuration), minRunSpeed, oldRunSpeed))
                ply.scp_1025_SprintTime = math.Clamp(ply.scp_1025_SprintTime + FrameTime(), 0, sprintDuration)
            else
                if (ply.scp_1025_IsRunning) then
                    ply.scp_1025_RecoverTime = cur + SCP_1025_CONFIG.Settings.RecoveryDuration
                    ply:SetRunSpeed(minRunSpeed)
                    ply.scp_1025_SprintTime = 0
                    -- TODO : Ajouter un son de respiration
                end
                ply.scp_1025_IsRunning = false
            end
        end
    end)
end

--[[
* Set the diabetes for the player (Player need to manage glycemia with food/insulin).
* @Player ply The player to set the disease.
--]]
function scp_1025.Diabetes(ply)
    ply.scp_1025_Glycemia = SCP_1025_CONFIG.Settings.NormalGlycemia
    ply.scp_1025_CoefficientGlycemia = SCP_1025_CONFIG.Settings.CoefficientIncreaseGlycemia
    ply.scp_1025_HypoGlycemia = false
    ply.scp_1025_HyperGlycemia = false
    local interval = SCP_1025_CONFIG.Settings.IntervalGlycemia
    local hypoGlycemia = SCP_1025_CONFIG.Settings.HypoGlycemia
    local hyperGlycemia = SCP_1025_CONFIG.Settings.HyperGlycemia
    local delay = SCP_1025_CONFIG.Settings.DelayUpdateGlycemia
    local nextGlycemia = CurTime() + delay

    hook.Add("Think", "Think.SCP1025.Diabetes." .. ply:EntIndex(), function()
        if (not IsValid(ply)) then return end

        local cur = CurTime()
        local currentGlycemia = ply.scp_1025_Glycemia

        if (cur > nextGlycemia) then
            currentGlycemia = math.Clamp(ply.scp_1025_Glycemia - interval, 0, 6)
            ply.scp_1025_Glycemia = currentGlycemia
            nextGlycemia = cur + delay
        end
        if (currentGlycemia <= hypoGlycemia and not ply.scp_1025_HypoGlycemia) then
            ply.scp_1025_HypoGlycemia = true
            hook.Call("HypoGlycemiaDiabetes", nil, ply)
        elseif (currentGlycemia >= hyperGlycemia and not ply.scp_1025_HyperGlycemia) then
            ply.scp_1025_HyperGlycemia = true
            hook.Call("HyperGlycemiaDiabetes", nil, ply)
        elseif (currentGlycemia < hyperGlycemia and currentGlycemia > hypoGlycemia and (ply.scp_1025_HypoGlycemia or ply.scp_1025_HyperGlycemia)) then
            ply.scp_1025_HypoGlycemia = false
            ply.scp_1025_HyperGlycemia = false
            timer.Remove("SCP1025.Diabetes.HypoGlycemia." .. ply:EntIndex())
            timer.Remove("SCP1025.Diabetes.HyperGlycemia." .. ply:EntIndex())
            timer.Remove("SCP1025.Diabetes.ComaGlycemia." .. ply:EntIndex())
            ply:SetRunSpeed(ply.scp_1025_OldRunSpeed)
            UnSleep(ply)
        end

        if ((currentGlycemia <= SCP_1025_CONFIG.Settings.MaxHypoGlycemia or currentGlycemia >= SCP_1025_CONFIG.Settings.MaxHyperGlycemia) and not ply.scp_1025_IsSleeping) then
            Sleep(ply)
            timer.Create("SCP1025.Diabetes.ComaGlycemia." .. ply:EntIndex(), SCP_1025_CONFIG.Settings.DelayComa, 1, function()
                if (not IsValid(ply)) then return end
                if (not ply.scp_1025_HypoGlycemia or ply.scp_1025_HyperGlycemia) then return end

                ply:Kill()
            end)
        end
    end)
end

--[[
* Set the kleine levin for the player (sleep effect/blink eye).
* @Player ply The player to set the disease.
--]]
function scp_1025.KleineLevin(ply)
    local delay = SCP_1025_CONFIG.Settings.KleineLevinDelay
    local minInterval = SCP_1025_CONFIG.Settings.KleineLevinMinInterval
    local maxInterval = SCP_1025_CONFIG.Settings.KleineLevinMaxInterval
    local repetition = SCP_1025_CONFIG.Settings.KleineLevinRepetition
    local leaseSound = SCP_1025_CONFIG.Sounds.Lease
    local i = 0

    if (not timer.Exists("SCP1025.KleineLevin." .. ply:EntIndex())) then
        timer.Create("SCP1025.KleineLevin." .. ply:EntIndex(), delay, repetition, function ()
            if (not IsValid(ply)) then return end

            i = i + 1
            if (i == repetition) then
                Sleep(ply)
                ply:StartLoopingSound(SCP_1025_CONFIG.Sounds.Snoring)
                hook.Call("WakeUpFromKleineLevin", nil, ply)
            else
                net.Start(SCP_1025_CONFIG.NetVar.KleineLevin)
                net.Send(ply)
                delay = math.random(delay - minInterval, delay - maxInterval)
                timer.Adjust("SCP1025.KleineLevin." .. ply:EntIndex(), delay)
                ply:EmitSound(leaseSound, 75, math.random( 90, 110 ))
            end
        end)
    end
end

function scp_1025.Pica(ply)
end

-- TODO : BlackScreen -> Impossible d'entendre
-- TODO : Voix vers le joueur d'une conversation d'un auteur avec son éditeur essayant de le convaincre de publier son encyclopédie.
-- TODO : A la fin de la conversation, quand l'éditeur accepte de le publier, l'auteur s'adresse au joueur : Pourrions nous continuer cette discussion plus tard ? Je pense que quelqu'un nous écoute, n'est ce pas ?
-- TODO : 
function scp_1025.WriterBlock(ply)
end

--[[
* Clear the diseases for the player.
* @Player ply The player to clear diseases.
--]]
function scp_1025.ClearDiseases(ply)
    timer.Remove("SCP1025.CommonCold." .. ply:EntIndex())
    timer.Remove("SCP1025.NextSymptomHuntington." .. ply:EntIndex())
    timer.Remove("SCP1025.Huntington." .. ply:EntIndex())
    timer.Remove("SCP1025.Gastroenteritis." .. ply:EntIndex())
    timer.Remove("SCP1025.KleineLevin." .. ply:EntIndex())
    timer.Remove("SCP1025.KleineLevin.WakeUp." .. ply:EntIndex())
    timer.Remove("SCP1025.Diabetes.HypoGlycemia." .. ply:EntIndex())
    timer.Remove("SCP1025.Diabetes.HyperGlycemia." .. ply:EntIndex())
    timer.Remove("SCP1025.Diabetes.ComaGlycemia." .. ply:EntIndex())
    timer.Remove("SCP1025.Diabetes.Rabies." .. ply:EntIndex())
    timer.Remove("SCP1025.Diabetes.Rabies.Phase1." .. ply:EntIndex())
    timer.Remove("SCP1025.Diabetes.Rabies.Phase2." .. ply:EntIndex())
    timer.Remove("SCP1025.Diabetes.Rabies.Phase3Paralized." .. ply:EntIndex())
    timer.Remove("SCP1025.Diabetes.Rabies.Phase3Paralized." .. ply:EntIndex())
    timer.Remove("SCP1025.Schizophrenia." .. ply:EntIndex())
    hook.Remove("Think", "SCP1025.AsthmaSprint." .. ply:EntIndex())
    hook.Remove("Think", "Think.SCP1025.Diabetes." .. ply:EntIndex())
    hook.Remove("Think", "Think.SCP1025.Rabies.ParalizedPhaseRabies" .. ply:EntIndex())
    ply:StopSound(SCP_1025_CONFIG.Sounds.Snoring)
    if (ply.scp_1025_IsSleeping) then ply:Freeze(false) end
    ply.scp_1025_Huntington_Symptom = nil
    ply.scp_1025_Glycemia = nil
    ply.scp_1025_HypoGlycemia = nil
    ply.scp_1025_HyperGlycemia = nil
    ply.scp_1025_IsSleeping = nil
    ply.scp_1025_Rabies = nil
    ply.scp_1025_RabiesParalized = nil
    ply.scp_1025_OldRunSpeed = nil
    ply.scp_1025_OldWalkSpeed = nil

    net.Start(SCP_1025_CONFIG.NetVar.ClearDisease)
    net.Send(ply)
end

--[[
* Create a blink eye effect for the player.
* @Player ply The player to create the blink eye effect.
* @number duration The duration of the blink eye effect.
* @boolean oneSide If the blink eye effect is only on one side.
* @boolean wasClose If the blink eye effect is close.
--]]
function scp_1025.CreateBlinkEye(ply, duration, oneSide, wasClose)
    net.Start(SCP_1025_CONFIG.NetVar.CreateBlinkEye)
    net.WriteFloat(duration)
    net.WriteBool(oneSide)
    net.WriteBool(wasClose)
    net.Send(ply)
end

--[[
* Create a blur effect for the player.
* @Player ply The player to set the disease.
* @number duration The duration of the blur effect.
* @boolean sfx If the blur effect has a sound effect.
--]]
function scp_1025.CreateBlurEffect(ply, duration, sfx)
    net.Start(SCP_1025_CONFIG.NetVar.CreateBlurEffect)
    net.WriteFloat(duration)
    net.WriteBool(sfx)
    net.Send(ply)
end

--[[
* Make player vomit.
* @Player ply The player to set the disease.
* @string effectName The effect name.
* @string decal The decal name.
--]]
function scp_1025.Vomiting(ply, effectName, decal)
    effectName = effectName or "BloodImpact"
    decal = decal or "YellowBlood"
    ply:EmitSound(SCP_1025_CONFIG.Sounds.GastroenteritisVomiting, 75, math.random( 90, 110 ))
    util.Decal(decal, ply:GetPos() - Vector(0, 0, 1), ply:GetPos() + Vector(0, 0, 1), ply)

    local attachments = ply:GetAttachments()
    local keyMouth = nil

    for key, value in ipairs(attachments) do
        if (value.name == "mouth") then keyMouth = value.id end --? We find the attachment mouth
    end

    local offsetvec = keyMouth and ply:GetAttachment( keyMouth ).Pos or Vector(2.5, -5.6, 0 )
    local effectdata = EffectData()
    effectdata:SetOrigin(offsetvec)
    effectdata:SetScale(100)
    effectdata:SetColor(1)
    util.Effect(effectName, effectdata)
    util.Effect(effectName, effectdata)
end

-- NET RECEIVERS
net.Receive(SCP_1025_CONFIG.NetVar.CallDisease, function(len, ply)
    local disease = net.ReadString()
    CallDisease(disease, ply)
end)

-- HOOKS
hook.Add("StartCommand", "StartCommand.SCP1025", function(ply, cmd)
    if (not ply:IsBot() and ply:Alive() and ply.scp_1025_Huntington_Symptom) then
        cmd:RemoveKey(IN_DUCK) --? We don't want the ply to crouch
        cmd:ClearMovement()
        cmd:ClearButtons()
        local speedMove = math.random(80, 200)
        if not ply.SCP1025_IsMoving then
            ply.SCP1025_IsMoving = true
            local Direction = Vector(math.Rand(-1, 1), math.Rand(-1, 1), 0):GetNormalized()
            cmd:SetViewAngles((Direction):GetNormalized():Angle())
            ply:SetEyeAngles((Direction):GetNormalized():Angle())

            local shootDuration = math.random(0.1, SCP_1025_CONFIG.Settings.HuntingtonShootDuration)
            ply:ConCommand("+attack")
            timer.Simple(shootDuration, function()
                if IsValid(ply) then
                    ply:ConCommand("-attack")
                end
            end)
        end
        if (ply.SCP1025_IsMoving) then
            cmd:SetForwardMove(speedMove)
        end
    end
end)

hook.Add("NextSymptomHuntington", "NextSymptomHuntington.SCP_1025", function(ply)
    if (not ply:IsValid()) then return end
    if (not ply.scp_1025_Huntington) then return end

    ply.scp_1025_Huntington_Symptom = true
    -- TODO : Jouer un son ?

    timer.Create("SCP1025.NextSymptomHuntington." .. ply:EntIndex(), SCP_1025_CONFIG.Settings.HuntingtonDuration, 1, function()
        if (not IsValid(ply)) then return end
        if (not ply.scp_1025_Huntington) then return end

        ply.scp_1025_Huntington_Symptom = nil
        ply.SCP1025_IsMoving = nil
    end)
end)

hook.Add("WakeUpFromKleineLevin", "WakeUpFromKleineLevin.SCP_1025", function(ply)
    if (not ply:IsValid()) then return end

    timer.Create("SCP1025.KleineLevin.WakeUp." .. ply:EntIndex(), SCP_1025_CONFIG.Settings.KleineLevinSleepDuration, 1, function()
        if (not IsValid(ply)) then return end

        UnSleep(ply)
        scp_1025.KleineLevin(ply)
    end)
end)

hook.Add("HypoGlycemiaDiabetes", "HypoGlycemiaDiabetes.SCP_1025", function(ply)
    if (not IsValid(ply)) then return end
    if (not ply.scp_1025_HypoGlycemia) then return end

    local delaySymptom = SCP_1025_CONFIG.Settings.DelaySymptomGlycemia
    local intervalSymptom = SCP_1025_CONFIG.Settings.IntervalSymptomGlycemia
    local coefficientSpeed = SCP_1025_CONFIG.Settings.CoefficientSpeedHypo
    local hypoGlycemia = SCP_1025_CONFIG.Settings.HypoGlycemia

    ply.scp_1025_OldRunSpeed = ply:GetRunSpeed()
    ply:SetRunSpeed(ply.scp_1025_OldRunSpeed - (1 - (coefficientSpeed * math.Clamp(hypoGlycemia / ply.scp_1025_Glycemia, 0, 1))))

    timer.Create("SCP1025.Diabetes.HypoGlycemia." .. ply:EntIndex(), 2, 0, function()
        if (not IsValid(ply)) then return end
        if (not ply.scp_1025_HypoGlycemia) then return end

        local glycemia = ply.scp_1025_Glycemia
        local interval = intervalSymptom * math.Clamp(glycemia / hypoGlycemia, 0, 1)
        local coefficient = 1 - (coefficientSpeed * math.Clamp(hypoGlycemia / glycemia, 0, 1))
        scp_1025.CreateBlurEffect(ply, 3, true)
        ply:SetRunSpeed(ply.scp_1025_OldRunSpeed * coefficient)
        timer.Adjust("SCP1025.Diabetes.HypoGlycemia." .. ply:EntIndex(), delaySymptom - interval)
    end)
end)

hook.Add("HyperGlycemiaDiabetes", "HyperGlycemiaDiabetes.SCP_1025", function(ply)
    if (not IsValid(ply)) then return end
    if (not ply.scp_1025_HyperGlycemia) then return end

    local delaySymptom = SCP_1025_CONFIG.Settings.DelaySymptomGlycemia
    local intervalSymptom = SCP_1025_CONFIG.Settings.IntervalSymptomGlycemia
    local probabiltyVomiting = SCP_1025_CONFIG.Settings.ProbabilityVomiting
    local coefficientSpeed = SCP_1025_CONFIG.Settings.CoefficientSpeedHyper
    local highHyper = SCP_1025_CONFIG.Settings.HighHyperGlycemia

    ply.scp_1025_OldRunSpeed = ply:GetRunSpeed()
    ply:SetRunSpeed(ply.scp_1025_OldRunSpeed - (1 - (coefficientSpeed * math.Clamp(highHyper / ply.scp_1025_Glycemia, 0, 1))))

    timer.Create("SCP1025.Diabetes.HyperGlycemia." .. ply:EntIndex(), 2, 0, function ()
        if (not IsValid(ply)) then return end
        if (not ply.scp_1025_HyperGlycemia) then return end

        local glycemia = ply.scp_1025_Glycemia
        local randomSymptom = math.random(1, probabiltyVomiting)
        local interval = intervalSymptom * math.Clamp(glycemia / highHyper, 0, 1)
        local coefficient = 1 - (coefficientSpeed * math.Clamp(highHyper / glycemia, 0, 1))

        if (randomSymptom > 1) then
            scp_1025.CreateBlinkEye(ply, 0.5)
            scp_1025.CreateBlurEffect(ply, 2)
        else
            scp_1025.Vomiting(ply)
        end
        ply:SetRunSpeed(ply.scp_1025_OldRunSpeed * coefficient)
        timer.Adjust("SCP1025.Diabetes.HyperGlycemia." .. ply:EntIndex(), delaySymptom - interval)
    end)
end)

hook.Add("OnGlucideConsumption", "OnGlucideConsumption.SCP_1025", function(ply, glucide)
    if (not IsValid(ply)) then return end
    if (not ply.scp_1025_Glycemia) then return end

    ply.scp_1025_Glycemia = math.Clamp(ply.scp_1025_Glycemia + glucide, 0, SCP_1025_CONFIG.Settings.MaxHyperGlycemia)
end)

hook.Add("NextPhaseRabies", "NextPhaseRabies.SCP_1025", function(ply)
    if (not IsValid(ply)) then return end
    if (not ply.scp_1025_Rabies) then return end

    local phase = ply.scp_1025_Rabies

    --? Blur effect
    if (phase == 1) then
        timer.Create("SCP1025.Diabetes.Rabies.Phase1." .. ply:EntIndex(), SCP_1025_CONFIG.Settings.RabiesIntervalBlur, 0, function()
            if (not IsValid(ply)) then return end
            if (not ply.scp_1025_Rabies) then return end

            scp_1025.CreateBlurEffect(ply, 2, SCP_1025_CONFIG.Sounds.Dizzy)
        end)
    --? 80% rage with hydrophobia, else init paralized
    elseif (phase == 2) then
        local coefficientDammage = SCP_1025_CONFIG.Settings.CoefficientHydrophobia
        local randomSymtom = math.random(1, 10)
        if (randomSymtom <= 2) then
            ply.scp_1025_RabiesParalized = true
            ChatPrint(ply, "rabies_phase2")
        else
            ChatPrint(ply, "rabies_phase2_hydrophobia")
            hook.Add("Think", "Think.SCP1025.Rabies.Hydrophobia", function()
                if (not IsValid(ply)) then return end
                if (not ply.scp_1025_Rabies) then return end

                if (ply:WaterLevel() > 1) then
                    ply:TakeDamage(engine.TickInterval() * coefficientDammage, ply, ply)
                end
            end)
            timer.Create("SCP1025.Diabetes.Rabies.Phase2." .. ply:EntIndex(), SCP_1025_CONFIG.Settings.RabiesIntervalBlur, 0, function()
                if (not IsValid(ply)) then return end
                if (not ply.scp_1025_Rabies) then return end

                scp_1025.Vomiting(ply, "spit_saliva", "")
            end)
        end
    --? Give fist weapon and chatprint if rage, else paralized the player with time
    elseif (phase == 3) then
        net.Start(SCP_1025_CONFIG.NetVar.RabiesPhase3)
        net.Send(ply)
        if (ply.scp_1025_RabiesParalized) then
            ply.scp_1025_OldRunSpeed = ply:GetRunSpeed()
            ply.scp_1025_OldWalkSpeed = ply:GetWalkSpeed()
            local repetition = SCP_1025_CONFIG.Settings.RabiesParalizedRepetition
            local i = 0

            ChatPrint(ply, "rabies_phase3_paralized")
            timer.Create("SCP1025.Diabetes.Rabies.Phase3Paralized." .. ply:EntIndex(), SCP_1025_CONFIG.Settings.RabiesPhase3Duration, repetition, function()
                if (not IsValid(ply)) then return end
                if (not ply.scp_1025_Rabies) then return end

                i = i + 1
                local newRunSpeed = Lerp(i / repetition, ply.scp_1025_OldRunSpeed, 0)
                local newWalkSpeed = Lerp(i / repetition, ply.scp_1025_OldWalkSpeed, 0)
                ply:SetRunSpeed(newRunSpeed)
                ply:SetWalkSpeed(newWalkSpeed)
                ChatPrint(ply, "rabies_phase3_symptom_paralized")
                if (i == repetition) then hook.Call("ParalizedPhaseRabies", nil, ply) end
            end)
        else
            ChatPrint(ply, "rabies_phase3_aggressive")
            ply:Give("weapon_fists")
        end
    end

    ply.scp_1025_Rabies = phase + 1
    if (ply.scp_1025_Rabies <= 3) then
        scp_1025.Rabies(ply)
    end
end)

hook.Add("ParalizedPhaseRabies", "ParalizedPhaseRabies.SCP1025", function(ply)
    timer.Create("SCP1025.Diabetes.Rabies.ParalizedPhaseRabies." .. ply:EntIndex(), SCP_1025_CONFIG.Settings.RabiesDelayParalized, 1, function()
        if (not IsValid(ply)) then return end
        if (not ply.scp_1025_Rabies) then return end

        ply:Kill()
    end)
end)

hook.Add("SchizophreniaSymptom", "SchizophreniaSymptom.SCP1025", function(ply)
    local randomCrisis = math.random(1, 10)

    scp_1025.CreateBlurEffect(ply, 3, SCP_1025_CONFIG.Sounds.Dizzy)
    if (randomCrisis >= 1) then
        -- TODO : Crise le joueur peut faire une crise qui rajoute des hallucinations visuelles (Objets qui bougent, etc) avec overlay couleur saturée.
        -- TODO : Avec l'ajout d'une aura sur les autres joueurs ou des entités au pif.
        net.Start(SCP_1025_CONFIG.NetVar.SchizophreniaCrisis)
        net.Send(ply)
    else
        local sounds = SCP_1025_CONFIG.Sounds.Hallucinations
        PlaySoundClient(ply, sounds[math.random(#sounds)])
        -- TODO : Faire un effet de texte comme avec SCP-035
    end
end)