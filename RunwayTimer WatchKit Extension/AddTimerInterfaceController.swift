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

    @IBOutlet var hourPicker: WKInterfacePicker!
    @IBOutlet var minutePicker: WKInterfacePicker!
    @IBOutlet var secondPicker: WKInterfacePicker!
    @IBOutlet var timerLabel: WKInterfaceLabel!
    @IBOutlet var pauseResumeButton: WKInterfaceButton!
    @IBOutlet var startStopButton: WKInterfaceButton!
    @IBOutlet var saveButton: WKInterfaceButton!
    
    @IBAction func pauseResumeAction() {
    }
    @IBAction func startStopAction() {
    }
    @IBAction func saveAction() {
    }
}
