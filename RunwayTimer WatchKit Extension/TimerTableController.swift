//
//  TimerTableController.swift
//  RunwayTimer
//
//  Created by William Peroche on 9/11/15.
//  Copyright © 2015 William Peroche. All rights reserved.
//

import WatchKit

class TimerTableController: NSObject {

    var currentTimer : Time?
    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var timerLabel: WKInterfaceLabel!
    
    override init() {
        super.init()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateDisplay"), userInfo: nil, repeats: true)
    }
    
    func updateDisplay() {
        if let timer = currentTimer {
            timerLabel.setText(timer.remainingTimeString())
        }
    }

}
