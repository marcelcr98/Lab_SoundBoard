//
//  SounViewController.swift
//  SoundBoard
//
//  Created by mbtec22 on 5/14/20.
//  Copyright © 2020 Tecsup. All rights reserved.
//

import UIKit
import AVFoundation
class SounViewController: UIViewController {
    
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRecorder()
    }
    
    func setupRecorder(){
        do{
            //sesion de audio
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            //Creando una direccion to audio
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).first!
            let pathComponents = [basePath,"audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            print("************************")
            print(audioURL)
            print("************************")
            
            //crear opciones to grabador de audio
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            //crear objeto de grabacion de audio
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError{
            print(error)
        }
        
    }
    

    @IBAction func recordTapped(_ sender: Any) {
        if audioRecorder!.isRecording{
            //stop
            audioRecorder?.stop()
            //cambiar t exto del boton a grabar
            recordButton.setTitle("Record", for: .normal)
        }
        else{
            //empezar a grabar
            audioRecorder?.record()
            //cambiar titulo de boton a dtener
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    
    
    @IBAction func playTapped(_ sender: Any) {
    }
    
    
    @IBAction func addTapped(_ sender: Any) {
    }
    
    

}
