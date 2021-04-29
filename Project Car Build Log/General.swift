//
//  General.swift
//  Project Car Build Log
//
//  Created by Nick Abel on 3/8/18.
//  Copyright © 2018 Nick Abel. All rights reserved.
//

import Foundation
import UIKit

// Class includes functions that multiple storyboards utilize
// Reduces amount of total lines of code to sift through
class General {
    var pro = false
    let testing = false
    let version = "Version 1.2"
    var distanceUnit = "Miles"
    var showDistance = false
    var currency = "USD"
    var settings = "USD\nfalse\nMiles\nfalse"
    var settingsInfo = [String]()
    
    func getPro() -> Bool {
        //startup()
        return(pro)
    }
    func getVersion() -> String {
        return(version)
    }
    func getCurrency() -> String {
        startup()
        return(currency)
    }
    func getShowDistance() -> Bool {
        startup()
        return(showDistance)
    }
    func getDistanceUnit() -> String {
        startup()
        return(distanceUnit)
    }
    func getScreenWidth() -> CGFloat {
        return screenWidth
    }
    func getScreenHeight() -> CGFloat {
        return screenHeight
    }
    
    func getGADUnitID(storyboard: String) -> String {
        if (testing == false) {
            if (storyboard == "Main") {
                return("ca-app-pub-7368795129716982/7016035343")
            } else if (storyboard == "New Project") {
                return("ca-app-pub-7368795129716982/7710966079")
            } else if (storyboard == "Help") {
                return("ca-app-pub-7368795129716982/3388577689")
            } else if (storyboard == "Project") {
                return("ca-app-pub-7368795129716982/4680825089")
            } else if (storyboard == "Page1") {
                return("ca-app-pub-7368795129716982/4966625846")
            } else if (storyboard == "Page2") {
                return("ca-app-pub-7368795129716982/1474582329")
            } else if (storyboard == "Page3") {
                return("ca-app-pub-7368795129716982/3198727538")
            } else {
                // returns test id if storyboard not found
                print("ERROR: " + storyboard + " not found")
                return("ca-app-pub-3940256099942544/2934735716")
            }
        } else {
            // Testing
            return("ca-app-pub-3940256099942544/2934735716")
        }
    }
    
    func getAdjustment(height: CGFloat) -> CGFloat {
        // height measured in points, each device size different
        switch height {
        case 896:
            // iPhone Xs Max, iPhone XR
            return(20)
        case 812:
            // iPhone Xs, iPhone X
            return(18)
        case 736:
            // iPhone 8+, iPhone 7+, iPhone 6s+, iPhone 6+
            return(18)
        case 667:
            // iPhone 8, iPhone 7, iPhone 6s, iPhone 6
            return(15)
        case 568:
            // iPhone SE, iPhone 5s, iPhone 5c, iPhone 5
            return(15)
        case 480:
            // iPhone 4s
            return(15)
        default:
            print("Help! Size unknown.", height)
            return(14)
        }
    }
    
    func startup() {
        loadSettings()
        if (settingsInfo.indices.contains(1)) {
            currency = settingsInfo[0]
        } else {
            currency = "USD"
            settingsInfo.insert(currency, at: 0)
        }
        if (settingsInfo.indices.contains(1)) {
            if (settingsInfo[1] == "false") {
                showDistance = false
            } else {
                showDistance = true
            }
        } else {
            showDistance = false
            settingsInfo.insert("false", at: 2)
        }
        if (settingsInfo.indices.contains(2)) {
            distanceUnit = settingsInfo[2]
        } else {
            distanceUnit = "Miles"
            settingsInfo.insert(distanceUnit, at: 2)
        }
        if (settingsInfo.indices.contains(3)) {
            if settingsInfo[3] == "true" {
                //pro = true
            } else {
                //pro = false
            }
        } else {
            //pro = false
            settingsInfo.insert("false", at: 3)
        }
        
        
        //settingsInfo[3] = "true"
        settingsInfo[3] = "false"
        // save to file any added indices
        writeToFile(fileName: "settings.txt", text: arrayToString(inputArray: settingsInfo))
    }
    
    func formatCurrency(amount: String) -> String {
        startup()
        var newAmount = amount
        if (Double(amount) == nil) {
            newAmount = "0"
        }
        if (currency == "USD") {
            newAmount = String(format: "$%.02f", Double(newAmount)!)
        } else if (currency == "GBP") {
            newAmount = String(format: "£%.02f", Double(newAmount)!)
        } else if (currency == "EUR") {
            newAmount = String(format: "€%.02f", Double(newAmount)!)
        } else if (currency == "JPY") {
            newAmount = String(format: "¥%.02f", Double(newAmount)!)
        }
        
        return(newAmount)
    }
    
    func changeCurrency(newCurrency: String) {
        startup()
        settingsInfo[0] = newCurrency
        settings = arrayToString(inputArray: settingsInfo)
        writeToFile(fileName: "settings.txt", text: settings)
    }
    
    func changeShowDistance(show: Bool) {
        startup()
        settingsInfo[1] = String(show)
        settings = arrayToString(inputArray: settingsInfo)
        writeToFile(fileName: "settings.txt", text: settings)
    }
    
    func formatDistance(distance: String) -> String {
        startup()
        var newDistance = distance
        if (Double(distance) == nil) {
            newDistance = "0"
        }
        if (distanceUnit == "Miles") {
            newDistance += " mi"
        } else if (distanceUnit == "Kilometers") {
            newDistance += " km"
        }
        return(newDistance)
    }
    
    func changeDistanceUnit(newUnit: String) {
        startup()
        settingsInfo[2] = newUnit
        settings = arrayToString(inputArray: settingsInfo)
        writeToFile(fileName: "settings.txt", text: settings)
    }
    
    func loadSettings() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent("settings.txt") {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                // settings.txt already exists
            } else {
                writeToFile(fileName: "settings.txt", text: settings)
            }
        }// end creating file
        // read the file
        settingsInfo = readFile(fileName: "settings.txt")
    }// end LoadSettings()
    
    func writeToFile(fileName: String, text: String) {
        do {
            // get the documents folder url
            if let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = DocumentDirectory.appendingPathComponent(fileName)
                // define the string/text to be saved
                let temp = ""
                try temp.write(to: fileURL, atomically: false, encoding: .utf8)
                // writing to disk
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                print("saving was successful")
            }
        } catch {
            print("error with", fileName, ":", error)
        }
    }// end WriteToFile()
    
    func readFile(fileName: String) -> Array<String> {
        var fileContents = [String]()
        do {
            // get the documents folder url
            if let DocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = DocumentDirectory.appendingPathComponent(fileName)
                // reading from disk
                let savedText = try String(contentsOf: fileURL)
                fileContents = stringToArray(inputString: savedText, seperatedBy: "\n")
            }
        } catch {
            print("error with", fileName, error)
        }
        return(fileContents)
    }// end readFile()
    
    func reorganizeParts(project: Int, partRemoved: Int) {
        let fileName = "file" + String(project) + ".txt"
        var fileContents = readFile(fileName: fileName)
        let partIndex = 2 + (partRemoved * 4)
        
        for i in stride(from: partIndex+4, to: fileContents.endIndex, by: 4) {
            // start from part one number higher than the one that was removed
            if (fileContents[i] == "true") {
                // move part forward
                let newPartNum = (((i/2)-1)/2)
                fileContents[i-4] = fileContents[i]
                fileContents[i-3] = fileContents[i+1]
                fileContents[i-2] = fileContents[i+2]
                fileContents[i-1] = fileContents[i+3]
                
                fileContents[i] = "false"
                fileContents[i+1] = "Part" + String(newPartNum) + "Name"
                fileContents[i+2] = "Part" + String(newPartNum) + "Cost"
                fileContents[i+3] = "Part" + String(newPartNum) + "Date"
            }
        }
        writeToFile(fileName: fileName, text: arrayToString(inputArray: fileContents))
    }
    
    func arrayToString (inputArray: Array<String>) -> String {
        return(inputArray.joined(separator: "\n"))
    }
    func stringToArray (inputString: String, seperatedBy: String) -> Array<String> {
        return(inputString.components(separatedBy: seperatedBy))
    }
    
    // Screen width.
    public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
}// end General class

