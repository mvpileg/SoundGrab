//
//  PrecorderObserverExtension.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/12/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit

extension PrecorderMainViewController {
    
    func setupObservers(){
        
        NotificationCenter.default.addObserver(forName: .newRecording, object: nil, queue: nil, using: addRowForNewSavedFile)
        
        addErrorObserver(forName: .errorCreatingRecorder)
        addErrorObserver(forName: .errorSavingFile)
        addErrorObserver(forName: .errorLoadingFiles)
        addErrorObserver(forName: .errorSettingUpMicrophone)
        addErrorObserver(forName: .errorPlayingAudio)

    }
    
    private func addErrorObserver(forName: Notification.Name){
        NotificationCenter.default.addObserver(forName: forName, object: nil, queue: nil, using: displayErrorAlert)
    }
    
    private func addRowForNewSavedFile(notification: Notification){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.model.getFileCount()-1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func displayErrorAlert(notification: Notification){
        DispatchQueue.main.async {
            let alertAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            let alert = UIAlertController(title: "Error", message: notification.name.rawValue, preferredStyle: .alert)
            alert.addAction(alertAction)
        }
    }
}
