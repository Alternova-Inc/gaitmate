//
//  WalkStep.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 8/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit

public class WalkStep: ORKWalkingTaskStep{
    public override init(identifier: String) {
        super.init(identifier: identifier)
        
        var recordConfiguration:[ORKRecorderConfiguration] = []
        recordConfiguration.append(ORKPedometerRecorderConfiguration.init(identifier: "PedometerConfig"))
        recordConfiguration.append(ORKAccelerometerRecorderConfiguration.init(identifier: "AcelerometerConfig", frequency: 100))
        recordConfiguration.append(ORKDeviceMotionRecorderConfiguration.init(identifier: "DevicemotionConfig", frequency: 100))
        
        self.numberOfStepsPerLeg = 10
        self.title = "Gait and Balance"
        self.text = "Walk up to 10 feet in a straight line.\nWalk back to your chair. \nSit down. \nClick the STOP Button"
        self.recorderConfigurations = recordConfiguration
        self.shouldContinueOnFinish = true
        self.isOptional = true
        self.shouldStartTimerAutomatically = true
        self.stepDuration = 15
        self.shouldVibrateOnStart = true
        self.shouldPlaySoundOnStart = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class WalkStepViewController: ORKWalkingTaskStepViewController{
    override public func viewDidLoad() {
        self.skipButtonTitle = "Stop"
        super.viewDidLoad()
    }
}
