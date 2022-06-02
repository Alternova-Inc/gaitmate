import ResearchKit

struct OnboardingSurvey {
    static let onboardingSurvey: ORKOrderedTask = {
        var steps = [ORKStep]()
        
        // Instruction step
        let instructionStep = ORKInstructionStep(identifier: "IntroStep")
        instructionStep.title = "GaitMate Baseline Survey"
        instructionStep.text = "This survey should take around 10 minutes to complete. This survey will help us understand some things about you to help us understand fall risk. If you are unsure about how to answer a question, please give the best answer you can. If you feel uncomfortable, you can skip any question."
        
        steps += [instructionStep]
        
        //Part 2: Demographics:
        let demoAgeFormat = ORKAnswerFormat.scale(withMaximumValue: 120, minimumValue: 65, defaultValue: 80, step: 5, vertical: false, maximumValueDescription: "100+", minimumValueDescription: "65")
        let ageItem = ORKFormItem(identifier: "ageItem", text: "What is your age in years:", answerFormat: demoAgeFormat)
        
        let sexChoices = [
            ORKTextChoice(text: "Male", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Female", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            //ORKTextChoice(text: "Prefer not to Answer", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let demoSexFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: sexChoices)
        let sexItem = ORKFormItem(identifier: "sexItem", text: "What sex were you assigned at birth, on your original birth certificate?", answerFormat: demoSexFormat)
        
        let raceChoices = [
            ORKTextChoice(text: "White or Caucasian", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Black or African American", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Hispanic or Latino", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Native Hawaiian or Pacific Islander", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Native American", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Asian", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Other", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Prefer not to Answer", value: 7 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let raceChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: raceChoices)
        let raceItem = ORKFormItem(identifier: "raceItem", text: "What is your race?", answerFormat: raceChoiceAnswerFormat)
        
        let ethnicityChoices = [
            ORKTextChoice(text: "Hispanic or Latino", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "NOT Hispanic or Latino", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let ethnicityChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: ethnicityChoices)
        let ethnicityItem = ORKFormItem(identifier: "ethnicityItem", text: "Describe your ethnicity", answerFormat: ethnicityChoiceAnswerFormat)
        
        let heightFormat = ORKAnswerFormat.scale(withMaximumValue: 100, minimumValue: 0, defaultValue: 50, step: 10, vertical: false, maximumValueDescription: "100", minimumValueDescription: "0")
        let heightItem = ORKFormItem(identifier: "heightItem", text: "How tall are you? (in inches):", answerFormat: heightFormat)
        
        let weightChoices = [
            ORKTextChoice(text: "<100", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "100-150", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "151-180", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "181-200", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "201-250", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: ">250", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let weightChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: weightChoices)
        let weightItem = ORKFormItem(identifier: "weightItem", text: "Approximately how much do you weigh in pounds?", answerFormat: weightChoiceAnswerFormat)
        
        
        
        let demoStep = ORKFormStep(identifier: "demoStep", title: "Demographics", text: "The following questions concern your demographic information")
        demoStep.formItems = [ageItem, sexItem, raceItem, ethnicityItem, heightItem, weightItem]
        
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
        let maritalStatusWithItem = ORKFormItem(identifier: "maritalStatusWithItem", text: "What is your marital status?", answerFormat: maritalStatusWithFormat)
        
        let liveWithChoices = [
            ORKTextChoice(text: "By myself", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "With someone else", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "With multiple people", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let liveWithFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: liveWithChoices)
        let liveWithItem = ORKFormItem(identifier: "liveWithItem", text: "Who do you currenty live with?", answerFormat: liveWithFormat)
        
        let leaveHomeChoices = [
            ORKTextChoice(text: "At least once per day", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "A few times a week", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Once per week", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Less than once per week", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Never", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let leaveHomeWithFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: leaveHomeChoices)
        let leaveHomeWithItem = ORKFormItem(identifier: "leavehomeWithItem", text: "How often do you leave your home?", answerFormat: leaveHomeWithFormat)
        
        let livingSituationStep = ORKFormStep(identifier: "livingSituatiomStep", title: "Current Living Situation", text: "The following questions concern your current living situation")
        //let livingSituationStep = ORKFormStep(identifier: "livingSituatiomStep", title: "Current Living Situation", text: nil)

        livingSituationStep.formItems = [maritalStatusWithItem,liveWithItem, leaveHomeWithItem]
        
        steps += [livingSituationStep]
        
        //Part 4: Quality of Life
        let mobilityChoices = [
            ORKTextChoice(text: "I have no problems in walking about", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have slight problems in walking about", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have moderate problems in walking about", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have severe problems in walking about", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am unable to walk about", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let mobilityFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: mobilityChoices)
        let mobilityItem = ORKFormItem(identifier: "mobilityItem", text: "How is your mobility?", answerFormat: mobilityFormat)
        
        let careChoices = [
            ORKTextChoice(text: "I have no problems washing or dressing myself", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have slight problems washing or dressing myself", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have moderate problems washing or dressing myself", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have severe problems washing or dressing myself", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am unable to wash or dress myself", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let careFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: careChoices)
        let careItem = ORKFormItem(identifier: "careItem", text: "How good is your self-care?", answerFormat: careFormat)
        
        let activitiesChoices = [
            ORKTextChoice(text: "I have no problems doing my usual activities", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have slight problems doing my usual activities", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have moderate problems doing my usual activities", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have severe problems doing my usual activities", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am unable to do my usual activities", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let activitiesFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: activitiesChoices)
        let activitiesItem = ORKFormItem(identifier: "activitiesItem", text: "How able are you to do usual activities (e.g. work, study, housework, family or leisure activities)?", answerFormat: activitiesFormat)
        
        let painChoices = [
            ORKTextChoice(text: "I have no pain or discomfort", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have slight pain or discomfort", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have moderate pain or discomfort", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have severe pain or discomfort", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have extreme pain or discomfort", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let painFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: painChoices)
        let painItem = ORKFormItem(identifier: "painItem", text: "How much pain / discomfort do you have?", answerFormat: painFormat)
        
        let anxietyChoices = [
            ORKTextChoice(text: "I am not anxious or depressed", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am slightly anxious or depressed", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am moderately anxious or depressed", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am severely anxious or depressed", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am extremely anxious or depressed", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let anxietyFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: anxietyChoices)
        let anxietyItem = ORKFormItem(identifier: "anxietyItem", text: "How is your mental health?", answerFormat: anxietyFormat)
        
        let overallFormat = ORKAnswerFormat.scale(withMaximumValue: 100, minimumValue: 0, defaultValue: 50, step: 50, vertical: false, maximumValueDescription: "100", minimumValueDescription: "0")
        let overallItem = ORKFormItem(identifier: "overallItem", text: "How would you rate your current overall health from 0-100, where 0 is the worst health you can imagine, and 100 is the best?", answerFormat: overallFormat)
        
        let qualityStep = ORKFormStep(identifier: "qualityStep", title: "Quality of Life", text: "Under each heading, please tick ONE box that best describes your health TODAY")
        qualityStep.formItems = [mobilityItem, careItem, activitiesItem, painItem, anxietyItem, overallItem]
        
        steps += [qualityStep]
        
        // GDS Questions
        /*
         let yesNoChoices = [
             ORKTextChoice(text: "Yes", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
             ORKTextChoice(text: "No", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
         ]
         
        let yesNoFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: yesNoChoices)
        let satisfiedItem = ORKFormItem(identifier: "satisfiedItem", text: "Are you satisfied with your life?", answerFormat: yesNoFormat)
        let emptyItem = ORKFormItem(identifier: "emptyItem", text: "Do you feel that your life is empty?", answerFormat: yesNoFormat)
        let afraidItem = ORKFormItem(identifier: "afraidItem", text: "Are you afraid that something bad is going to happen to you?", answerFormat: yesNoFormat)
        let happyItem = ORKFormItem(identifier: "happyItem", text: "Do you feel happy most of the time?", answerFormat: yesNoFormat)
        
        let GDSStep = ORKFormStep(identifier: "GDSStep", title: "GDS-4", text: "The following questions are based on GDS-4")
        GDSStep.formItems = [satisfiedItem, emptyItem, afraidItem, happyItem]
        
        steps += [GDSStep]
         */
        
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
        let medNumItem = ORKFormItem(identifier: "medicationItem", text: "How many different medications did you take in the past 24 hours:", answerFormat: medNumFormat)
        
        let yesNoChoices = [
            ORKTextChoice(text: "Yes", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let yesNoFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: yesNoChoices)
        let drowsyItem = ORKFormItem(identifier: "drowsyItem", text: "Do any of these medications make you drizzy or drowsy?", answerFormat: yesNoFormat)
        let medNumStep = ORKFormStep(identifier: "medicationStep", title: "Medications", text: "The following question corresponds your recent medications")
        medNumStep.formItems = [medNumItem, drowsyItem]
        
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
        let frequencyItem = ORKFormItem(identifier: "frequencyItem", text: "How often do you have a drink containing alcohol?", answerFormat: frequencyFormat)
        
        let numStandardChoices = [
            ORKTextChoice(text: "1 or 2", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "3 or 4", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "5 or 6", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "7 to 9", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "10 or more", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let numStandardFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: numStandardChoices)
        let numStandardItem = ORKFormItem(identifier: "standardItem", text: "How many standard drinks containing alcohol do you have on a typical day when you were drinking?", answerFormat: numStandardFormat)
        
        let occasionDrinkChoices = [
            ORKTextChoice(text: "Never", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Less than monthly", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Monthly", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Weekly", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Daily or almost daily", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let occasionDrinkFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: occasionDrinkChoices)
        let noccasionDrinkItem = ORKFormItem(identifier: "occasionItem", text: "How often did you have five or more drinks on one occasion in the past year?", answerFormat: occasionDrinkFormat)
        
        let alcoholStep = ORKFormStep(identifier: "alcoholStep", title: "Alcohol", text: "The following question corresponds your alcohol consumption")
        alcoholStep.formItems = [frequencyItem, numStandardItem, noccasionDrinkItem]
        
        steps += [alcoholStep]
        
        // Page 7: Environment --------------------------------------------------------------
        let stepsChoices = [
            ORKTextChoice(text: "No times", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "One", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Two or three times", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "More than three times", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let stepsFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: stepsChoices)
        let stepsItem = ORKFormItem(identifier: "stepsItem", text: "In a typical day how about many times do you go down a set of steps?", answerFormat: stepsFormat)
        
        let floorsChoices = [
            ORKTextChoice(text: "When you walk through a room, do you have to walk around furniture?", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Do you have throw rungs on the floor?", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Are there papers, shoes, books, or other objects on the floor where you walk?", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Do you have to walk over or around wires or cords (like lamp, telephone, or extension cords?", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Do you have a dog that sometimes walks under you", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let floorsFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: floorsChoices)
        let floorsItem = ORKFormItem(identifier: "floorsItem", text: "Floors Questions", answerFormat: floorsFormat)
        
        let bedroomChoices = [
            ORKTextChoice(text: "Do you have hand rails for your toilet?", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Do you have hand rails for your bath/shower?", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let bedroomFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: bedroomChoices)
        let bedroomItem = ORKFormItem(identifier: "bedroomItem", text: "Bedroom Questions", answerFormat: bedroomFormat)
        
        let bathroomChoices = [
            ORKTextChoice(text: "Is your tub or shower floor slippery?", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let bathroomFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: bathroomChoices)
        let bathroomItem = ORKFormItem(identifier: "bathroomItem", text: "Bathroom Questions", answerFormat: bedroomFormat)
        
        let environmentStep = ORKFormStep(identifier: "environmentStep", title: "Environment", text: "The following question are about your home environment")
        environmentStep.formItems = [stepsItem, floorsItem, bedroomItem, bathroomItem]
        
        steps += [environmentStep]
        
        // Page 8: CDC
        let CDCChoices = [
            ORKTextChoice(text: "I have fallen in the past year", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I am worried about falling", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Sometimes I feel unsteady when I am walking", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I use or have been advised to use a cane or walker to get around safely", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I need to push with my hands to stand up from a chair", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have some trouble stepping up onto a curb", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I often have to rush to the toilet", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I have lost some feeling in my feet", value: 6 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I take medicine that sometiems makes me feel light-hearted or more tired than usual", value: 7 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I take medicine to help me sleep or improve my mood", value: 8 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "I often feel sad or depressed", value: 9 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let CDCFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: CDCChoices)
        let CDCItem = ORKFormItem(identifier: "CDCItem", text: "CDC Fall Questions", answerFormat: CDCFormat)
        
        let CDCStep = ORKFormStep(identifier: "CDCStep", title: "CDC", text: "The following question regard the CDC Fall Questionairre")
        CDCStep.formItems = [CDCItem]
        
        steps += [CDCStep]
        
        // Page 9: PA Survey
        let timeSpendChoices = [
            ORKTextChoice(text: "No time", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "<30 Minutes", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "30 min - 1 hour", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "1-2 hours", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
        ]
        let timeSpendFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: timeSpendChoices)
        let timeSpendItem = ORKFormItem(identifier: "timeSpendItem", text: "Over the past week, how many times did you leave your house?", answerFormat: timeSpendFormat)
        /*
        let walkItem = ORKFormItem(identifier: "walkItem", text: "Over the past week, how many times did you walk more than a mile?", answerFormat: sevenScaleFormat)
        let physicalItem = ORKFormItem(identifier: "physicalItem", text: "Over the past week, how many times did you do any physical actvity that raised your heart rate?", answerFormat: sevenScaleFormat)
        */
        
        let PASurveyStep = ORKFormStep(identifier: "PASurveyStep", title: "PA Survey", text: "The following questions regard your physical activity")
        PASurveyStep.formItems = [timeSpendItem]
        
        steps += [PASurveyStep]
        
        /*
        let formItem = ORKFormItem(identifier: "FormItem1", text: "MODERATE ACTIVITIES, such as moving a table, pushing a vacuum cleaner, bowling, or playing golf:", answerFormat: textChoiceAnswerFormat)
        let formItem2 = ORKFormItem(identifier: "FormItem2", text: "Climbing SEVERAL flights of stairs:", answerFormat: textChoiceAnswerFormat)
        let formStep = ORKFormStep(identifier: "FormStep", title: "Daily Activities", text: "The following two questions are about activities you might do during a typical day. Does YOUR HEALTH NOW LIMIT YOU in these activities? If so, how much?")
        formStep.formItems = [formItem, formItem2]
        */
        
        
        /*
        let healthScaleAnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 120, minimumValue: 65, defaultValue: 80, step: 1, vertical: false, maximumValueDescription: "Excellent", minimumValueDescription: "Poor")
        let healthScaleQuestionStep = ORKQuestionStep(identifier: "HealthScaleQuestionStep", title: "Question #1", question: "In general, would you say your health is:", answer: healthScaleAnswerFormat)
        
        steps += [healthScaleQuestionStep]
        
        let textChoices = [
            ORKTextChoice(text: "Yes, Limited A lot", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "Yes, Limited A Little", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "No, Not Limited At All", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        let textChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
        let textStep = ORKQuestionStep(identifier: "TextStep", title: "Daily Activities", question: "MODERATE ACTIVITIES, such as moving a table, pushing a vacuum cleaner, bowling, or playing golf:", answer: textChoiceAnswerFormat)
        
        steps += [textStep]
        
        
        let formItem = ORKFormItem(identifier: "FormItem1", text: "MODERATE ACTIVITIES, such as moving a table, pushing a vacuum cleaner, bowling, or playing golf:", answerFormat: textChoiceAnswerFormat)
        let formItem2 = ORKFormItem(identifier: "FormItem2", text: "Climbing SEVERAL flights of stairs:", answerFormat: textChoiceAnswerFormat)
        let formStep = ORKFormStep(identifier: "FormStep", title: "Daily Activities", text: "The following two questions are about activities you might do during a typical day. Does YOUR HEALTH NOW LIMIT YOU in these activities? If so, how much?")
        formStep.formItems = [formItem, formItem2]
        
        steps += [formStep]
        
        let booleanAnswer = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
        let booleanQuestionStep = ORKQuestionStep(identifier: "QuestionStep", title: nil, question: "In the past four weeks, did you feel limited in the kind of work that you can accomplish?", answer: booleanAnswer)
        
        steps += [booleanQuestionStep]
         */
        
        //SUMMARY
        let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
        summaryStep.title = "You have completed the baseline questionnaire for this study."
        summaryStep.text = "Thanks! We will now guide you through the mobility task. Go back to the home page and click “Weekly Check-In” "
        
        steps += [summaryStep]
        
        
        return ORKOrderedTask(identifier: "onboardingSurvey", steps: steps)
    }()
}

