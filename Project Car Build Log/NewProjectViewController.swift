//
//  NewProjectViewController.swift
//  Project Car Build Log
//
//  Created by Nick Abel on 2/9/18.
//  Copyright © 2018 Nick Abel. All rights reserved.
//

import UIKit
import GoogleMobileAds

class NewProjectViewController: UIViewController {
    
    @IBOutlet weak var InputYear: UITextField!
    @IBOutlet weak var InputMake: UITextField!
    @IBOutlet weak var InputModel: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var Version: UILabel!
    @IBOutlet weak var NewProjectBanner: GADBannerView!
    let general = General()
    var fileCreated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.removeConstraints(self.view.constraints)
        InputYear.keyboardType = UIKeyboardType.numberPad
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (!general.getPro()) {
            self.NewProjectBanner.adUnitID = general.getGADUnitID(storyboard: "New Project")
            self.NewProjectBanner.rootViewController = self
            NewProjectBanner.load(GADRequest())
        } else {
            NewProjectBanner.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        let centerX = view.center.x
        SubmitButton.titleLabel?.font = UIFont.systemFont(ofSize: general.getAdjustment(height: view.frame.height))
        InputMake.center.x = centerX
        InputMake.center.y = view.center.y - 15
        InputYear.center.x = centerX
        InputYear.center.y = InputMake.center.y - (general.getAdjustment(height: view.frame.height) + 60)
        InputModel.center.x = centerX
        InputModel.center.y = InputMake.center.y + (general.getAdjustment(height: view.frame.height) + 60)
        
        if (general.getPro()) {
            Version.center.y = view.frame.maxY - 25
        } else {
            NewProjectBanner.center.x = view.center.x
            NewProjectBanner.center.y = view.frame.maxY - 50
            Version.center.y = NewProjectBanner.center.y - 35
        }
        Version.center.x = view.center.x
        Version.text = general.getVersion()
        Version.textAlignment = .center
        SubmitButton.center.x = centerX
        SubmitButton.center.y = Version.center.y - 60 - general.getAdjustment(height: view.frame.height)
    }

    
    @IBAction func SubmitButtonClicked() {
        
        //Check if at least one text box is filled
        if (InputYear.text != "" || InputMake.text != "" || InputModel.text != "") {
            createFile(year: InputYear.text!, make: InputMake.text!, model: InputModel.text!)
            
            if (!fileCreated) {
                // Popup stating no more files can be created
                let alert = UIAlertController(title: "Error", message: "Cannot create any more projects", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            // Open Main.storyboard
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
            self.present(viewController, animated: false, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please fill in at least one field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in            }))
            self.present(alert, animated: true, completion: nil)
        }
 
    }
    
    func createFile (year: String, make: String, model: String) {
        var File1JustCreated = false, File2JustCreated = false
        var defaultText = ""
        let ProjectName = year + " " + make + " " + model
        
        // Check what files exist
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        do {
            if let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let defaultURL = DocumentDirectory.appendingPathComponent("default.txt")
                // reading from disk
                defaultText = try String(contentsOf: defaultURL)
            }
        } catch {
            print(error)
        }
        // START FILE1
        if let pathComponent = url.appendingPathComponent("file1.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) && !CanIOverWrite(FileNum: 1) {
                print("The file 'file1.txt' exists. Trying 'file2.txt'.")
            } else {
                File1JustCreated = true
                fileCreated = true
                let text = "no\n" + ProjectName + "\n" + defaultText
                general.writeToFile(fileName: "file1.txt", text: text)
            }
        }
        // END FILE1
        // START FILE2
        if let pathComponent = url.appendingPathComponent("file2.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) && !CanIOverWrite(FileNum: 2){
                print("The file 'file2.txt' exists. Trying 'file3.txt'.")
            } else {
                var text = ""
                File2JustCreated = true
                if (File1JustCreated) {
                    text = "yes\nProject 2\n" + defaultText
                } else {
                    fileCreated = true
                    text = "no\n" + ProjectName + "\n" + defaultText
                }
                general.writeToFile(fileName: "file2.txt", text: text)
            }
        }
        // END FILE2
        // START FILE3
        if let pathComponent = url.appendingPathComponent("file3.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) && !CanIOverWrite(FileNum: 3) && !File2JustCreated{
                print("The file 'file3.txt' exists. No more!")

            } else {
                var text = ""
                if (!File1JustCreated) {
                    if (!File2JustCreated) {
                        fileCreated = true
                        text = "no\n" + ProjectName + "\n" + defaultText
                    } else {
                        text = "yes\nProject 3\n" + defaultText
                    }
                } else {
                    text = "yes\nProject 3\n" + defaultText
                }
                general.writeToFile(fileName: "file3.txt", text: text)
            }
        }
        // END FILE3
}
    
    func CanIOverWrite(FileNum: Int) -> Bool {
        var file1Contents = [String]()
        var file2Contents = [String]()
        var file3Contents = [String]()
        if FileNum == 1 {
            file1Contents = general.readFile(fileName: "file1.txt")
            if file1Contents[0] == "yes" {
                return true
            } else {
                return false
            }
        } else if FileNum == 2 {
            file2Contents = general.readFile(fileName: "file2.txt")
            if file2Contents[0] == "yes" {
                return true
            } else {
                return false
            }
        } else if FileNum == 3 {
            file3Contents = general.readFile(fileName: "file3.txt")
            if file3Contents[0] == "yes" {
                return true
            } else {
                return false
            }
        }
        return false
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
