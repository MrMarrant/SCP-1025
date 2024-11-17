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

-- Model Path
SCP_1025_CONFIG.Models = {}
SCP_1025_CONFIG.Models.ModelBook = "models/scp_1025/scp_1025.mdl"

-- TODO : Sounds
--Sound Path
SCP_1025_CONFIG.Sounds = {}
SCP_1025_CONFIG.Sounds.OpenBookSound = "scp_1025/open_book.mp3"
SCP_1025_CONFIG.Sounds.CloseBookSound = "scp_1025/close_book.mp3"
SCP_1025_CONFIG.Sounds.Sneezing = {}
SCP_1025_CONFIG.Sounds.Sneezing[1] = ""

-- JSON Path
SCP_1025_CONFIG.Paths = {}
SCP_1025_CONFIG.Paths.FolderData = "scp_1025"
SCP_1025_CONFIG.Paths.DataJson = "scp_1025/custom_disease.json"

-- Settings Disease
SCP_1025_CONFIG.Settings = {}
SCP_1025_CONFIG.Settings.MinCommonCold = 80
SCP_1025_CONFIG.Settings.MaxCommonCold = 120
SCP_1025_CONFIG.Settings.Repetitions = 10

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
    polio = {
        name = "Polio",
        description = "Poliomyelitis, commonly shortened to polio, is an infectious disease caused by the poliovirus. Approximately 75% of cases are asymptomatic; mild symptoms which can occur include sore throat and fever; in a proportion of cases more severe symptoms develop such as headache, neck stiffness, and paresthesia. These symptoms usually pass within one or two weeks. A less common symptom is permanent paralysis, and possible death in extreme cases. Years after recovery, post-polio syndrome may occur, with a slow development of muscle weakness similar to what the person had during the initial infection. Polio occurs naturally only in humans. It is highly infectious, and is spread from person to person either through fecal–oral transmission (e.g. poor hygiene, or by ingestion of food or water contaminated by human feces), or via the oral–oral route. Those who are infected may spread the disease for up to six weeks even if no symptoms are present. The disease may be diagnosed by finding the virus in the feces or detecting antibodies against it in the blood."
    },
    kleine_levin = {
        name = "Kleine–Levin syndrome",
        description = "Kleine–Levin syndrome is a rare neurological disorder characterized by persistent episodic hypersomnia accompanied by cognitive and behavioral changes. These changes may include disinhibition (failure to inhibit actions or words), sometimes manifested through hypersexuality, hyperphagia or emotional lability, and other symptoms, such as derealization. Patients generally experience recurrent episodes of the condition for more than a decade, which may return at a later age. Individual episodes generally last more than a week, sometimes lasting for months. The condition greatly affects the personal, professional, and social lives of those with KLS. The severity of symptoms and the course of the syndrome vary between those with KLS. Patients commonly have about 20 episodes over about a decade. Several months may elapse between episodes. The onset of the condition usually follows a viral infection (72% of patients); several different viruses have been observed to trigger KLS. It is generally only diagnosed after similar conditions have been excluded; MRI, CT scans, lumbar puncture, and toxicology tests are used to rule out other possibilities."
    },
    diabetes = {
        name = "Diabetes Type 2",
        description = "Type 2 diabetes (T2D), formerly known as adult-onset diabetes, is a form of diabetes mellitus that is characterized by high blood sugar, insulin resistance, and relative lack of insulin. Common symptoms include increased thirst, frequent urination, fatigue and unexplained weight loss. Other symptoms include increased hunger, having a sensation of pins and needles, and sores (wounds) that heal slowly. Symptoms often develop slowly. Long-term complications from high blood sugar include heart disease, stroke, diabetic retinopathy, which can result in blindness, kidney failure, and poor blood flow in the lower-limbs, which may lead to amputations. The sudden onset of hyperosmolar hyperglycemic state may occur; however, ketoacidosis is uncommon. Type 2 diabetes primarily occurs as a result of obesity and lack of exercise. Some people are genetically more at risk than others."
    },
    pica = {
        name = "Pica",
        description = 'Pica is the eating of, or craving to eat, things that are not food. It is classified as an eating disorder but can also be the result of an existing mental disorder. The ingested or craved substance may be biological, natural or manmade. The term was drawn directly from the medieval Latin word for magpie, a bird subject to much folklore regarding its opportunistic feeding behaviors. According to the Diagnostic and Statistical Manual of Mental Disorders, 5th Edition (DSM-5), pica as a standalone eating disorder must persist for more than one month at an age when eating such objects is considered developmentally inappropriate, not part of culturally sanctioned practice, and sufficiently severe to warrant clinical attention. Pica may lead to intoxication in children, which can result in an impairment of both physical and mental development. In addition, it can cause surgical emergencies to address intestinal obstructions, as well as more subtle symptoms such as nutritional deficiencies and parasitosis. Pica has been linked to other mental disorders. Stressors such as psychological trauma, maternal deprivation, family issues, parental neglect, pregnancy, and a disorganized family structure are risk factors for pica.'
    }
}

-- Custom Diseases
SCP_1025_CONFIG.CustomDisease = util.JSONToTable(file.Read(SCP_1025_CONFIG.Paths.DataJson) or "") or {}

-- Merge Diseases
SCP_1025_CONFIG.DiseaseAvailable = table.Merge(SCP_1025_CONFIG.DiseaseAvailable, SCP_1025_CONFIG.CustomDisease)