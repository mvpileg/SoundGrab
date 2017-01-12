//
//  ViewController.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/3/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit
import AVFoundation

class PrecorderMainViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?

    var secondsToSave: Int!
    var model: PrecorderModel!

    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var secondsPicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func precord(){
        model.saveRecording(secondsToSave: Double(secondsToSave))
    }

    //MARK: Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model = PrecorderModel()
        
        setupAudio()
        setupSecondsPicker()
        setupTableViewController()
    }
    
    private func setupSecondsPicker(){
        secondsPicker.delegate = self
        secondsPicker.dataSource = self
        secondsPicker.selectRow(defaultPickerValue, inComponent: 0, animated: false)
        secondsToSave = pickerOptions[defaultPickerValue]
    }
    
    private func setupTableViewController(){
        tableView.delegate = self
        tableView.dataSource = self
        setupObserver()
    }
    
    private func setupAudio(){
        AVAudioSession.sharedInstance().requestRecordPermission({ allowed in
            if allowed {
                self.setupSession()
                self.model.resetGuidingTrack()
            }
        })
    }
    
    private func setupSession(){
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: [.defaultToSpeaker, .mixWithOthers])
            try session.setActive(true)
        }catch {
            //ERROR Setting up microphone
        }
    }
}


