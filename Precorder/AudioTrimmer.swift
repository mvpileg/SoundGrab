//
//  AudioTrimmer.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/11/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import AVFoundation

class AudioTrimmer {
    
    static func trimClipBeginning(originalFileURL: URL, trimmedFileURL: URL, seconds: Double, callback: @escaping (Bool)->Void) {
        
        guard let exporter = getExporter(inputURL: originalFileURL, outputURL: trimmedFileURL),
              let timeRange = getTimeRangeForAudioAt(url: originalFileURL, forSeconds: seconds) else {
                callback(false)
                return
        }
        
        exporter.timeRange = timeRange

        exporter.exportAsynchronously {
            switch exporter.status {
            case .failed:
                callback(false)
            case .cancelled:
                callback(false)
            default:
                callback(true)
            }
        }
    }
    
    private static func getExporter(inputURL: URL, outputURL: URL)->AVAssetExportSession?{

        let asset = AVURLAsset(url: inputURL)
        let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)
        
        exporter?.outputFileType = AVFileTypeAppleM4A
        let url = URL(fileURLWithPath: outputURL.path)
        exporter?.outputURL = url
        
        return exporter
    }

    private static func getTimeRangeForAudioAt(url: URL, forSeconds: Double) -> CMTimeRange?{
        
        guard let originalDuration = getDuration(url: url) else {  return nil }
        
        var startTimeInSeconds = originalDuration - forSeconds
       
        if startTimeInSeconds < 0.0 {
            startTimeInSeconds = 0.0
        }

        let startTime = CMTimeMake(Int64(startTimeInSeconds), 1)
        let endTime = CMTimeMake(Int64(originalDuration), 1)
        print(startTime)
        print(endTime)
        return CMTimeRangeFromTimeToTime(startTime, endTime)
    }
    
    private static func getDuration(url: URL)->Double? {
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            return player.duration
        } catch {
            return nil
        }
    }
}

