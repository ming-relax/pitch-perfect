//
//  ViewController.swift
//  pitch-perfect
//
//  Created by Ming Hu on 3/12/16.
//  Copyright © 2016 Ming Hu. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var recordStatusLabel: UILabel!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        // Update UI
        stopButton.hidden = false
//        recordStatusLabel.hidden = false
        recordStatusLabel.text = "Recording"
        recordButton.enabled = false
        
        // Start record audio
        // AVAudioSession
        recordingSession = AVAudioSession.sharedInstance()
        try! recordingSession.setActive(true)
        try! recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        recordedAudio = RecordedAudio(fileName: "pitch_perfect.wav")
        
        try! audioRecorder = AVAudioRecorder(URL: recordedAudio.filePathURL, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @IBAction func stopRecordAudio(sender: UIButton) {
        audioRecorder.stop()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            // Update UI
            recordButton.enabled = true
//            recordStatusLabel.hidden = true
            recordStatusLabel.text = "Type to Record"
            stopButton.hidden = true
            
            performSegueWithIdentifier("stopRecordAudio", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecordAudio" {
            let playAudioVC: PlayAudioViewController = segue.destinationViewController as! PlayAudioViewController
            playAudioVC.recordedAudio = recordedAudio
        }
    }
}

