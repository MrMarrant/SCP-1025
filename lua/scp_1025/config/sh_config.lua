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

-- NET VAR
SCP_1025_CONFIG.NetVar = {}
SCP_1025_CONFIG.NetVar.IndexPage = "SCP_1025_CONFIG.NetVar.IndexPage"
SCP_1025_CONFIG.NetVar.CallDisease = "SCP_1025_CONFIG.NetVar.CallDisease"
SCP_1025_CONFIG.NetVar.AddCustomDisease = "SCP_1025_CONFIG.NetVar.AddCustomDisease"
SCP_1025_CONFIG.NetVar.ErrorMessage = "SCP_1025_CONFIG.NetVar.ErrorMessage"
SCP_1025_CONFIG.NetVar.CreateCustomDisease = "SCP_1025_CONFIG.NetVar.CreateCustomDisease"
SCP_1025_CONFIG.NetVar.ConfirmMenu = "SCP_1025_CONFIG.NetVar.ConfirmMenu"
SCP_1025_CONFIG.NetVar.DeleteCustomDisease = "SCP_1025_CONFIG.NetVar.DeleteCustomDisease"
SCP_1025_CONFIG.NetVar.RemoveCustomDisease = "SCP_1025_CONFIG.NetVar.RemoveCustomDisease"
SCP_1025_CONFIG.NetVar.UpdateTableDisease = "SCP_1025_CONFIG.NetVar.UpdateTableDisease"
SCP_1025_CONFIG.NetVar.CloseMenu = "SCP_1025_CONFIG.NetVar.CloseMenu"
SCP_1025_CONFIG.NetVar.ClearDisease = "SCP_1025_CONFIG.NetVar.ClearDisease"
SCP_1025_CONFIG.NetVar.Myopia = "SCP_1025_CONFIG.NetVar.Myopia"
SCP_1025_CONFIG.NetVar.KleineLevin = "SCP_1025_CONFIG.NetVar.KleineLevin"
SCP_1025_CONFIG.NetVar.CreateBlinkEye = "SCP_1025_CONFIG.NetVar.CreateBlinkEye"
SCP_1025_CONFIG.NetVar.CreateBlurEffect = "SCP_1025_CONFIG.NetVar.CreateBlurEffect"

-- Model Path
SCP_1025_CONFIG.Models = {}
SCP_1025_CONFIG.Models.ModelBook = "models/scp_1025/scp_1025.mdl"
SCP_1025_CONFIG.Models.Hamburger = "models/food/burger.mdl"
SCP_1025_CONFIG.Models.Coke = "models/props_junk/PopCan01a.mdl"
SCP_1025_CONFIG.Models.Donut = "models/scp_1025/donut/donut.mdl"
SCP_1025_CONFIG.Models.Insulin = "models/scp_1025/insulin/insulin.mdl"
SCP_1025_CONFIG.Models.GlycemiaReader = "models/scp_1025/insulin_reader/insulin_reader.mdl"

--Sound Path
SCP_1025_CONFIG.Sounds = {}
SCP_1025_CONFIG.Sounds.OpenBook = "scp_1025/book/open_book.mp3"
SCP_1025_CONFIG.Sounds.CloseBook = "scp_1025/book/close_book.mp3"
SCP_1025_CONFIG.Sounds.TurnPage = "scp_1025/book/turn_page.mp3"
SCP_1025_CONFIG.Sounds.TurnIndex = "scp_1025/book/turn_index.mp3"
SCP_1025_CONFIG.Sounds.DiseaseRead = "scp_1025/disease_read.mp3"
SCP_1025_CONFIG.Sounds.GastroenteritisVomiting = "" -- TODO : Ajouter un son de vomissement
SCP_1025_CONFIG.Sounds.Snoring = "" -- TODO : Ajouter un son de ronflement wav loop
SCP_1025_CONFIG.Sounds.Lease = "" -- TODO : Ajouter un son de baillement
SCP_1025_CONFIG.Sounds.Dizzy = "" -- TODO : Ajouter un son de vertige
SCP_1025_CONFIG.Sounds.Eat = "" -- TODO : Ajouter un son de bouffe
SCP_1025_CONFIG.Sounds.Injection = "" -- TODO : Ajouter un son de injection
SCP_1025_CONFIG.Sounds.GlycemiaReader = "" -- TODO : Ajouter un son de bip
SCP_1025_CONFIG.Sounds.Sneezing = {}
SCP_1025_CONFIG.Sounds.Sneezing[1] = "scp_1025/sneezing/sneeze-01.mp3"
SCP_1025_CONFIG.Sounds.Sneezing[2] = "scp_1025/sneezing/sneeze-02.mp3"
SCP_1025_CONFIG.Sounds.Sneezing[3] = "scp_1025/sneezing/sneeze-03.mp3"
SCP_1025_CONFIG.Sounds.Sneezing[4] = "scp_1025/sneezing/sneeze-04.mp3"

-- JSON Path
SCP_1025_CONFIG.Paths = {}
SCP_1025_CONFIG.Paths.FolderData = "scp_1025"
SCP_1025_CONFIG.Paths.DataJson = "scp_1025/custom_disease.json"

-- Settings Disease
SCP_1025_CONFIG.Settings = {}
-- Common Cold Settings
SCP_1025_CONFIG.Settings.MinCommonCold = 80
SCP_1025_CONFIG.Settings.MaxCommonCold = 120
SCP_1025_CONFIG.Settings.CommonColdRepetitions = 10
SCP_1025_CONFIG.Settings.ProbabilityWriter = 20
-- Asthme Settings
SCP_1025_CONFIG.Settings.SprintDuration = 3
SCP_1025_CONFIG.Settings.RecoveryDuration = 5
SCP_1025_CONFIG.Settings.MinRunSpeed = 50
-- Huntington Settings
SCP_1025_CONFIG.Settings.HuntingtonDuration = 2
SCP_1025_CONFIG.Settings.HuntingtonDelay = 60
SCP_1025_CONFIG.Settings.HuntingtonInterval = 10
SCP_1025_CONFIG.Settings.HuntingtonShootDuration = 2
-- Gastroenteritis Settings
SCP_1025_CONFIG.Settings.MinGastroenteritis = 60
SCP_1025_CONFIG.Settings.MaxGastroenteritis = 120
SCP_1025_CONFIG.Settings.RepetitionsGastroenteritis = 6
-- Kleine Levin Settings
SCP_1025_CONFIG.Settings.KleineLevinDurationBlink = 0.2
SCP_1025_CONFIG.Settings.KleineLevinDelay = 60
SCP_1025_CONFIG.Settings.KleineLevinMinInterval = 5
SCP_1025_CONFIG.Settings.KleineLevinMaxInterval = 10
SCP_1025_CONFIG.Settings.KleineLevinRepetition = 5
SCP_1025_CONFIG.Settings.KleineLevinSleepDuration = 15
-- Diabetes Settings
SCP_1025_CONFIG.Settings.NormalGlycemia = 1.2
SCP_1025_CONFIG.Settings.HyperGlycemia = 2
SCP_1025_CONFIG.Settings.HypoGlycemia = 0.6
SCP_1025_CONFIG.Settings.MaxHyperGlycemia = 5
SCP_1025_CONFIG.Settings.MaxHypoGlycemia = 0.2
SCP_1025_CONFIG.Settings.DelayUpdateGlycemia = 10 -- default 10
SCP_1025_CONFIG.Settings.IntervalGlycemia = 0.011 -- default 0.011
SCP_1025_CONFIG.Settings.CoefficientIncreaseGlycemia = 2
SCP_1025_CONFIG.Settings.DelaySymptomGlycemia = 15
SCP_1025_CONFIG.Settings.IntervalSymptomGlycemia = 10
SCP_1025_CONFIG.Settings.ProbabilityVomiting = 8
SCP_1025_CONFIG.Settings.CoefficientSpeedHypo = 0.4
SCP_1025_CONFIG.Settings.CoefficientSpeedHyper = 0.3
SCP_1025_CONFIG.Settings.HamburgerGlycemiaValue = 0.7
SCP_1025_CONFIG.Settings.CokeGlycemiaValue = 1
SCP_1025_CONFIG.Settings.DonutGlycemiaValue = 0.3
SCP_1025_CONFIG.Settings.InsulinGlycemiaValue = -1
SCP_1025_CONFIG.Settings.DelayGlycemiaReader = 1
SCP_1025_CONFIG.Settings.HighHyperGlycemia = 3.5
SCP_1025_CONFIG.Settings.HighHypoGlycemia = 0.4
SCP_1025_CONFIG.Settings.DelayComa = 120

-- Default Diseases
SCP_1025_CONFIG.DiseaseAvailable = {
    common_cold = {
        name = "Common Cold",
        description = "The common cold is a viral infection of your nose and throat (upper respiratory tract). It's usually harmless, although it might not feel that way. Many types of viruses can cause a common cold.",
    },
    schizophrenia = {
        name = "Schizophrenia",
        description = "Schizophrenia is a mental disorder characterized variously by hallucinations (typically, hearing voices), delusions, disorganized thinking and behavior, and flat or inappropriate affect. Symptoms develop gradually and typically begin during young adulthood and are never resolved. There is no objective diagnostic test; diagnosis is based on observed behavior, a psychiatric history that includes the person's reported experiences, and reports of others familiar with the person. For a diagnosis of schizophrenia, the described symptoms need to have been present for at least six months (according to the DSM-5) or one month (according to the ICD-11). Many people with schizophrenia have other mental disorders, especially mood disorders, anxiety disorders, and obsessive–compulsive disorder.",
    },
    gastroenteritis = {
        name = "Gastroenteritis",
        description = 'Gastroenteritis, also known as infectious diarrhea, is an inflammation of the gastrointestinal tract including the stomach and intestine. Symptoms may include diarrhea, vomiting, and abdominal pain. Fever, lack of energy, and dehydration may also occur. This typically lasts less than two weeks. Although it is not related to influenza, in the U.S. and U.K., it is sometimes called the "stomach flu".Gastroenteritis is usually caused by viruses; however, gut bacteria, parasites, and fungi can also cause gastroenteritis. In children, rotavirus is the most common cause of severe disease. In adults, norovirus and Campylobacter are common causes. Eating improperly prepared food, drinking contaminated water or close contact with a person who is infected can spread the disease. Treatment is generally the same with or without a definitive diagnosis, so testing to confirm is usually not needed.'
    },
    myopia = {
        name = "Myopia",
        description = 'Myopia, also known as near-sightedness and short-sightedness, is an eye disease where light from distant objects focuses in front of, instead of on, the retina. As a result, distant objects appear blurry while close objects appear normal. Other symptoms may include headaches and eye strain. Severe myopia is associated with an increased risk of macular degeneration, retinal detachment, cataracts, and glaucoma. Myopia results from the length of the eyeball growing too long or less commonly the lens being too strong. It is a type of refractive error. Diagnosis is by the use of cycloplegics during eye examination.'
    },
    rabies = {
        name = "Rabies",
        description = 'Rabies is a viral disease that causes encephalitis in humans and other mammals. It was historically referred to as hydrophobia ("fear of water") because its victims would panic when offered liquids to drink. Early symptoms can include fever and abnormal sensations at the site of exposure. These symptoms are followed by one or more of the following symptoms: nausea, vomiting, violent movements, uncontrolled excitement, fear of water, an inability to move parts of the body, confusion, and loss of consciousness. Once symptoms appear, the result is virtually always death. The time period between contracting the disease and the start of symptoms is usually one to three months but can vary from less than one week to more than one year. The time depends on the distance the virus must travel along peripheral nerves to reach the central nervous system.',
    },
    huntington = {
        name = "Huntington's disease",
        description = "Huntington's disease (HD), also known as Huntington's chorea, is an incurable neurodegenerative disease that is mostly inherited. The earliest symptoms are often subtle problems with mood or mental/psychiatric abilities. A general lack of coordination and an unsteady gait often follow. It is also a basal ganglia disease causing a hyperkinetic movement disorder known as chorea. As the disease advances, uncoordinated, involuntary body movements of chorea become more apparent. Physical abilities gradually worsen until coordinated movement becomes difficult and the person is unable to talk. Mental abilities generally decline into dementia, depression, apathy, and impulsivity at times. The specific symptoms vary somewhat between people. Symptoms usually begin between 30 and 50 years of age, and can start at any age but are usually seen around the age of 40. The disease may develop earlier in each successive generation. About eight percent of cases start before the age of 20 years, and are known as juvenile HD, which typically present with the slow movement symptoms of Parkinson's disease rather than those of chorea."
    },
    asthma = {
        name = "Asthma",
        description = "Asthma is a long-term inflammatory disease of the airways of the lungs. Its also a risk factor of pneumonia. Also, It is characterized by variable and recurring symptoms, reversible airflow obstruction, and easily triggered bronchospasms. Symptoms include episodes of wheezing, coughing, chest tightness, and shortness of breath. These may occur a few times a day or a few times per week. Depending on the person, asthma symptoms may become worse at night or with exercise. Asthma is thought to be caused by a combination of genetic and environmental factors. Environmental factors include exposure to air pollution and allergens. Other potential triggers include medications such as aspirin and beta blockers. Diagnosis is usually based on the pattern of symptoms, response to therapy over time, and spirometry lung function testing. Asthma is classified according to the frequency of symptoms of forced expiratory volume in one second (FEV1), and peak expiratory flow rate. It may also be classified as atopic or non-atopic, where atopy refers to a predisposition toward developing a type 1 hypersensitivity reaction. There is no known cure for asthma, but it can be controlled. Symptoms can be prevented by avoiding triggers, such as allergens and respiratory irritants, and suppressed with the use of inhaled corticosteroids. Long-acting beta agonists (LABA) or antileukotriene agents may be used in addition to inhaled corticosteroids if asthma symptoms remain uncontrolled. Treatment of rapidly worsening symptoms is usually with an inhaled short-acting beta2 agonist such as salbutamol and corticosteroids taken by mouth. In very severe cases, intravenous corticosteroids, magnesium sulfate, and hospitalization may be required."
    },
    kleine_levin = {
        name = "Kleine–Levin syndrome",
        description = "Kleine–Levin syndrome is a rare neurological disorder characterized by persistent episodic hypersomnia accompanied by cognitive and behavioral changes. These changes may include disinhibition (failure to inhibit actions or words), sometimes manifested through hypersexuality, hyperphagia or emotional lability, and other symptoms, such as derealization. Patients generally experience recurrent episodes of the condition for more than a decade, which may return at a later age. Individual episodes generally last more than a week, sometimes lasting for months. The condition greatly affects the personal, professional, and social lives of those with KLS. The severity of symptoms and the course of the syndrome vary between those with KLS. Patients commonly have about 20 episodes over about a decade. Several months may elapse between episodes. The onset of the condition usually follows a viral infection (72% of patients); several different viruses have been observed to trigger KLS. It is generally only diagnosed after similar conditions have been excluded; MRI, CT scans, lumbar puncture, and toxicology tests are used to rule out other possibilities."
    },
    diabetes = {
        name = "Diabetes Type 1",
        description = "Type 1 diabetes, formerly known as juvenile diabetes, is an autoimmune disease that occurs when pancreatic (beta cells) are destroyed by the body's immune system. In healthy persons, beta cells produce insulin. Insulin is a hormone required by the body to store and convert blood sugar into energy. T1D results in high blood sugar levels in the body prior to treatment. Common symptoms include frequent urination, increased thirst, increased hunger, weight loss, and other complications. Additional symptoms may include blurry vision, tiredness, and slow wound healing (owing to impaired blood flow). While some cases take longer, symptoms usually appear within weeks or a few months. The cause of type 1 diabetes is not completely understood, though there have been recent studies that suggest linkage with HLA-DR3/DR4-DQ8. Further, it is believed to involve a combination of genetic and environmental factors. The underlying mechanism involves an autoimmune destruction of the insulin-producing beta cells in the pancreas. Diabetes is diagnosed by testing the level of sugar or glycated hemoglobin (HbA1C) in the blood. Type 1 diabetes can typically be distinguished from type 2 by testing for the presence of autoantibodies and/or declining levels/absence of C-peptide. There is no known way to prevent type 1 diabetes. Treatment with insulin is required for survival. Insulin therapy is usually given by injection just under the skin but can also be delivered by an insulin pump. A diabetic diet, exercise, and lifestyle modifications are considered cornerstones of management. If left untreated, diabetes can cause many complications. Complications of relatively rapid onset include diabetic ketoacidosis and nonketotic hyperosmolar coma. Long-term complications include heart disease, stroke, kidney failure, foot ulcers, and damage to the eyes. Furthermore, since insulin lowers blood sugar levels, complications may arise from low blood sugar if more insulin is taken than necessary."
    },
    pica = {
        name = "Pica",
        description = 'Pica is the eating of, or craving to eat, things that are not food. It is classified as an eating disorder but can also be the result of an existing mental disorder. The ingested or craved substance may be biological, natural or manmade. The term was drawn directly from the medieval Latin word for magpie, a bird subject to much folklore regarding its opportunistic feeding behaviors. According to the Diagnostic and Statistical Manual of Mental Disorders, 5th Edition (DSM-5), pica as a standalone eating disorder must persist for more than one month at an age when eating such objects is considered developmentally inappropriate, not part of culturally sanctioned practice, and sufficiently severe to warrant clinical attention. Pica may lead to intoxication in children, which can result in an impairment of both physical and mental development. In addition, it can cause surgical emergencies to address intestinal obstructions, as well as more subtle symptoms such as nutritional deficiencies and parasitosis. Pica has been linked to other mental disorders. Stressors such as psychological trauma, maternal deprivation, family issues, parental neglect, pregnancy, and a disorganized family structure are risk factors for pica.'
    },
    writer_block = {
        name = "Writer's block",
        description = "Writer's block is a condition, primarily associated with writing, in which an author <b>LOSES HIS FUCKING MIND</b> to produce new work or experiences a creative slowdown. The condition ranges in difficulty from coming up with <b>IDEAS THAT ARE WORTH IT, WHERE IS IT, I CAN FEEL IT, I'M NOT IN THE RIGHT PLACE</b>. Throughout history, writer's block has been a documented problem. Professionals who have struggled with the affliction include authors such <b> ME, MY CREATIONS HAUNT ME, I CAN'T DO THIS ANYMORE</b> and <b> WRITING IS SUPPOSED TO EXPRESS NEW IDEAS, WHAT'S THE POINT OF ALWAYS WRITING JUST TO READ?</b>. Research concerning this issue was popular in the early 1990s, and it is still a topic of discussion among professionals. Writer's block can manifest when a writer <b>I KNOW, I'LL MAKE SURE EVERYONE REMEMBERS IT. BUT FIRST, I NEED AN ENCYCLOPEDIA</b> or when they fear that their work will be ridiculed or criticized. The condition can be temporary or it can persist for years. The causes of writer's block are varied and can include anxiety, <b>FEAR IS THE MOST PERSISTENT MEMORY. EVEN IF IT FADES WITH TIME, IT'S ALWAYS THERE, HIDDEN, IN THE SHADOWS OF OUR MINDS. SO THEY'LL REMEMBER. I AM MY WORKS, AND THEY ARE ME, FOREVER AND EVER</b>. The condition was first described in 1947 by psychoanalyst Edmund Bergler."
    }
}

-- TODO : A vérifier, dès fois toutes les maladies par defauts sont ajoutées
-- Custom Diseases
SCP_1025_CONFIG.CustomDisease = util.JSONToTable(file.Read(SCP_1025_CONFIG.Paths.DataJson) or "") or {}

-- Merge Diseases
SCP_1025_CONFIG.DiseaseAvailable = table.Merge(SCP_1025_CONFIG.DiseaseAvailable, SCP_1025_CONFIG.CustomDisease)