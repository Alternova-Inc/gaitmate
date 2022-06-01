//
//  CodeSignInStep.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 1/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit
import SwiftUI

public class CodeSignInStep: ORKQuestionStep{
    public override init(identifier:String){
        super.init(identifier: identifier)
        self.answerFormat = ORKAnswerFormat.booleanAnswerFormat()
    }
    
    @available(*, unavailable)
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class CodeSignInStepViewController: ORKQuestionStepViewController {
    public var CodeSignInStep: CodeSignInStep!{
        return step as? CodeSignInStep
    }
    
    public override func viewDidLoad() {
        let color = Color(CKConfig.shared.readColor(query: "Primary Color"))
        view.addSubview(container)
        gradient.colors = [UIColor.white.cgColor, UIColor(color).cgColor]
    }
    
    let gradient = CAGradientLayer()

    lazy var container : UIView = {
        var newView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.maxX, height: self.view.frame.maxY))
        newView.layer.insertSublayer(gradient, at: 0)
        return newView
    }()
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient.frame = container.bounds
    }
}

