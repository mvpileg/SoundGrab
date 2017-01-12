//
//  PrecorderTableViewExtension.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/10/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit
import AVFoundation


extension PrecorderMainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fileToPlay = model.getFile(atIndex: indexPath.row)
        let url = URL(fileURLWithPath: fileToPlay.fullyQualifiedPath)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            //ERROR PLAYING AUDIO
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "audio clip") as! AudioClipTableViewCell
        let file = model.getFile(atIndex: indexPath.row)
        
        cell.loadCell(clipName: getDisplayName(forFile: file))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getFileCount()
    }

    func setupObserver(){
        NotificationCenter.default.addObserver(forName: NotificationTypes.newTabNotificationName, object: nil, queue: nil, using: addRowForNewSavedFile)
    }
    
    func addRowForNewSavedFile(notification: Notification){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.model.getFileCount()-1, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func getDisplayName(forFile: File)->String{
        let fileName = forFile.fileName
        let endIndex = fileName.index(fileName.endIndex, offsetBy: -4)
        return fileName.substring(to: endIndex)
    }
    
}
