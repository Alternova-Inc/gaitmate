//
//  InstructionsStep.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 8/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit

public class InstructionsStep: ORKInstructionStep{
    public override init(identifier: String) {
        super.init(identifier: identifier)
        self.title = ""
        self.text = ""
//        self.shouldTintImages = true
//        self.imageContentMode = .center
//        self.image = UIImage(named: "pocket", in: Bundle(for: ORKInstructionStep.self), compatibleWith: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class InstructionsStepViewController: ORKInstructionStepViewController{
    override public func viewDidLoad() {
        self.continueButtonTitle = "Ready"
        super.viewDidLoad()
    }
}

