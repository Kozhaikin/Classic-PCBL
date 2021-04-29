//
//  Page1ViewController.swift
//  Project Car Build Log
//
//  Created by Nick Abel on 3/20/18.
//  Copyright © 2018 Nick Abel. All rights reserved.
//

import UIKit
import GoogleMobileAds

class Page3ViewController: UIViewController {
    
    @IBOutlet weak var DeleteButton: UIButton!
    @IBOutlet weak var ProjectTitle: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var TotalDistance: UILabel!
    @IBOutlet weak var CostLabel: UILabel!
    @IBOutlet weak var TotalCost: UILabel!
    @IBOutlet weak var PartsLabel: UILabel!
    @IBOutlet weak var TotalParts: UILabel!
    @IBOutlet weak var EditProject: UIButton!
    @IBOutlet weak var OpenProject: UIButton!
    @IBOutlet weak var CreateProject: UIButton!
    @IBOutlet weak var PageControl: UIPageControl!
    @IBOutlet weak var Version: UILabel!
    @IBOutlet weak var Pg3Banner: GADBannerView!
    
    let general = General()
    var file3Contents = [String]()
    var file3Exists = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.removeConstraints(self.view.constraints)
        setupConstraints()
        setup()
        self.title = "Project 3"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        if general.getPro() {
            Pg3Banner.isHidden = true
        } else {
            self.Pg3Banner.adUnitID = general.getGADUnitID(storyboard: "Page3")
            self.Pg3Banner.rootViewController = self
            Pg3Banner.load(GADRequest())
        }
    }
    
    func setupConstraints() {
        let centerX = view.center.x
        ProjectTitle.frame.size.width = view.frame.width
        ProjectTitle.center.x = centerX
        ProjectTitle.center.y = view.frame.minY + 115
        
        CostLabel.center.x = view.frame.minX + 50
        CostLabel.center.y = ProjectTitle.center.y + 125
        TotalCost.center.x = CostLabel.frame.maxX + (TotalCost.frame.width / 2)
        TotalCost.center.y = CostLabel.center.y
        PartsLabel.center.x = view.frame.minX + 50
        PartsLabel.center.y = CostLabel.center.y + 50
        TotalParts.center.x = PartsLabel.frame.maxX + (TotalParts.frame.width / 2)
        TotalParts.center.y = PartsLabel.center.y
        DistanceLabel.center.x = view.frame.minX + 50
        DistanceLabel.center.y = PartsLabel.center.y + 50
        TotalDistance.center.x = DistanceLabel.frame.maxX + (TotalParts.frame.width / 2)
        TotalDistance.center.y = DistanceLabel.center.y
        
        if general.getPro() {
            Version.center.y = view.frame.maxY - 25
        } else {
            Pg3Banner.center.x = centerX
            Pg3Banner.center.y = view.frame.maxY - 50
            Version.center.y = Pg3Banner.center.y - 35
        }
        Version.center.x = centerX
        Version.text = general.getVersion()
        Version.textAlignment = .center
        PageControl.center.x = centerX
        PageControl.center.y = Version.center.y - 35
        OpenProject.center.x = centerX
        OpenProject.center.y = PageControl.center.y - 35
        CreateProject.center.x = centerX
        CreateProject.center.y = PageControl.center.y - 35
        EditProject.center.x = centerX - 120
        EditProject.center.y = OpenProject.center.y
        DeleteButton.center.x = centerX + 120
        DeleteButton.center.y = OpenProject.center.y
    }
    
    func setup() {
        file3Contents = general.readFile(fileName: "file3.txt")
        if (general.getShowDistance() == true) {
            if (general.getDistanceUnit() == "Miles") {
                DistanceLabel.text = "Miles:"
                DistanceLabel.textAlignment = .center
            } else {
                DistanceLabel.text = "Kilometers:"
                DistanceLabel.textAlignment = .center
            }
        } else {
            DistanceLabel.isHidden = true
            TotalDistance.isHidden = true
        }
        if (file3Contents[0] == "no") {
            file3Exists = true
            OpenProject.isHidden = false
            OpenProject.isUserInteractionEnabled = true
            CreateProject.isHidden = true
            CreateProject.isUserInteractionEnabled = false
            ProjectTitle.text = file3Contents[1]
            ProjectTitle.textAlignment = .center
            if file3Contents[4] == "" {
                TotalDistance.text = "0"
            } else {
                TotalDistance.text = file3Contents[4]
            }
            TotalCost.text = general.formatCurrency(amount: file3Contents[2])
            if (file3Contents[3] == "1") {
                TotalParts.text = file3Contents[3] + " Part"
            } else {
                TotalParts.text = file3Contents[3] + " Parts"
            }
        } else {
            file3Exists = false
            OpenProject.isHidden = true
            OpenProject.isUserInteractionEnabled = false
            CreateProject.isHidden = false
            CreateProject.isUserInteractionEnabled = true
            ProjectTitle.text = "Project 3"
            ProjectTitle.textAlignment = .center
            TotalDistance.text = "0"
            TotalCost.text = general.formatCurrency(amount: "0")
            TotalParts.text = "0 Parts"
        }
        CostLabel.textAlignment = .center
        TotalCost.textAlignment = .left
        PartsLabel.textAlignment = .center
        TotalParts.textAlignment = .left
        DistanceLabel.textAlignment = .center
        TotalDistance.textAlignment = .left
    }
    
    @IBAction func DeletePushed(_ sender: Any) {
        let alert = UIAlertController(title: "Delete File", message: "Are you sure you want to delete Project 3?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (alert: UIAlertAction!) -> Void in
            print("trying to delete 3")
            self.ClearFile()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alert: UIAlertAction!) -> Void in
            // do nothing
        }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true, completion:nil)
    }
    
    @IBAction func EditInfo(_ sender: Any) {
        if (file3Exists) {
            let alertController = UIAlertController(title: "Edit Project 3", message: "", preferredStyle: .alert)
            
            //the confirm action taking the inputs
            let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
                
                //getting the input values from user
                let projName = alertController.textFields?[0].text
                var projMiles = alertController.textFields?[1].text
                self.file3Contents[1] = projName!
                self.file3Contents[4] = projMiles!
                self.general.writeToFile(fileName: "file3.txt", text: self.general.arrayToString(inputArray: self.file3Contents))
                self.ProjectTitle.text = projName!
                if (projMiles == "") {
                    projMiles = "0"
                }
                self.TotalDistance.text = projMiles!
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            //edit project name
            alertController.addTextField { (textField) in
                textField.text = self.file3Contents[1]
                textField.placeholder = "Project Name (year, make, model)"
            }
            //edit project mileage
            alertController.addTextField { (textField) in
                textField.text = self.file3Contents[4]
                if (self.general.getDistanceUnit() == "Miles") {
                    textField.placeholder = "Miles"
                } else if (self.general.getDistanceUnit() == "Kilometers") {
                    textField.placeholder = "Kilometers"
                } else {
                    textField.placeholder = "Miles/Kilometers"
                }
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Cannot Edit", message: "Project 3 does not exist", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func ClearFile() {
        let defaultFileArray = general.readFile(fileName: "default.txt")
        let defaultFileText = defaultFileArray.joined(separator: "\n")
        let text = "yes\nProject 3\n" + defaultFileText
        general.writeToFile(fileName: "file3.txt", text: text)
        setup()
    }
}
