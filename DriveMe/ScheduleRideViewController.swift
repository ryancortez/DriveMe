//
//  ScheduleRideViewController.swift
//  DriveMe
//
//  Created by Ryan Cortez on 8/4/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

import UIKit

class ScheduleRideViewController: UIViewController {
    
    var notification: UILocalNotification?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constantlyObserveIfTheUserStatedTheyAreReadyForPickup()
    }
    
    // MARK: - Local Notifications
    
    func createNotificationAskingTheUserIfTheyAreReadyForPickup() {
        let date = datePicker.date
        notification = UILocalNotification()
        if (notification != nil) {
            notification!.alertTitle = "Your driver is ready"
            notification!.alertBody = "Are you ready to be picked up?"
            notification!.alertAction = "Respond to Driver"
            notification!.fireDate = date
            notification!.category = "rsvpCategory"
            notification!.userInfo = ["userIsReady":false]
            UIApplication.sharedApplication().scheduleLocalNotification(notification!)
        }
    }
    
    func constantlyObserveIfTheUserStatedTheyAreReadyForPickup() {
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScheduleRideViewController.displayThatDriverIsOnTheWay), name: "userIsReadyForPickupNotification", object: nil)
    }
    
    func displayConfirmationRideWasScheduledSuccessfully() {
        AZNotification.showNotificationWithTitle("Ride was scheduled Successfully!", controller: self, notificationType: .Success)
    }
    
    func displayThatDriverIsOnTheWay() {
        AZNotification.showNotificationWithTitle("Your ride is on the way!", controller: self, notificationType: .Success)
    }

    // MARK: - Actions
    
    @IBAction func scheduleRideButtonPressed(sender: AnyObject) {
        createNotificationAskingTheUserIfTheyAreReadyForPickup()
        displayConfirmationRideWasScheduledSuccessfully()
    }
    @IBAction func datePickerValueChanged(sender: AnyObject) {
    }

}

