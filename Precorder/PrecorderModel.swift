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
        
    func resetGuidingTrack(){
        
        func callAfterTime(seconds: Double, delayedFunction: @escaping ()->Void){
            let timeToInvoke = DispatchTime.now() + seconds
            DispatchQueue.main.asyncAfter(deadline: timeToInvoke) {
                delayedFunction()
            }
        }
        
        guidingTrack.resetTrack()
        callAfterTime(seconds: maxSaveTime * 2.0) {
            self.resetGuidingTrack(); self.activeTrack = self.secondaryTrack; print("Secondary Active")
        }
        callAfterTime(seconds: maxSaveTime) {
            self.secondaryTrack.resetTrack(); self.activeTrack = self.guidingTrack; print("Guiding active")
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
            //error saving file
        }
    }

    
    func getFileCount()->Int {
        return fileModel.getCount()
    }
    
    func getFile(atIndex: Int)->File {
        return fileModel.getFile(atIndex: atIndex)
    }
}
