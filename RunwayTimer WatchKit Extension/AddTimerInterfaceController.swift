//
//  AddTimerInterfaceController.swift
//  RunwayTimer
//
//  Created by William Peroche on 9/11/15.
//  Copyright © 2015 William Peroche. All rights reserved.
//

import WatchKit
import Foundation

class AddTimerInterfaceController: WKInterfaceController {

    @IBOutlet var char1Picker: WKInterfacePicker!
    @IBOutlet var char2Picker: WKInterfacePicker!
    @IBOutlet var char3Picker: WKInterfacePicker!
    @IBOutlet var hourPicker: WKInterfacePicker!
    @IBOutlet var minutePicker: WKInterfacePicker!
    @IBOutlet var secondPicker: WKInterfacePicker!
    @IBOutlet var timerLabel: WKInterfaceLabel!
    @IBOutlet var pauseResumeButton: WKInterfaceButton!
    @IBOutlet var startStopButton: WKInterfaceButton!
    @IBOutlet var saveButton: WKInterfaceButton!
    var timer : Time?
    var localHour = 0
    var localMinute = 0
    var localSeconds = 0
    var char1 = 0
    var char2 = 0
    var char3 = 0
    var alphaNumericArray : [String] = [
        "A", "B", "C", "D", "E",
        "F", "G", "H", "I", "J",
        "K", "L", "M", "N", "O",
        "P", "Q", "R", "S", "T",
        "U", "V", "W", "X", "Y",
        "Z", "0", "1", "2", "3",
        "4", "5", "6", "7", "8",
        "9"]
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var hourItems: [WKPickerItem] = []
        for hr in 0...23 {
            let pickerItem = WKPickerItem()
            pickerItem.caption = "hour"
            pickerItem.title = String(hr)
            hourItems.append(pickerItem)
        }
        hourPicker.setItems(hourItems)
        
        var minItems: [WKPickerItem] = []
        for min in 0...59 {
            let pickerItem = WKPickerItem()
            pickerItem.caption = "minute"
            pickerItem.title = String(min)
            minItems.append(pickerItem)
        }
        minutePicker.setItems(minItems)
        
        var secItems: [WKPickerItem] = []
        for sec in 0...59 {
            let pickerItem = WKPickerItem()
            pickerItem.caption = "seconds"
            pickerItem.title = String(sec)
            secItems.append(pickerItem)
        }
        secondPicker.setItems(secItems)
        
        var charItems: [WKPickerItem] = []
        for charValue in alphaNumericArray {
            let pickerItem = WKPickerItem()
            pickerItem.title = charValue
            charItems.append(pickerItem)
        }
        
        char1Picker.setItems(charItems)
        char2Picker.setItems(charItems)
        char3Picker.setItems(charItems)
        
        if let _ = context {
            if ((context?.isKindOfClass(Time)) != nil) {
                timer = context as? Time
                localHour = (timer?.hour)!
                localMinute = (timer?.minute)!
                localSeconds = (timer?.second)!
                
                let characters = Array(arrayLiteral: timer?.name)
                char1 = alphaNumericArray.indexOf(characters[0]!)!
                char2 = alphaNumericArray.indexOf(characters[1]!)!
                char3 = alphaNumericArray.indexOf(characters[2]!)!
                
                
            }
        }
        
        hourPicker.setSelectedItemIndex(localHour)
        minutePicker.setSelectedItemIndex(localMinute)
        secondPicker.setSelectedItemIndex(localSeconds)
        char1Picker.setSelectedItemIndex(char1)
        char2Picker.setSelectedItemIndex(char2)
        char3Picker.setSelectedItemIndex(char3)

        updateLabel()
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func pauseResumeAction() {
    }
    
    @IBAction func startStopAction() {
        createTimer()
        timer?.start()
        popController()
    }
    
    @IBAction func saveAction() {
        createTimer()
        timer?.save()
        popController()
    }
    
    @IBAction func char1Changed(value: Int) {
        char1 = value
    }
    @IBAction func char2Changed(value: Int) {
        char2 = value
    }
    @IBAction func char3Changed(value: Int) {
        char3 = value
    }
    @IBAction func hourChanged(value: Int) {
        localHour = value
        updateLabel()
    }
    @IBAction func minuteChanged(value: Int) {
        localMinute = value
        updateLabel()
    }
    @IBAction func secondChanged(value: Int) {
        localSeconds = value
        updateLabel()
    }
    
    
    func updateLabel() {
        var timerValue = 0
        timerValue += localSeconds
        timerValue += localMinute * 60
        timerValue += localHour * 60 * 60
        let uHour : Int = timerValue / 3600
        let minLeft : Int = timerValue / 60
        let uMin : Int = minLeft % 60
        let uSec : Int = timerValue % 60
        
        let text = String(format: "%02d", uHour) + ":" + String(format: "%02d", uMin) + ":" + String(format: "%02d", uSec)
        timerLabel.setText(text)

    }
    
    func createTimer() {
        if (timer == nil) {
            timer = Time()
        }
        
        timer?.hour = localHour
        timer?.minute = localMinute
        timer?.second = localSeconds
        timer?.name = alphaNumericArray[char1] + alphaNumericArray[char2] + alphaNumericArray[char3]
    }
}
