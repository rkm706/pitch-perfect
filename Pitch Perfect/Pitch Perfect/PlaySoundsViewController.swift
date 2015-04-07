//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Rob Mackey (rkm706@gmail.com) on 3/26/15.
//  Copyright (c) 2015 Rob Mackey. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }
    
    @IBAction func PlaySlowAudio(sender: UIButton) {
        // Play audio very slow
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        prepareForPlayback()
        stopAndResetAudioEngine()

    }
    
    @IBAction func PlayFastAudio(sender: UIButton) {
        // Play audio very fast
        audioPlayer.stop()
        audioPlayer.rate = 2.0
        prepareForPlayback()
        stopAndResetAudioEngine()
    }
   
    @IBAction func playChipmunkAudio(sender: UIButton) {
        // Playback audio as Chipmunk
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        // Playback audio as Darth Vader
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        stopAndResetAudioEngine()
            
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
            
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
            
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
            
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
            
        audioPlayerNode.play()
    }
    
    func stopAndResetAudioEngine() {
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func prepareForPlayback() {
        audioPlayer.currentTime = 0.0
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func StopAudio(sender: UIButton) {
        // Stop audio playback
        audioPlayer.stop()
        stopAndResetAudioEngine()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
