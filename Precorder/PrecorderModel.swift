//
//  PrecorderModel.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/10/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import Foundation

private let maxSaveTime = 60.0

class PrecorderModel {
    
    private let fileModel = FileModel.instance
    
    private var guidingTrack: AudioTrack
    private var secondaryTrack: AudioTrack
    private var activeTrack: AudioTrack
    
    init(){
        guidingTrack = AudioTrack(title: "Guide.m4a")
        secondaryTrack = AudioTrack(title: "Secondary.m4a")
        activeTrack = guidingTrack
    }
    
    
    //MARK: Audio
    
    //Instead of creating an extremely large audio file and trimming it whenever the user captures the sound, this app uses a 2 audio track recording model, with a staggered start.  This model ensures that we have an audio clip adequate length whenever the user captures the sound, but also can run indefinitely without worrying about space on the phone, as old, unused audio tracks are overwritten

    func resetGuidingTrack(){
        
        func callAfterTime(seconds: Double, delayedFunction: @escaping ()->Void){
            let timeToInvoke = DispatchTime.now() + seconds
            DispatchQueue.main.asyncAfter(deadline: timeToInvoke) {
                delayedFunction()
            }
        }
        
        guidingTrack.resetTrack()
        
        callAfterTime(seconds: maxSaveTime * 2.0) {
            self.resetGuidingTrack()
            self.activeTrack = self.secondaryTrack;
        }
        callAfterTime(seconds: maxSaveTime) {
            self.secondaryTrack.resetTrack()
            self.activeTrack = self.guidingTrack;
        }
    }
    
    
    //MARK: Storage
    
    func saveRecording(secondsToSave: Double){
       
        activeTrack.stop()
    
        let stagingUrlOptional = FileStagingAreaHelper.transferRecordingAudioDataToStagingFile(fromURL: activeTrack.getURL())
        
        activeTrack.reset()
        activeTrack.start()
        
        if let stagingUrl = stagingUrlOptional {
            fileModel.addFile(url: stagingUrl, length: secondsToSave)
        } else {
            NotificationHelper.sendNotification(withName: .errorSavingFile)
        }
    }

    
    func getFileCount()->Int {
        return fileModel.getCount()
    }
    
    func getFile(atIndex: Int)->File {
        return fileModel.getFile(atIndex: atIndex)
    }
}
