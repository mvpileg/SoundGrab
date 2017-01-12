//
//  AudioTrack.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/10/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import AVFoundation

class AudioTrack {
    
    private var fileHelper: FileSaveHelper
    private var recorder: AVAudioRecorder?
    
    private var settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 44100,
        AVNumberOfChannelsKey: 2,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]

    init(title: String){
        fileHelper = FileSaveHelper(fileNameWithExtension: title, subDirectory: "Tracks")
    }
    
    func resetTrack() {
        stop()
        reset()
        start()
    }
    
    func stop(){
        recorder?.stop()
    }
    
    func start(){
        recorder?.record()
    }
    
    func reset() {
        let url = fileHelper.getURLToFile()
        
        do {
            recorder = try AVAudioRecorder(url: url, settings: settings)
        } catch {
            NotificationHelper.sendNotification(withName: .errorCreatingRecorder)
        }
    }
    
    func getURL()->URL{
        return fileHelper.getURLToFile()
    }
}
