//
//  VideoQuestionStep.swift
//  CardinalKit_Example
//
//  Created by Esteban Ramos on 7/06/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import ResearchKit
import SwiftUI
import AVFoundation
import AVKit

public class VideoStep: ORKInstructionStep{
    
}

public class VideoStepViewController: ORKInstructionStepViewController{
    public var VideoStep: VideoStep!{
        return step as? VideoStep
    }
    
    override public func viewDidLoad() {
        NotificationCenter.default.post(name: NSNotification.Name(Constants.putViewOnLandScape), object: true)
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
        let instructionLabel = UILabel()
        instructionLabel.text = "Now it’s time for your gait task. First, watch this brief video which demonstrates the task"
        instructionLabel.textAlignment = NSTextAlignment.center
        instructionLabel.numberOfLines = 3
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(instructionLabel)
        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant:10),
            instructionLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant:30),
            instructionLabel.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant:-30),
        ])
        
        let doneButton = UIButton()
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor( .white, for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.layer.borderWidth = 2
        doneButton.layer.borderColor = Color.black.cgColor
        doneButton.layer.cornerRadius = 10
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 150),
            doneButton.heightAnchor.constraint(equalToConstant: 50),
            doneButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant:-15),
        ])
        
        let player = AVPlayer(url: Bundle.main.url(forResource: "Video",     withExtension: "mp4")!)
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.addChild(playerController)
        self.view.addSubview(playerController.view)
        player.play()
        playerController.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            playerController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerController.view.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant:10),
            playerController.view.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant:15),
            playerController.view.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant:-15),
            playerController.view.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant:-20),
        ])
        
        self.view.backgroundColor = .white
        
    }
    
    
    private let swiftBetaButton1: UIButton = {
            var configuration = UIButton.Configuration.filled() // 1
            configuration.title = "Suscríbete a SwiftBeta" // 2
            configuration.subtitle = "Apoya el canal" // 3
            configuration.image = UIImage(systemName: "play.circle.fill") // 4
            
            let button = UIButton(type: .system) // 5
            button.translatesAutoresizingMaskIntoConstraints = false // 6
            button.configuration = configuration // 7
            
            return button
        }()
    
    public override var shouldAutorotate: Bool {
        return true
    }

    public override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
         self.view.setNeedsUpdateConstraints()
    }
        
    @objc
    func doneAction(){
        NotificationCenter.default.post(name: NSNotification.Name(Constants.putViewOnPortrait), object: true)
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        super.goForward()
    }
    
}
