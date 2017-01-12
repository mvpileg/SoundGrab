//
//  AudioClipTableViewCell.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/10/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit

class AudioClipTableViewCell: UITableViewCell {

    @IBOutlet weak var clipName: UILabel!
    
    func loadCell(clipName: String) {
        self.clipName.text = clipName
    }
}
