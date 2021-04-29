//
//  SettingsTableViewController.swift
//  Project Car Build Log
//
//  Created by Nick Abel on 9/11/18.
//  Copyright © 2018 Nicholas Abel. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import StoreKit

class SettingsTableViewController: UITableViewController {
    
    
    // General Settings Group
    @IBOutlet weak var ShowDistanceLabel: UILabel!
    @IBOutlet weak var ShowDistanceSwitch: UISwitch!
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var DistanceController: UISegmentedControl!
    @IBOutlet weak var CurrencyLabel: UILabel!
    @IBOutlet weak var CurrencyControl: UISegmentedControl!
    
    // Contact Group
    @IBOutlet weak var TwitterLogo: UIImageView!
    @IBOutlet weak var TwitterHandle: UILabel!
    @IBOutlet weak var EmailLogo: UILabel!
    @IBOutlet weak var EmailAddress: UILabel!
    @IBOutlet weak var WebsiteLogo: UILabel!
    @IBOutlet weak var WebsiteAddress: UILabel!
    
    // About Group
    @IBOutlet weak var Version: UILabel!
    @IBOutlet weak var DeveloperInfo: UILabel!
    
    let general = General()
    var showDistance = false
    var currency = ""
    var distanceUnit = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
        Version.text = general.getVersion()
        currency = general.getCurrency()
        distanceUnit = general.getDistanceUnit()
        showDistance = general.getShowDistance()
        if (showDistance == false) {
            ShowDistanceSwitch.setOn(false, animated: false)
        } else {
            ShowDistanceSwitch.setOn(true, animated: false)
        }
        if (distanceUnit == "Miles") {
            DistanceController.selectedSegmentIndex = 0
            ShowDistanceLabel.text = "Show Miles"
            ShowDistanceLabel.textAlignment = .left
        } else if (distanceUnit == "Kilometers") {
            ShowDistanceLabel.text = "Show Kilometers"
            ShowDistanceLabel.textAlignment = .left
            DistanceController.selectedSegmentIndex = 1
        }
        if (currency == "USD") {
            CurrencyControl.selectedSegmentIndex = 0
        } else if (currency == "GBP") {
            CurrencyControl.selectedSegmentIndex = 1
        } else if (currency == "EUR") {
            CurrencyControl.selectedSegmentIndex = 2
        } else if (currency == "JPY") {
            CurrencyControl.selectedSegmentIndex = 3
        } else {
            CurrencyControl.selectedSegmentIndex = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        let centerX = view.center.x
        Version.center.x = centerX
        DeveloperInfo.center.x = centerX
    }
    
    @IBAction func ShowDistanceChanged(_ sender: Any) {
        if ShowDistanceSwitch.isOn {
            general.changeShowDistance(show: true)
        } else {
            general.changeShowDistance(show: false)
        }
    }
    
    @IBAction func DistanceUnitChanged(_ sender: Any) {
        if (DistanceController.selectedSegmentIndex == 0) {
            ShowDistanceLabel.text = "Show Miles"
            ShowDistanceLabel.textAlignment = .left
            general.changeDistanceUnit(newUnit: "Miles")
        } else if (DistanceController.selectedSegmentIndex == 1) {
            ShowDistanceLabel.text = "Show Kilometers"
            ShowDistanceLabel.textAlignment = .left
            general.changeDistanceUnit(newUnit: "Kilometers")
        }
    }
    
    @IBAction func CurrencyChanged(_ sender: Any) {
        if (CurrencyControl.selectedSegmentIndex == 0) {
            general.changeCurrency(newCurrency: "USD")
        } else if (CurrencyControl.selectedSegmentIndex == 1) {
            general.changeCurrency(newCurrency: "GBP")
        } else if (CurrencyControl.selectedSegmentIndex == 2) {
            general.changeCurrency(newCurrency: "EUR")
        } else if (CurrencyControl.selectedSegmentIndex == 3) {
            general.changeCurrency(newCurrency: "JPY")
        } else {
            general.changeCurrency(newCurrency: "USD")
        }
    }
    
    @IBAction func TwitterTapped(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "http://www.twitter.com/HardlyStock")! as URL)
    }
    
    @IBAction func EmailTapped(_ sender: Any) {
        let email = "HardlyStock@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
                let emailTitle = "Feedback"
                let messageBody = ""
                let recipents = ["HardlyStock@gmail.com"]
                let mc: MFMailComposeViewController = MFMailComposeViewController()
                mc.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
                mc.setSubject(emailTitle)
                mc.setMessageBody(messageBody, isHTML: false)
                mc.setToRecipients(recipents)
                
                self.present(mc, animated: true, completion: nil)
            }
        }
    }
    
    
    
}
