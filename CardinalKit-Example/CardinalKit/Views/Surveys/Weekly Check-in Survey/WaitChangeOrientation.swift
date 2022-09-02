//
//  WaitChangeOrientation.swift
//  CardinalKit_Example
//
//  Created by Julian Esteban Ramos Martinez on 1/09/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit

 // / class needed to add an extra step to wait for the view to change orientation correctly
public class WaitChangeOrientation: ORKInstructionStep{

}
public class WaitChangeOrientationViewController: ORKInstructionStepViewController{
    
    override public func viewDidLoad() {
        super.goForward()
    }
    
}
