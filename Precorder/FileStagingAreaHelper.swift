//
//  FileStagingAreaHelper.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/12/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import Foundation

class FileStagingAreaHelper {
    
    static func transferRecordingAudioDataToStagingFile(fromURL: URL)->URL?{
        
        let helper = FileSaveHelper(fileNameWithExtension: "Staging.m4a", subDirectory: "Tracks")
        
        do {
            let data = try Data(contentsOf: fromURL)
            try  helper.saveFile(data)
            return helper.getURLToFile()
        }catch {
            return nil
        }
    }
}
