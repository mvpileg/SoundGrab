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
  
    fileprivate enum FileErrors: Error {
        case fileNotSaved
    }
    
    fileprivate let directory: FileManager.SearchPathDirectory!
    fileprivate let directoryPath: String!
    fileprivate let fileManager = FileManager.default
    fileprivate let fileName: String!
    fileprivate let filePath: String!
    fileprivate let fullyQualifiedPath: String!
    fileprivate let subDirectory: String!
    
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
    
    func getData() -> Data {
        return (try! Data(contentsOf: URL(fileURLWithPath: fullyQualifiedPath)))
    }
    
    func getURLToFile() -> URL {
        return URL(fileURLWithPath: fullyQualifiedPath)
    }
    
    fileprivate func createDirectory() {
        if !directoryExists {
            do {
                try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: false, attributes: nil)
            } catch {}
        }
    }
}
