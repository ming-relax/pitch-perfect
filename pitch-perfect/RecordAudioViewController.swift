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
        recordStatusLabel.hidden = false
        recordButton.enabled = false
        
        // Start record audio
        // AVAudioSession
        recordingSession = AVAudioSession.sharedInstance()
        try! recordingSession.setActive(true)
        try! recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        // Make up a file name
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "pitch_perfect.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        recordedAudio = RecordedAudio()
        recordedAudio.filePathURL = filePath
    }
    
    @IBAction func stopRecordAudio(sender: UIButton) {
        audioRecorder.stop()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            // Update UI
            recordButton.enabled = true
            recordStatusLabel.hidden = true
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

