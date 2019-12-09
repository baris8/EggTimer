//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var alarmSound: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 1.0
        let hardness = sender.currentTitle!
        let chosenTime = eggTimes[hardness]!
        timerStart(seconds: chosenTime)
    }
    
    func timerStart(seconds: Int){
        timer.invalidate()
        
        var timeLeft = seconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            if (timeLeft > 0){
                print("\(timeLeft) Seconds")
                let percent = Float(timeLeft) / Float(seconds)
                self.progressBar.progress = percent
                timeLeft -= 1
            } else {
                timer.invalidate()
                self.titleLabel.text = "Done"
                self.playSound()
            }
        }
    }
    func playSound(){
        let path = Bundle.main.path(forResource: "alarm_sound.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            alarmSound = try AVAudioPlayer(contentsOf: url)
            alarmSound?.play()
        }catch{
            print("File couldn't be found!")
        }
    }
    
}
