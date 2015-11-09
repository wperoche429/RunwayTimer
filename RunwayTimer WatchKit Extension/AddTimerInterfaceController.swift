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
    var scheduledTimer : NSTimer?
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
                
                let characters = [Character](timer!.name.characters)
                char1 = alphaNumericArray.indexOf(String(characters[0]))!
                char2 = alphaNumericArray.indexOf(String(characters[1]))!
                char3 = alphaNumericArray.indexOf(String(characters[2]))!
                
                
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
        updateButton()
        if (scheduledTimer != nil) {
            scheduledTimer?.invalidate()
            scheduledTimer = nil
        }
        
        scheduledTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateLabel"), userInfo: nil, repeats: true)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        if (scheduledTimer != nil) {
            scheduledTimer?.invalidate()
            scheduledTimer = nil
        }
    }
    
    
    @IBAction func pauseResumeAction() {
        if (timer?.timePause != nil) {
            timer?.resume()
        } else {
            timer?.pause()
        }
        updateButton()
    }
    
    @IBAction func startStopAction() {
        createTimer()
        if (timer?.timeStarted != nil) {
            timer?.stop()
        } else {
            timer?.start()
        }
        updateButton()
    }
    
    @IBAction func saveAction() {
        createTimer()
        timer?.save()
        updateButton()
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
        
        var timerText = String(format: "%02d", uHour) + ":" + String(format: "%02d", uMin) + ":" + String(format: "%02d", uSec)
        if let _ = timer {
            if (timer?.timeStarted != nil) {
                timerText = (timer?.remainingTimeString())!
            }
            
        }
        
        timerLabel.setText(timerText)

        

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
    
    func updateButton() {
        if let _ = timer {
            if (timer?.timeStarted != nil) {
                if (timer?.timePause != nil) {
                    pauseResumeButton.setTitle("Resume")
                    startStopButton.setTitle("Stop")
                    saveButton.setTitle("Save")
                    
                } else {
                    pauseResumeButton.setTitle("Pause")
                    startStopButton.setTitle("Stop")
                    saveButton.setTitle("Save")
                    
                }
                pauseResumeButton.setEnabled(true)
                startStopButton.setEnabled(true)
                saveButton.setEnabled(true)
                
                hourPicker.setEnabled(false)
                minutePicker.setEnabled(false)
                secondPicker.setEnabled(false)
                char1Picker.setEnabled(false)
                char2Picker.setEnabled(false)
                char3Picker.setEnabled(false)
                
            } else {
                pauseResumeButton.setTitle("Pause")
                startStopButton.setTitle("Start")
                saveButton.setTitle("Save")
                
                pauseResumeButton.setEnabled(false)
                startStopButton.setEnabled(true)
                saveButton.setEnabled(true)
                hourPicker.setEnabled(true)
                minutePicker.setEnabled(true)
                secondPicker.setEnabled(true)
                char1Picker.setEnabled(true)
                char2Picker.setEnabled(true)
                char3Picker.setEnabled(true)
                char1Picker.focus()
            }
            
            
        } else {
            pauseResumeButton.setTitle("Pause")
            startStopButton.setTitle("Start")
            saveButton.setTitle("Save")
            
            pauseResumeButton.setEnabled(false)
            startStopButton.setEnabled(true)
            saveButton.setEnabled(true)
            
            char1Picker.focus()
            
        }
    }
}
