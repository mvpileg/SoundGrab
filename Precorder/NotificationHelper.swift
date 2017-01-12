//
//  NotificationTypes.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/10/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import Foundation

class NotificationHelper{
    
    static func sendNotification(withName: Notification.Name){
        NotificationCenter.default.post(name: withName, object: nil)
    }
    
}

extension Notification.Name {
    static let newRecording = Notification.Name(rawValue: "New Recording")
    static let errorCreatingRecorder = Notification.Name(rawValue: "Error Creating Recorder")
    static let errorSavingFile = Notification.Name(rawValue: "Error Saving File")
    static let errorLoadingFiles = Notification.Name(rawValue: "Error Loading Files")
    static let errorSettingUpMicrophone = Notification.Name(rawValue: "Error Setting Up Microphone")
    static let errorPlayingAudio = Notification.Name(rawValue: "Error Playing Audio")
}
