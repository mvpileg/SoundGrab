//
//  FileSaveHelper.swift
//  PhoneFit 3-4
//
//  Created by Matthew Pileggi on 7/30/16.
//  Copyright © 2016 Matthew Pileggi. All rights reserved.
//

import CoreData
import UIKit

class FileSaveHelper {
  
    private enum FileErrors: Error {
        case fileNotSaved
    }
    
    private let directory: FileManager.SearchPathDirectory!
    private let directoryPath: String!
    private let fileManager = FileManager.default
    private let fileName: String!
    private let filePath: String!
    private let fullyQualifiedPath: String!
    private let subDirectory: String!
    
    private var fileExists: Bool {
        get {
            return fileManager.fileExists(atPath: fullyQualifiedPath)
        }
    }
    
    private var directoryExists: Bool {
        get {
            var isDir = ObjCBool(true)
            return fileManager.fileExists(atPath: filePath, isDirectory: &isDir)
        }
    }
    
    init(fileNameWithExtension: String, subDirectory: String, directory: FileManager.SearchPathDirectory) {
        self.fileName = fileNameWithExtension
        self.subDirectory = "/\(subDirectory)"
        self.directory = directory
        self.directoryPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)[0]
        self.filePath = directoryPath + self.subDirectory
        self.fullyQualifiedPath = "\(filePath!)/\(self.fileName!)"
        
        createDirectory()
    }
    
    convenience init(fileNameWithExtension: String, subDirectory: String){
        self.init(fileNameWithExtension: fileNameWithExtension, subDirectory: subDirectory, directory: .documentDirectory)
     }
 
    func saveFile(_ data: Data) throws {
        if !fileManager.createFile(atPath: fullyQualifiedPath, contents: data, attributes: nil) {
            throw FileErrors.fileNotSaved
        }
    }
    
    func getURLToFile() -> URL {
        return URL(fileURLWithPath: fullyQualifiedPath)
    }
    
    private func createDirectory() {
        if !directoryExists {
            do {
                try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: false, attributes: nil)
            } catch {}
        }
    }
}
