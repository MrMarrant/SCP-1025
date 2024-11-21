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
* Call the disease for the player.
* @string disease The disease
* @Player ply The player to set the disease.
--]]
function scp_1025.CallDisease(disease, ply)
    if (not ply:Alive()) then return end
    SCP_1025_CONFIG.Diseases[disease](ply)
    hook.Call("SCP1025.CallDisease", nil, ply, disease) --? In case some dev wants to do something on disease call
end

function scp_1025.CommonCold(ply)
    local minDuration = SCP_1025_CONFIG.Settings.MinCommonCold
    local maxDuration = SCP_1025_CONFIG.Settings.MaxCommonCold
    local sneezeSounds = SCP_1025_CONFIG.Sounds.Sneezing
    if (not timer.Exists("SCP1025.CommonCold." .. ply:EntIndex())) then
        timer.Create("SCP1025.CommonCold." .. ply:EntIndex(), math.random(minDuration, maxDuration), SCP_1025_CONFIG.Settings.Repetitions, function ()
            if (not ply:IsValid()) then timer.Remove("SCP1025.CommonCold") return end
            ply:EmitSound(sneezeSounds[math.random(#sneezeSounds)], 75, math.random( 100, 110 ))
            timer.Adjust("SCP1025.CommonCold", math.random(minDuration, maxDuration))
        end)
    end
end

function scp_1025.Schizophrenia(ply)
end

--[[
* Set the gastroenteritis for the player.
* @Player ply The player to set the disease.
--]]
function scp_1025.Gastroenteritis(ply)
    local minDuration = SCP_1025_CONFIG.Settings.MinGastroenteritis
    local maxDuration = SCP_1025_CONFIG.Settings.MaxGastroenteritis

    if (not timer.Exists("SCP1025.Gastroenteritis." .. ply:EntIndex())) then
        timer.Create("SCP1025.Gastroenteritis." .. ply:EntIndex(), math.random(minDuration, maxDuration), SCP_1025_CONFIG.Settings.RepetitionsGastroenteritis, function ()
            if (not ply:IsValid()) then timer.Remove("SCP1025.CommonCold") return end

            ply:EmitSound(SCP_1025_CONFIG.Sounds.GastroenteritisVomiting, 75, math.random( 90, 110 ))
            util.Decal("YellowBlood", ply:GetPos() - Vector(0, 0, 1), ply:GetPos() + Vector(0, 0, 1), ply)

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
            util.Effect( "BloodImpact", effectdata )
            util.Effect( "BloodImpact", effectdata )

            net.Start(SCP_1025_CONFIG.NetVar.Gastroenteritis)
            net.Send(ply)
            timer.Adjust("SCP1025.Gastroenteritis", math.random(minDuration, maxDuration))
        end)
    end
end

function scp_1025.Myopia(ply)
    net.Start(SCP_1025_CONFIG.NetVar.Myopia)
    net.Send(ply)
end

function scp_1025.Rabies(ply)
end

--[[
* Set the huntington for the player.
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
* Set the asthma for the player.
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

function scp_1025.Diabetes(ply)
end

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
                local eyeAngle = ply:EyeAngles()
                local Direction = Angle(90, eyeAngle.y, eyeAngle.r)

                scp_1025.CreateBlinkEye(ply, 1, true, false)
                ply:SetEyeAngles(Direction)
                ply:Freeze(true)
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
    hook.Remove("Think", "SCP1025.AsthmaSprint." .. ply:EntIndex())
    ply:StopSound(SCP_1025_CONFIG.Sounds.Snoring)
    ply:Freeze(false)
    ply.scp_1025_Huntington_Symptom = nil

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

-- NET RECEIVERS
net.Receive(SCP_1025_CONFIG.NetVar.CallDisease, function(len, ply)
    local disease = net.ReadString()
    scp_1025.CallDisease(disease, ply)
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

        ply:StopSound(SCP_1025_CONFIG.Sounds.Snoring)
        ply:Freeze(false)
        scp_1025.CreateBlinkEye(ply, 1, true, true)
        scp_1025.KleineLevin(ply)
    end)
end)