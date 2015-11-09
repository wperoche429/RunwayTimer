//
//  InterfaceController.swift
//  RunwayTimer WatchKit Extension
//
//  Created by William Peroche on 9/11/15.
//  Copyright © 2015 William Peroche. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var timerTable: WKInterfaceTable!
    var timers : [Time]?
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        timers = TimerManager.sharedInstance.timers
        timerTable.setNumberOfRows((timers?.count)!, withRowType: "TimerTableController")
        loadTable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }


    @IBAction func addAction() {
        pushControllerWithName("AddTimerInterfaceController",
            context: nil)
    }
    
    func loadTable() {
        if timers?.count == 0 {
            return
        }
        
        for index in 0..<timers!.count {
            let row = timerTable.rowControllerAtIndex(index) as! TimerTableController
            let timer = timers![index]
            row.nameLabel.setText(timer.name)
            row.timerLabel.setText(timer.remainingTimeString())
            
        }
    }
    
}
