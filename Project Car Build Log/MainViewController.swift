//
//  ViewController.swift
//  Project Car Build Log
//
//  Created by Nick Abel on 1/13/18.
//  Copyright © 2018 Nick Abel. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainViewController: UIViewController {
    
    @IBOutlet weak var NewProj: UIButton!
    @IBOutlet weak var ContProj: UIButton!
    @IBOutlet weak var Help: UIButton!
    @IBOutlet weak var Version: UILabel!
    @IBOutlet weak var BannerView: GADBannerView!
    let general = General()
    let DefaultFileText = "00.00\n0\n0\n**PARTS**\nfalse\nPart1Name\nPart1Cost\nPart1Date\nfalse\nPart2Name\nPart2Cost\nPart2Date\nfalse\nPart3Name\nPart3Cost\nPart3Date\nfalse\nPart4Name\nPart4Cost\nPart4Date\nfalse\nPart5Name\nPart5Cost\nPart5Date\nfalse\nPart6Name\nPart6Cost\nPart6Date\nfalse\nPart7Name\nPart7Cost\nPart7Date\nfalse\nPart8Name\nPart8Cost\nPart8Date\nfalse\nPart9Name\nPart9Cost\nPart9Date\nfalse\nPart10Name\nPart10Cost\nPart10Date\nfalse\nPart11Name\nPart11Cost\nPart11Date\nfalse\nPart12Name\nPart12Cost\nPart12Date\nfalse\nPart13Name\nPart13Cost\nPart13Date\nfalse\nPart14Name\nPart14Cost\nPart14Date\nfalse\nPart15Name\nPart15Cost\nPart15Date\nfalse\nPart16Name\nPart16Cost\nPart16Date\nfalse\nPart17Name\nPart17Cost\nPart17Date\nfalse\nPart18Name\nPart18Cost\nPart18Date\nfalse\nPart19Name\nPart19Cost\nPart19Date\nfalse\nPart20Name\nPart20Cost\nPart20Date\n**END OF FILE**"

    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.removeConstraints(self.view.constraints)
        setupConstraints()
        createDefaultFile()
        createMainFiles()
        general.startup()
        if general.getPro() {
            BannerView.isHidden = true
        } else {
            BannerView.isHidden = false
            self.BannerView.adUnitID = general.getGADUnitID(storyboard: "Main")
            self.BannerView.rootViewController = self
            BannerView.load(GADRequest())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if general.getPro() {
            BannerView.isHidden = true
        } else {
            BannerView.isHidden = false
            self.BannerView.adUnitID = general.getGADUnitID(storyboard: "Main")
            self.BannerView.rootViewController = self
            BannerView.load(GADRequest())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupConstraints() {
        let centerX = view.center.x
        
        //NewProj.layer.borderWidth = 1
        //ContProj.layer.borderWidth = 1
        //Help.layer.borderWidth = 1
        
        NewProj.titleLabel?.font = UIFont.systemFont(ofSize: general.getAdjustment(height: view.frame.height))
        ContProj.titleLabel?.font = UIFont.systemFont(ofSize: general.getAdjustment(height: view.frame.height))
        Help.titleLabel?.font = UIFont.systemFont(ofSize: general.getAdjustment(height: view.frame.height))
        
        ContProj.center.x = centerX
        ContProj.center.y = view.center.y
        NewProj.center.x = centerX
        NewProj.center.y = ContProj.center.y - (general.getAdjustment(height: view.frame.height) + 30)
        Help.center.x = centerX
        Help.center.y = ContProj.center.y + (general.getAdjustment(height: view.frame.height) + 30)
        if general.getPro() {
            BannerView.isHidden = true
            Version.center.y = view.frame.maxY - 50
        } else {
            BannerView.isHidden = false
            BannerView.center.x = centerX
            BannerView.center.y = view.frame.maxY - 50
            Version.center.y = BannerView.center.y - 35
        }
        Version.center.x = centerX
        Version.text = general.getVersion()
        Version.textAlignment = .center
    }
    
    func createDefaultFile() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        
        if let pathComponent = url.appendingPathComponent("default.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                // default.txt exists
            } else {
                do {
                    // get the documents folder url
                    if let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        // create the destination url for the text file to be saved
                        let fileURL = DocumentDirectory.appendingPathComponent("default.txt")
                        // define the string/text to be saved
                        var text = ""
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        text = DefaultFileText
                        // writing to disk
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        print("saving was successful")
                    }
                } catch {
                    print("error with defaultfile:", error)
                }
            }
        }
        
        
    } // createDefaultFile
    
    func createMainFiles() {
        // Check what files exist
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        // START FILE1
        if let pathComponent = url.appendingPathComponent("file1.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                // file1.txt exists, goes to file2.txt
            } else {
                do {
                // get the documents folder url
                    if let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        // create the destination url for the text file to be saved
                        let fileURL = DocumentDirectory.appendingPathComponent("file1.txt")
                        // define the string/text to be saved
                        var text = ""
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        text = "yes\nProject 1\n" + DefaultFileText
                        // writing to disk
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        print("saving was successful")
                    }
                } catch {
                    print("error with file1:", error)
                }
            }
        }
        // END FILE1
        // START FILE2
        if let pathComponent = url.appendingPathComponent("file2.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath){
                // file2.txt exists, goes to file3.txt
            } else {
                do {
                    // get the documents folder url
                    if let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        // create the destination url for the text file to be saved
                        let fileURL = DocumentDirectory.appendingPathComponent("file2.txt")
                        // define the string/text to be saved
                        var text = ""
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        text = "yes\nProject 2\n" + DefaultFileText
                        // writing to disk
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        print("saving was successful")
                    }
                } catch {
                    print("error with file2:", error)
                }
            }
        }
        // END FILE2
        // START FILE3
        if let pathComponent = url.appendingPathComponent("file3.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath){
                // file3.txt exists, no more files need to be created
            } else {
                do {
                    // get the documents folder url
                    if let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        // create the destination url for the text file to be saved
                        let fileURL = DocumentDirectory.appendingPathComponent("file3.txt")
                        // define the string/text to be saved
                        var text = ""
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        text = "yes\nProject 3\n" + DefaultFileText
                        // writing to disk
                        try text.write(to: fileURL, atomically: false, encoding: .utf8)
                        print("saving was successful")
                    }
                } catch {
                    print("error with file3:", error)
                }
            }
            // END FILE3
        }
    }
}
