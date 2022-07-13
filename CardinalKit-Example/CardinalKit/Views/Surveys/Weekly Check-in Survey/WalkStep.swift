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
        self.stepDuration = 10000
        self.shouldVibrateOnStart = true
        self.shouldPlaySoundOnStart = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class WalkStepViewController: ORKWalkingTaskStepViewController{
    override public func viewDidLoad() {
        let buttonDone = CustomButton(title: "Done", backGroundColor: UIColor(red: 242, green: 177, blue: 55), textColor: .white, borderColor: nil, action: #selector(action), location: CGRect(x: 200, y: 200, width: 350, height: 75))
        self.view.addSubview(buttonDone)
        self.view.backgroundColor = UIColor(red: 110, green: 237, blue: 251)
    }
    
    
    public func CustomButton(
        title:String,
        backGroundColor:UIColor,
        textColor:UIColor,
        borderColor:UIColor?,
        action: Selector,
        location: CGRect
    )->UIButton{
        let button = UIButton(frame: location)
        button.center = view.center
        button.center.y = view.center.y - 200
        button.setTitle(title, for: .normal)
        
        button.setTitleColor(textColor,for: .normal)
        button.addTarget(self,action: action,for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.backgroundColor = backGroundColor
        if let borderColor=borderColor{
            button.layer.borderWidth = 2
            button.layer.borderColor =  borderColor.cgColor
        }
        return button
    }
    
    @objc
    func action(){
        super.goForward()
    }
}
