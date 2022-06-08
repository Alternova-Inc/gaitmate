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

public class VideoStep: ORKInstructionStep{
    
}

public class VideoStepViewController: ORKInstructionStepViewController{
    public var VideoStep: VideoStep!{
        return step as? VideoStep
    }
    
    override public func viewDidLoad() {
        
        let instructionLabel = UILabel(frame: CGRect(x: 0, y: 100, width: view.frame.width - 50, height: 50 ))
        instructionLabel.center.x = view.center.x
        instructionLabel.text = "Now it’s time for your gait task. First, watch this brief video which demonstrates the task"
        instructionLabel.textAlignment = NSTextAlignment.center
        instructionLabel.numberOfLines = 3
        self.view.addSubview(instructionLabel)
        
        
//        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: Bundle.main.url(forResource: "Video",     withExtension: "mp4")!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 25, y: 150, width: view.frame.width - 50, height: view.frame.height/2 )
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        
        let doneButton = UIButton(frame: CGRect(x: 0, y: view.frame.maxY-300, width: view.frame.width - 100, height: 50))
        doneButton.center.x = view.center.x
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor( .white, for: .normal)
        doneButton.backgroundColor = .systemBlue
        doneButton.layer.borderWidth = 2
        doneButton.layer.borderColor = Color.black.cgColor
        doneButton.layer.cornerRadius = 10
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        self.view.addSubview(doneButton)
        
        self.view.backgroundColor = .white
    }
        
    @objc
    func doneAction(){
        super.goForward()
    }
    
    
}
