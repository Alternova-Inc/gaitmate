import ResearchKit

/// Defines the content of the onboarding survey,
struct OnboardingSurvey {
    static let onboardingSurvey: ORKNavigableOrderedTask = {
        var steps = [ORKStep]()
        
        // Instruction step
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "GaitMate Baseline Survey"
        instructionStep.text = " • This survey should take around 10 minutes to complete. \n • This survey will help us understand some things about you to help us understand fall risk. \n • If you are unsure about how to answer a question, please give the best answer you can. \n • If you feel uncomfortable, you can skip any question."
        
        steps += [instructionStep]
        
        //Part 2: Demographics:
        let ageSeparator = ORKFormItem.init(sectionTitle: "What is your age in years?")
        let demoAgeFormat = ORKAnswerFormat.integerAnswerFormat(withUnit: "years")
        
        let ageItem = ORKFormItem(identifier: "AGE", text: "Age: ", detailText: "", learnMoreItem: nil, showsProgress: true, answerFormat: demoAgeFormat, tagText: nil, optional: false)
        
        let sexChoices = [
            ORKTextChoice(text: "Male", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Female", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let demoSexFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: sexChoices)
        let sexItem = ORKFormItem(identifier: "sex", text: "What sex were you assigned at birth, on your original birth certificate?", answerFormat: demoSexFormat, optional: false)
        
        let raceChoices = [
            ORKTextChoice(text: "White or Caucasian", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Black or African American", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Hispanic or Latino", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Native Hawaiian or Pacific Islander", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Native American", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Asian", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Multiracial", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Prefer not to Answer", value: 8 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let raceChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: raceChoices)
        let raceItem = ORKFormItem(identifier: "race", text: "What is your race?", answerFormat: raceChoiceAnswerFormat, optional: false)
        
        let ethnicityChoices = [
            ORKTextChoice(text: "Hispanic or Latino", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "NOT Hispanic or Latino", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let ethnicityChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: ethnicityChoices)
        let ethnicityItem = ORKFormItem(identifier: "hisp", text: "Describe your ethnicity", answerFormat: ethnicityChoiceAnswerFormat, optional: false)
        let heightSeparator = ORKFormItem.init(sectionTitle: "How tall are you? ")
        let heightFormat = ORKAnswerFormat.heightAnswerFormat(with: .USC)
        let heightItem = ORKFormItem(identifier: "height", text: "in inches:", answerFormat: heightFormat, optional: false)
        
        let weightChoices = [
            ORKTextChoice(text: "<100", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "100-150", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "151-180", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "181-200", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "201-250", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: ">250", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let weightSeparator = ORKFormItem.init(sectionTitle: "Approximately how much do you weigh? ")
        let weightChoiceAnswerFormat = ORKAnswerFormat.weightAnswerFormat(with: .USC)
        let weightItem = ORKFormItem(identifier: "weight", text: "in pounds:", answerFormat: weightChoiceAnswerFormat, optional: false)

        let demoStep = ORKFormStep(identifier: "demoStep", title: "Demographics", text: "The following questions concern your demographic information")
        demoStep.formItems = [ageSeparator,ageItem,sexItem, heightSeparator,heightItem, weightSeparator,weightItem, raceItem, ethnicityItem]
        demoStep.isOptional = false
        
        steps += [demoStep]
        
        //Part 3: Current living situation
        let maritalStatusChoices = [
            ORKTextChoice(text: "Single, never married", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Married, or in a domestic partnership", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Separated", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Divorced", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Widowed", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let maritalStatusWithFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: maritalStatusChoices)
        let maritalStatusWithItem = ORKFormItem(identifier: "marital", text: "What is your marital status?", answerFormat: maritalStatusWithFormat, optional: false)
        
        let liveWithChoices = [
            ORKTextChoice(text: "By myself", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "With someone else", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "With multiple people", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let liveWithFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: liveWithChoices)
        let liveWithItem = ORKFormItem(identifier: "livew", text: "Who do you currenty live with?", answerFormat: liveWithFormat, optional: false)
        
        let leaveHomeChoices = [
            ORKTextChoice(text: "At least once per day", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "A few times a week", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Once per week", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Less than once per week", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Never", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let leaveHomeWithFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: leaveHomeChoices)
        let leaveHomeWithItem = ORKFormItem(identifier: "leaveh", text: "How often do you leave your home?", answerFormat: leaveHomeWithFormat, optional: false)
        
        let livingSituationStep = ORKFormStep(identifier: "livingSituatiomStep", title: "Current Living Situation", text: "The following questions concern your current living situation")

        livingSituationStep.formItems = [maritalStatusWithItem,liveWithItem, leaveHomeWithItem]
        livingSituationStep.isOptional = false
        steps += [livingSituationStep]
        
        //Part 4: Quality of Life
        let mobilityChoices = [
            ORKTextChoice(text: "I have no problems in walking about", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have slight problems in walking about", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have moderate problems in walking about", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have severe problems in walking about", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am unable to walk about", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let mobilityFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: mobilityChoices)
        let mobilityItem = ORKFormItem(identifier: "eq_mob", text: "How is your mobility?", answerFormat: mobilityFormat, optional: false)
        
        let careChoices = [
            ORKTextChoice(text: "I have no problems washing or dressing myself", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have slight problems washing or dressing myself", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have moderate problems washing or dressing myself", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have severe problems washing or dressing myself", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am unable to wash or dress myself", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let careFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: careChoices)
        let careItem = ORKFormItem(identifier: "eq_sc", text: "How good is your self-care?", answerFormat: careFormat, optional: false)
        
        let activitiesChoices = [
            ORKTextChoice(text: "I have no problems doing my usual activities", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have slight problems doing my usual activities", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have moderate problems doing my usual activities", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have severe problems doing my usual activities", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am unable to do my usual activities", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let activitiesFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: activitiesChoices)
        let activitiesItem = ORKFormItem(identifier: "eq_ua", text: "How able are you to do usual activities (e.g. work, study, housework, family or leisure activities)?", answerFormat: activitiesFormat, optional: false)
        
        let painChoices = [
            ORKTextChoice(text: "I have no pain or discomfort", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have slight pain or discomfort", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have moderate pain or discomfort", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have severe pain or discomfort", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have extreme pain or discomfort", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let painFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: painChoices)
        let painItem = ORKFormItem(identifier: "eq_pain", text: "How much pain / discomfort do you have?", answerFormat: painFormat, optional: false)
        
        let anxietyChoices = [
            ORKTextChoice(text: "I am not anxious or depressed", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am slightly anxious or depressed", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am moderately anxious or depressed", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am severely anxious or depressed", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am extremely anxious or depressed", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let anxietyFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: anxietyChoices)
        let anxietyItem = ORKFormItem(identifier: "eq_anx", text: "How is your mental health?", answerFormat: anxietyFormat, optional: false)
        
        let otherItem = ORKFormItem(sectionTitle: "", detailText: "", learnMoreItem: nil, showsProgress: true)
        let overallFormat = ORKAnswerFormat.integerAnswerFormat(withUnit: " ")
        overallFormat.maximum = 100
        overallFormat.minimum = 0
        overallFormat.placeholder = " 0 - 100"
        
        let overallItemSeparator = ORKFormItem.init(sectionTitle: "How would you rate your current overall health from 0-100, where 0 is the worst health you can imagine, and 100 is the best?")
        var overallItem = ORKFormItem(identifier: "eq_health", text: "0 - 100: ", answerFormat: overallFormat, optional: false)
      
        let qualityStep = ORKFormStep(identifier: "qualityStep", title: "Quality of Life", text: "Under each heading, please tick ONE box that best describes your health TODAY")
        qualityStep.formItems = [overallItemSeparator, overallItem,mobilityItem, careItem, activitiesItem, painItem, anxietyItem ]
        qualityStep.buildInBodyItems = false
        qualityStep.accessibilityNavigationStyle = .separate
        qualityStep.useSurveyMode = true
        qualityStep.isOptional = false
        steps += [qualityStep]
        
        // Page 5: Medications
        let medNumChoices = [
            ORKTextChoice(text: "None", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "One", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Two", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Three", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Four", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Five or more ", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let medNumFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: medNumChoices)
        let medNumItem = ORKFormItem(identifier: "med_n", text: "How many different medications did you take in the past 24 hours:", answerFormat: medNumFormat, optional: false)
        
        let yesNoChoices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let yesNoFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: yesNoChoices)
        let drowsyItem = ORKFormItem(identifier: "med_dizzy", text: "Do any of these medications make you dizzy or drowsy?", answerFormat: yesNoFormat, optional: false)
        
        let medNumStep = ORKFormStep(identifier: "medicationStep", title: "Medications", text: "The following question corresponds your recent medications")
        medNumStep.formItems = [medNumItem, drowsyItem]
        medNumStep.isOptional = false
        steps += [medNumStep]
        
        // Step 6: Alcohol
        let frequencyChoices = [
            ORKTextChoice(text: "Never", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Monthly or less", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "2-4 times a month", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "2-3 times a week", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "4 or more times a week", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let frequencyFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: frequencyChoices)
        let frequencyItem = ORKFormItem(identifier: "auditc_1", text: "How often do you have a drink containing alcohol?", answerFormat: frequencyFormat, optional: false)
        
        let numStandardChoices = [
            ORKTextChoice(text: "1 or 2", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "3 or 4", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "5 or 6", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "7 to 9", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "10 or more", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let numStandardFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: numStandardChoices)
        let numStandardItem = ORKFormItem(identifier: "auditc_2", text: "How many standard drinks containing alcohol do you have on a typical day when you are drinking?", answerFormat: numStandardFormat, optional: false)
        
        let occasionDrinkChoices = [
            ORKTextChoice(text: "Never", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Less than monthly", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Monthly", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Weekly", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Daily or almost daily", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let occasionDrinkFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: occasionDrinkChoices)
        let noccasionDrinkItem = ORKFormItem(identifier: "auditc_3", text: "How often did you have five or more drinks on one occasion in the past year?", answerFormat: occasionDrinkFormat, optional: false)
        
        let alcoholStep = ORKFormStep(identifier: "alcoholStep", title: "Alcohol", text: "The following question corresponds your alcohol consumption")
        alcoholStep.formItems = [frequencyItem, numStandardItem, noccasionDrinkItem]
        alcoholStep.isOptional = false
        steps += [alcoholStep]
        
        
        // Page 7: Environment
        let stepsChoices = [
            ORKTextChoice(text: "No times", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "One time", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Two or three times", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "More than three times", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let stepsFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: stepsChoices)
        
        let stepsQuestion = ORKFormItem(identifier: "steps_1", text: "In a typical day, about how many times do you go down a set of stairs?", answerFormat: stepsFormat, optional: false)
        
        
        let steps2Choices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let steps2Format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: steps2Choices)
        let steps2Item = ORKFormItem(identifier: "steps_2", text: "Is there torn or loose carpet on stairs?", answerFormat: steps2Format, optional: false)
        
        
        let steps3Choices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let steps3Format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: steps3Choices)
        let steps3Item = ORKFormItem(identifier: "steps_3", text: "Is there a light switch at top and bottom of stairs?", answerFormat: steps3Format, optional: false)
        
        let steps4Choices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let steps4Format = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: steps3Choices)
        let steps4Item = ORKFormItem(identifier: "steps_4", text: "Are there handrails on both sides of stairs?", answerFormat: steps4Format, optional: false)
        
        let floorYesNoChoices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let floorsYesNoFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: floorYesNoChoices)
        let floorsItem1 = ORKFormItem(identifier: "floor_1", text: "When you walk through a room, do you have to walk around furniture?", answerFormat: floorsYesNoFormat, optional: false)
        let floorsItem2 = ORKFormItem(identifier: "floor_2", text: "Do you have throw rugs on the floor?", answerFormat: floorsYesNoFormat, optional: false)
        let floorsItem3 = ORKFormItem(identifier: "floor_3", text: "Are there papers, shoes, books, or other objects on the floor where you walk?", answerFormat: floorsYesNoFormat, optional: false)
        let floorsItem4 = ORKFormItem(identifier: "floor_4", text: "Do you have to walk over or around wires or cords (like lamp, telephone, or extension cords?)", answerFormat: floorsYesNoFormat, optional: false)
        let floorsItem5 = ORKFormItem(identifier: "floor_5", text: "Do you have a dog that sometimes walks under you?", answerFormat: floorsYesNoFormat, optional: false)
        
        
        let bedroomYesNoChoices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let bedroomYesNoFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: bedroomYesNoChoices)
        let bedroomItem1 = ORKFormItem(identifier: "bed_1", text: "Do you have a lamp close to the bed that is easy to reach?", answerFormat: bedroomYesNoFormat, optional: false)
        let bedroomItem2 = ORKFormItem(identifier: "bed_2", text: "Is there a clear short path from your bed to the bathroom? ", answerFormat: bedroomYesNoFormat, optional: false)
        
        
        let bathroomYesNoChoices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let bathroomYesNoFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: bathroomYesNoChoices)
        let bathroomItem1 = ORKFormItem(identifier: "bath_1", text: "Do you have hand rails for your toilet?", answerFormat: bathroomYesNoFormat, optional: false)
        let bathroomItem2 = ORKFormItem(identifier: "bath_2", text: "Do you have hand rails for your bath/shower?", answerFormat: bathroomYesNoFormat, optional: false)
        
        let environmentStepWay0 = ORKFormStep(identifier: "environmentStep0", title: "Environment", text: "The following question are about your home environment")
        environmentStepWay0.formItems = [stepsQuestion]
        
        let environmentStepWay1 = ORKFormStep(identifier: "environmentStep1", title: "Environment", text: "The following question are about your home environment")
        environmentStepWay1.formItems = [steps2Item, steps3Item, steps4Item]
        
        let environmentStepWay2 = ORKFormStep(identifier: "environmentStep2", title: "Environment", text: "The following question are about your home environment")
        environmentStepWay2.formItems = [floorsItem1, floorsItem2, floorsItem3,floorsItem4, floorsItem5, bedroomItem1, bedroomItem2, bathroomItem1, bathroomItem2]
        
        environmentStepWay0.isOptional = false
        environmentStepWay1.isOptional = false
        environmentStepWay2.isOptional = false
        steps += [environmentStepWay0, environmentStepWay1, environmentStepWay2]
        

        let fallYesNoChoices = [
            ORKTextChoice(text: "No", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let fallYesNoFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: fallYesNoChoices)
        let fallItem1 = ORKFormItem(identifier: "cdc_f1", text: "I have fallen in the past year", answerFormat: fallYesNoFormat, optional: false)
        let fallItem2 = ORKFormItem(identifier: "cdc_f2", text: "I am worried about falling", answerFormat: fallYesNoFormat, optional: false)
        let fallItem3 = ORKFormItem(identifier: "cdc_f3", text: "Sometimes I feel unsteady when I am walking", answerFormat: fallYesNoFormat, optional: false)
        let fallItem4 = ORKFormItem(identifier: "cdc_f4", text: "I use or have been advised to use a cane or walker to get around safely", answerFormat: fallYesNoFormat, optional: false)
        let fallItem5 = ORKFormItem(identifier: "cdc_f5", text: "I steady myself by holding onto furniture when walking at home", answerFormat: fallYesNoFormat, optional: false)
        let fallItem6 = ORKFormItem(identifier: "cdc_f6", text: "I need to push with my hands to stand up from a chair", answerFormat: fallYesNoFormat, optional: false)
        let fallItem7 = ORKFormItem(identifier: "cdc_f7", text: "I have some trouble stepping up onto a curb", answerFormat: fallYesNoFormat, optional: false)
        let fallItem8 = ORKFormItem(identifier: "cdc_f8", text: "I often have to rush to the toilet", answerFormat: fallYesNoFormat, optional: false)
        let fallItem9 = ORKFormItem(identifier: "cdc_f9", text: "I have lost some feeling in my feet", answerFormat: fallYesNoFormat, optional: false)
        let fallItem10 = ORKFormItem(identifier: "cdc_f10", text: "I take medicine that sometiems makes me feel light-headed or more tired than usual", answerFormat: fallYesNoFormat)
        let fallItem11 = ORKFormItem(identifier: "cdc_f11", text: "I take medicine to help me sleep or improve my mood", answerFormat: fallYesNoFormat, optional: false)
        let fallItem12 = ORKFormItem(identifier: "cdc_f12", text: "I often feel sad or depressed", answerFormat: fallYesNoFormat, optional: false)

        
        let CDCStep = ORKFormStep(identifier: "CDCStep", title: "CDC", text: "The following question regard the CDC Fall Questionairre")
        CDCStep.formItems = [fallItem1, fallItem2, fallItem3, fallItem4, fallItem5, fallItem6, fallItem7, fallItem8, fallItem9, fallItem10, fallItem11, fallItem12]
        CDCStep.isOptional = false
        steps += [CDCStep]
        
        // Page 9: PA Survey
        let timeSpendChoices = [
            ORKTextChoice(text: "No time", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Less than 30 minutes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "30 min - 1 hour", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "1-2 hours", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "more than 2 hours", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let timeSpendFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: timeSpendChoices)
        let timeSpendItem1 = ORKFormItem(identifier: "pa_1", text: "Walking?", answerFormat: timeSpendFormat, optional: false)
        let timeSpendItem2 = ORKFormItem(identifier: "pa_2", text: "Jogging?", answerFormat: timeSpendFormat, optional: false)
        let timeSpendItem3 = ORKFormItem(identifier: "pa_3", text: "Bicycling?", answerFormat: timeSpendFormat, optional: false)
        let timeSpendItem4 = ORKFormItem(identifier: "pa_4", text: "Swimming?", answerFormat: timeSpendFormat, optional: false)
        let timeSpendItem5 = ORKFormItem(identifier: "pa_5", text: "doing Any other exercise that raises your heart rate?", answerFormat: timeSpendFormat, optional: false)
        
        let PASurveyStep = ORKFormStep(identifier: "PASurveyStep", title: "Activity Survey", text: "The following questions regard your physical activity \n In a typical day, approximately how much time do you spend doing each of the following activities: ")
        PASurveyStep.formItems = [timeSpendItem1, timeSpendItem2, timeSpendItem3, timeSpendItem4, timeSpendItem5]
        PASurveyStep.isOptional = false
        steps += [PASurveyStep]
        
        //SUMMARY
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "You have completed the baseline questionnaire for this study."
        summaryStep.text = "Thanks! We will now guide you through the mobility task. Go back to the home page and click “Weekly Check-In” "
        
        steps += [summaryStep]
        
        let navigableTask = ORKNavigableOrderedTask(identifier: "onboardingSurvey", steps: steps)
        
        let resultSelector = ORKResultSelector(resultIdentifier: "steps_1")
        let booleanAnswerType = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 0 as NSCoding & NSCopying & NSObjectProtocol)
        let predicateRule = ORKPredicateStepNavigationRule(resultPredicates: [booleanAnswerType],
                                                           destinationStepIdentifiers: ["environmentStep2"],
                                                           defaultStepIdentifier: "environmentStep1",
                                                           validateArrays: true)
        
        navigableTask.setNavigationRule(predicateRule, forTriggerStepIdentifier: "steps_1")
        
        return navigableTask
    }()
}
