//
//  FileModel.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/10/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//


import Foundation

struct File {
    let fileName: String
    let fullyQualifiedPath: String
}

public class FileModel {
    
    private let manager = FileManager.`default`
    private let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    private let path: String
    private var files = [File]()
    
    private init() {
        path = "\(directory)/Clips"
        reloadFiles()
    }
    
    static var instance: FileModel = {
        return FileModel()
    }()
    
    func getFile(atIndex: Int)->File{
        return files[atIndex]
    }
    
    func getCount()->Int{
        return files.count
    }

    func addFile(url: URL, length: Double){
        let trimmedURL = getURLForNewClip()
        
        AudioTrimmer.trimClipBeginning(originalFileURL: url, trimmedFileURL: trimmedURL, seconds: length) { isSuccessful in
            if isSuccessful {
                self.reloadFiles()
                self.sendNewFileNotification()
            } else {
                //ERROR SAVING FILE
            }
        }
    }
    
    private func getURLForNewClip()->URL {
        let fileName = "\(getFileName()).m4a"
        let helper = FileSaveHelper(fileNameWithExtension: fileName, subDirectory: "Clips")
        return helper.getURLToFile()
    }
    
    private func getFileName()->String{
        let dateAndTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:ss"
        return dateFormatter.string(from: dateAndTime)
    }
    
    private func reloadFiles(){
        files = [File]()

        do {
            let fileNames = try manager.contentsOfDirectory(atPath: path)
            
            for fileName in fileNames {
                files.append(File(fileName: fileName, fullyQualifiedPath: "\(path)/\(fileName)"))
            }
        } catch {
            //ERROR LOADING FILES
        }
    }
    
    private func sendNewFileNotification(){
        NotificationCenter.default.post(NotificationTypes.newTabNotification)
    }
  
}

