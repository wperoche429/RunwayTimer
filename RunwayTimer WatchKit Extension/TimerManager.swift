//
//  TimerManager.swift
//  RunwayTimer
//
//  Created by William Peroche on 9/11/15.
//  Copyright © 2015 William Peroche. All rights reserved.
//

import Foundation
import ClockKit

class TimerManager {
    static let sharedInstance = TimerManager()
    private var timers : [Time]?
    
    init () {
        self.timers = []
        if let timerArray = NSUserDefaults.standardUserDefaults().objectForKey("saveTimers") as? [NSData] {
            for data in timerArray {
                self.timers?.append(NSKeyedUnarchiver.unarchiveObjectWithData(data) as! Time)
            }
        }
    }
    
    func addTimer(time : Time) {
        if (timers == nil) {
            timers = []
        }
        
        var index = 0
        for localTime in timers! {
            if localTime.id == time.id {
                self.timers?.insert(time, atIndex: index)
                self.timers?.removeAtIndex(index + 1)
                updateStorage()
                return
            }
            index++
        }
        
        timers?.append(time)
        updateStorage()
    }
    
    func deleteTimer(time : Time) {
        if (timers == nil) {
            return
        }
        
        var index = 0
        for localTime in timers! {
            if localTime.id == time.id {
                self.timers?.removeAtIndex(index)
                break
            }
            index++
        }
        updateStorage()
        
    }
    
    func retrieveAllTimers() -> [Time]? {
        var sortedTimers : [Time] = []
        var timerStarted : [Time] = []
        for timer in timers! {
            if (timer.timeStarted == nil) {
                sortedTimers.append(timer)
            } else  {
                timerStarted.append(timer)
            }
        }
        
        let sortedTimerStarted = timerStarted.sort({ $0.timeStarted!.compare($1.timeStarted!) == NSComparisonResult.OrderedAscending })
        
        for sortedTimer in sortedTimerStarted.reverse() {
            sortedTimers.insert(sortedTimer, atIndex: 0)
        }
        
        return sortedTimers
        
    }
    
    func checkFinishingTimer() -> Time?{
        var runningTimer : [Time] = []
        for timer in timers! {
            if (timer.timeStarted != nil && timer.timePause == nil) {
                runningTimer.append(timer)
            }
        }
        
        if (runningTimer.count == 0) {
            return nil
        }
        
        let sortedTimer = runningTimer.sort({ $0.remainingTotalTime < $1.remainingTotalTime })
        let finishingTimer = sortedTimer[0]
        return finishingTimer
    }
    
    
    private func updateStorage() {
        var timerArray : [NSData] = []
        for timer in timers! {
            timerArray.append(NSKeyedArchiver.archivedDataWithRootObject(timer))
        }
        
        NSUserDefaults.standardUserDefaults().setObject(timerArray, forKey: "saveTimers")
    }
    
    class func reloadComplications() {
        if let complications: [CLKComplication] = CLKComplicationServer.sharedInstance().activeComplications {
            if complications.count > 0 {
                for complication in complications {
                    CLKComplicationServer.sharedInstance().reloadTimelineForComplication(complication)
                    NSLog("Reloading complication \(complication.description)...")
                }
                
            }
        }
    }
    
}