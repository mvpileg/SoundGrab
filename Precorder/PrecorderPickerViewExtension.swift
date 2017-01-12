//
//  PrecorderPickerViewExtension.swift
//  Precorder
//
//  Created by Matthew Pileggi on 1/10/17.
//  Copyright © 2017 Matthew Pileggi. All rights reserved.
//

import UIKit


let pickerOptions = [15, 30, 45, 60]
let defaultPickerValue = 0 //will be 15 since it refers to array above

extension PrecorderMainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerOptions[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.secondsToSave = pickerOptions[row]
    }
    
    
}
