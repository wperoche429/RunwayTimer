//
//  TimerTableController.swift
//  RunwayTimer
//
//  Created by William Peroche on 9/11/15.
//  Copyright © 2015 William Peroche. All rights reserved.
//

import WatchKit

class TimerTableController: NSObject, TimeDelegate {

    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var timerLabel: WKInterfaceLabel!
    var time : Time?
//    override init() {
//        super.init()
//        if (scheduleTimer != nil) {
//            scheduleTimer?.invalidate()
//            scheduleTimer = nil
//        }
//        scheduleTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateDisplay"), userInfo: nil, repeats: true)
//    }
//    
//    func stopTimer() {
//        if (scheduleTimer != nil) {
//            scheduleTimer?.invalidate()
//            scheduleTimer = nil
//        }
//    }
//    
//    func updateDisplay() {
//        timerLabel.setText("")
//        nameLabel.setText("")
//        let timer = TimerManager.sharedInstance.retrieveAllTimers()![index]
//        nameLabel.setText(timer.name)
//        timerLabel.setText(timer.remainingTimeString())
//        
//        print(String(index) + ":" + timer.name + "-" + timer.remainingTimeString())
//    }

    func timeUpdate(timeInString: String) {
        timerLabel.setText(timeInString)
    }
}

