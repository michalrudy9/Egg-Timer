//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressEgg: UIProgressView!
    
    let eggTimer = ["Soft": 5, "Medium": 7, "Hard": 12]
    var secondPassed = 0
    var totalTime = 60
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimer[hardness]!
        progressEgg.progress = 0.0
        secondPassed = 0
        titleLabel.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondPassed < totalTime {
            secondPassed += 1
            self.progressEgg.progress = Float(secondPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            self.titleLabel.text = "Done!"
            self.playSound(name: "alarm_sound")
        }
    }
    
    func playSound(name soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
