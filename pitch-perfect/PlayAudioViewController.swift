//
//  PlayAudioViewController.swift
//  pitch-perfect
//
//  Created by Ming Hu on 3/13/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {

    @IBOutlet weak var stopPlayAudioButton: UIButton!

    var recordedAudio: RecordedAudio!
    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! audioPlayer = AVAudioPlayer(contentsOfURL: recordedAudio.filePathURL)
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: recordedAudio.filePathURL)
        
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playSound(rate: 0.5, pitch: 1.0)
    }
    
    @IBAction func playFast(sender: UIButton) {
        playSound(rate: 1.5, pitch: 1.0)
    }
    
    @IBAction func playHighPitch(sender: UIButton) {
        playSound(rate: 1.0, pitch: 1000)
    }
    
    @IBAction func playLowPitch(sender: UIButton) {
        playSound(rate: 1.0, pitch: -1000)
    }
    
    func playSound(rate rate: Float, pitch: Float) {
        stopPlayAudioButton.hidden = false
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        changePitchEffect.rate = rate
        audioEngine.attachNode(changePitchEffect)
        
        
        audioEngine.connect(audioPlayerNode, to:changePitchEffect,format:nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }
}
