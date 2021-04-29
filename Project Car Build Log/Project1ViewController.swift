//
//  Project1ViewController.swift
//  Project Car Build Log
//
//  Created by Nick Abel on 2/21/18.
//  Copyright © 2018 Nick Abel. All rights reserved.
//

import UIKit
import GoogleMobileAds

class Project1ViewController: UIViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var BigView: UIView!
    
    @IBOutlet weak var Part1View: UIView!
    @IBOutlet weak var Part2View: UIView!
    @IBOutlet weak var Part3View: UIView!
    @IBOutlet weak var Part4View: UIView!
    @IBOutlet weak var Part5View: UIView!
    @IBOutlet weak var Part6View: UIView!
    @IBOutlet weak var Part7View: UIView!
    @IBOutlet weak var Part8View: UIView!
    @IBOutlet weak var Part9View: UIView!
    @IBOutlet weak var Part10View: UIView!
    @IBOutlet weak var Part11View: UIView!
    @IBOutlet weak var Part12View: UIView!
    @IBOutlet weak var Part13View: UIView!
    @IBOutlet weak var Part14View: UIView!
    @IBOutlet weak var Part15View: UIView!
    @IBOutlet weak var Part16View: UIView!
    @IBOutlet weak var Part17View: UIView!
    @IBOutlet weak var Part18View: UIView!
    @IBOutlet weak var Part19View: UIView!
    @IBOutlet weak var Part20View: UIView!
    
    @IBOutlet weak var AddPartButton: UIImageView!
    @IBOutlet weak var P1BannerView: GADBannerView!
    @IBOutlet weak var Version: UILabel!
    let general = General()
    var allowableCharacters = "0123456789."
    var currencySymbol = "$"
    var DeletePushed = false
    var PartInfo: [String] = []
    var TotalCost = 0.0
    var Part1Exists = false, Part2Exists = false, Part3Exists = false, Part4Exists = false, Part5Exists = false, Part6Exists = false, Part7Exists = false, Part8Exists = false, Part9Exists = false, Part10Exists = false, Part11Exists = false, Part12Exists = false, Part13Exists = false, Part14Exists = false, Part15Exists = false, Part16Exists = false, Part17Exists = false, Part18Exists = false, Part19Exists = false, Part20Exists = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.removeConstraints(self.view.constraints)
        setupConstraints()
        PartInfo = general.readFile(fileName: "file1.txt")
        if general.getCurrency() == "USD" {
            currencySymbol = "$"
        } else if general.getCurrency() == "GBP" {
            currencySymbol = "£"
        } else if general.getCurrency() == "EUR" {
            currencySymbol = "€"
        } else if general.getCurrency() == "JPY" {
            currencySymbol = "¥"
        }
        setup()
        if general.getPro() {
            P1BannerView.isHidden = true
        } else {
            self.P1BannerView.adUnitID = general.getGADUnitID(storyboard: "Project")
            self.P1BannerView.rootViewController = self
            P1BannerView.load(GADRequest())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupConstraints() {
        let centerX = view.center.x
        
        if general.getPro() {
            Version.center.y = view.frame.maxY - 25
        } else {
            P1BannerView.center.x = centerX
            P1BannerView.center.y = view.frame.maxY - 50
            Version.center.y = P1BannerView.center.y - 35
        }
        Version.center.x = centerX
        Version.text = general.getVersion()
        Version.textAlignment = .center
        AddPartButton.center.x = view.frame.maxX - 48
        AddPartButton.center.y = Version.center.y - 50
        AddPartButton.layer.shadowOpacity = 0.5
        
        ScrollView.frame.size.width = view.frame.width
        ScrollView.contentSize = CGSize(width: view.frame.width, height: 3340)
        ScrollView.center.x = centerX
        
        BigView.frame.size.width = ScrollView.frame.width
        BigView.frame.size.height = 3000
        BigView.center.x = centerX
        self.view.bringSubviewToFront(P1BannerView)
        self.view.bringSubviewToFront(Version)
        self.view.bringSubviewToFront(AddPartButton)
    }
    
    func setup() {
        self.title = PartInfo[1]
        TotalCost = Double(PartInfo[2])!
        let StdWidth = BigView.frame.width
        if (PartInfo[6] == "true") {
            Part1Exists = true
            Part1View.isHidden = false
            Part1View.frame.size.width = StdWidth - 20
            Part1View.layer.borderWidth = 1
            Part1View.layer.borderColor = UIColor.blue.cgColor
            Part1View.layer.cornerRadius = 5
            let Part1Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part1Name.text = PartInfo[7]
            let Part1Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part1Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[8])!)
            let Part1Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part1Date.text = PartInfo[9]
            Part1View.addSubview(Part1Name)
            Part1View.addSubview(Part1Cost)
            Part1View.addSubview(Part1Date)
            BigView.addSubview(Part1View)
        } else {
            Part1Exists = false
        }
        if (PartInfo[10] == "true") {
            Part2Exists = true
            Part2View.isHidden = false
            Part2View.frame.size.width = StdWidth - 20
            Part2View.layer.borderWidth = 1
            Part2View.layer.borderColor = UIColor.blue.cgColor
            Part2View.layer.cornerRadius = 5
            let Part2Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part2Name.text = PartInfo[11]
            let Part2Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part2Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[12])!)
            let Part2Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part2Date.text = PartInfo[13]
            Part2View.addSubview(Part2Name)
            Part2View.addSubview(Part2Cost)
            Part2View.addSubview(Part2Date)
            BigView.addSubview(Part2View)
        } else {
            Part2Exists = false
        }
        if (PartInfo[14] == "true") {
            Part3Exists = true
            Part3View.isHidden = false
            Part3View.frame.size.width = StdWidth - 20
            Part3View.layer.borderWidth = 1
            Part3View.layer.borderColor = UIColor.blue.cgColor
            Part3View.layer.cornerRadius = 5
            let Part3Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part3Name.text = PartInfo[15]
            let Part3Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part3Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[16])!)
            let Part3Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part3Date.text = PartInfo[17]
            Part3View.addSubview(Part3Name)
            Part3View.addSubview(Part3Cost)
            Part3View.addSubview(Part3Date)
            BigView.addSubview(Part3View)
        } else {
            Part3Exists = false
        }
        if (PartInfo[18] == "true") {
            Part4Exists = true
            Part4View.isHidden = false
            Part4View.frame.size.width = StdWidth - 20
            Part4View.layer.borderWidth = 1
            Part4View.layer.borderColor = UIColor.blue.cgColor
            Part4View.layer.cornerRadius = 5
            let Part4Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part4Name.text = PartInfo[19]
            let Part4Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part4Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[20])!)
            let Part4Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part4Date.text = PartInfo[21]
            Part4View.addSubview(Part4Name)
            Part4View.addSubview(Part4Cost)
            Part4View.addSubview(Part4Date)
            BigView.addSubview(Part4View)
        } else {
            Part4Exists = false
        }
        if (PartInfo[22] == "true") {
            Part5Exists = true
            Part5View.isHidden = false
            Part5View.frame.size.width = StdWidth - 20
            Part5View.layer.borderWidth = 1
            Part5View.layer.borderColor = UIColor.blue.cgColor
            Part5View.layer.cornerRadius = 5
            let Part5Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part5Name.text = PartInfo[23]
            let Part5Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part5Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[24])!)
            let Part5Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part5Date.text = PartInfo[25]
            Part5View.addSubview(Part5Name)
            Part5View.addSubview(Part5Cost)
            Part5View.addSubview(Part5Date)
            BigView.addSubview(Part5View)
        } else {
            Part5Exists = false
        }
        if (PartInfo[26] == "true") {
            Part6Exists = true
            Part6View.isHidden = false
            Part6View.frame.size.width = StdWidth - 20
            Part6View.layer.borderWidth = 1
            Part6View.layer.borderColor = UIColor.blue.cgColor
            Part6View.layer.cornerRadius = 5
            let Part6Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part6Name.text = PartInfo[27]
            let Part6Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part6Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[28])!)
            let Part6Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part6Date.text = PartInfo[29]
            Part6View.addSubview(Part6Name)
            Part6View.addSubview(Part6Cost)
            Part6View.addSubview(Part6Date)
            BigView.addSubview(Part6View)
        } else {
            Part6Exists = false
        }
        if (PartInfo[30] == "true") {
            Part7Exists = true
            Part7View.isHidden = false
            Part7View.frame.size.width = StdWidth - 20
            Part7View.layer.borderWidth = 1
            Part7View.layer.borderColor = UIColor.blue.cgColor
            Part7View.layer.cornerRadius = 5
            let Part7Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part7Name.text = PartInfo[31]
            let Part7Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part7Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[32])!)
            let Part7Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part7Date.text = PartInfo[33]
            Part7View.addSubview(Part7Name)
            Part7View.addSubview(Part7Cost)
            Part7View.addSubview(Part7Date)
            BigView.addSubview(Part7View)
        } else {
            Part7Exists = false
        }
        if (PartInfo[34] == "true") {
            Part8Exists = true
            Part8View.isHidden = false
            Part8View.frame.size.width = StdWidth - 20
            Part8View.layer.borderWidth = 1
            Part8View.layer.borderColor = UIColor.blue.cgColor
            Part8View.layer.cornerRadius = 5
            let Part8Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part8Name.text = PartInfo[35]
            let Part8Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part8Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[36])!)
            let Part8Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part8Date.text = PartInfo[37]
            Part8View.addSubview(Part8Name)
            Part8View.addSubview(Part8Cost)
            Part8View.addSubview(Part8Date)
            BigView.addSubview(Part8View)
        } else {
            Part8Exists = false
        }
        if (PartInfo[38] == "true") {
            Part9Exists = true
            Part9View.isHidden = false
            Part9View.frame.size.width = StdWidth - 20
            Part9View.layer.borderWidth = 1
            Part9View.layer.borderColor = UIColor.blue.cgColor
            Part9View.layer.cornerRadius = 5
            let Part9Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part9Name.text = PartInfo[39]
            let Part9Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part9Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[40])!)
            let Part9Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part9Date.text = PartInfo[41]
            Part9View.addSubview(Part9Name)
            Part9View.addSubview(Part9Cost)
            Part9View.addSubview(Part9Date)
            BigView.addSubview(Part9View)
        } else {
            Part9Exists = false
        }
        if (PartInfo[42] == "true") {
            Part10Exists = true
            Part10View.isHidden = false
            Part10View.frame.size.width = StdWidth - 20
            Part10View.layer.borderWidth = 1
            Part10View.layer.borderColor = UIColor.blue.cgColor
            Part10View.layer.cornerRadius = 5
            let Part10Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part10Name.text = PartInfo[43]
            let Part10Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part10Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[44])!)
            let Part10Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part10Date.text = PartInfo[45]
            Part10View.addSubview(Part10Name)
            Part10View.addSubview(Part10Cost)
            Part10View.addSubview(Part10Date)
            BigView.addSubview(Part10View)
        } else {
            Part10Exists = false
        }
        if (PartInfo[46] == "true") {
            Part11Exists = true
            Part11View.isHidden = false
            Part11View.frame.size.width = StdWidth - 20
            Part11View.layer.borderWidth = 1
            Part11View.layer.borderColor = UIColor.blue.cgColor
            Part11View.layer.cornerRadius = 5
            let Part11Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part11Name.text = PartInfo[47]
            let Part11Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part11Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[48])!)
            let Part11Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part11Date.text = PartInfo[49]
            Part11View.addSubview(Part11Name)
            Part11View.addSubview(Part11Cost)
            Part11View.addSubview(Part11Date)
            BigView.addSubview(Part11View)
        } else {
            Part11Exists = false
        }
        if (PartInfo[50] == "true") {
            Part12Exists = true
            Part12View.isHidden = false
            Part12View.frame.size.width = StdWidth - 20
            Part12View.layer.borderWidth = 1
            Part12View.layer.borderColor = UIColor.blue.cgColor
            Part12View.layer.cornerRadius = 5
            let Part12Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part12Name.text = PartInfo[51]
            let Part12Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part12Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[52])!)
            let Part12Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part12Date.text = PartInfo[53]
            Part12View.addSubview(Part12Name)
            Part12View.addSubview(Part12Cost)
            Part12View.addSubview(Part12Date)
            BigView.addSubview(Part12View)
        } else {
            Part12Exists = false
        }
        if (PartInfo[54] == "true") {
            Part13Exists = true
            Part13View.isHidden = false
            Part13View.frame.size.width = StdWidth - 20
            Part13View.layer.borderWidth = 1
            Part13View.layer.borderColor = UIColor.blue.cgColor
            Part13View.layer.cornerRadius = 5
            let Part13Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part13Name.text = PartInfo[55]
            let Part13Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part13Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[56])!)
            let Part13Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part13Date.text = PartInfo[57]
            Part13View.addSubview(Part13Name)
            Part13View.addSubview(Part13Cost)
            Part13View.addSubview(Part13Date)
            BigView.addSubview(Part13View)
        } else {
            Part13Exists = false
        }
        if (PartInfo[58] == "true") {
            Part14Exists = true
            Part14View.isHidden = false
            Part14View.frame.size.width = StdWidth - 20
            Part14View.layer.borderWidth = 1
            Part14View.layer.borderColor = UIColor.blue.cgColor
            Part14View.layer.cornerRadius = 5
            let Part14Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part14Name.text = PartInfo[59]
            let Part14Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part14Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[60])!)
            let Part14Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part14Date.text = PartInfo[61]
            Part14View.addSubview(Part14Name)
            Part14View.addSubview(Part14Cost)
            Part14View.addSubview(Part14Date)
            BigView.addSubview(Part14View)
        } else {
            Part14Exists = false
        }
        if (PartInfo[62] == "true") {
            Part15Exists = true
            Part15View.isHidden = false
            Part15View.frame.size.width = StdWidth - 20
            Part15View.layer.borderWidth = 1
            Part15View.layer.borderColor = UIColor.blue.cgColor
            Part15View.layer.cornerRadius = 5
            let Part15Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part15Name.text = PartInfo[63]
            let Part15Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part15Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[64])!)
            let Part15Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part15Date.text = PartInfo[65]
            Part15View.addSubview(Part15Name)
            Part15View.addSubview(Part15Cost)
            Part15View.addSubview(Part15Date)
            BigView.addSubview(Part15View)
        } else {
            Part15Exists = false
        }
        if (PartInfo[66] == "true") {
            Part16Exists = true
            Part16View.isHidden = false
            Part16View.frame.size.width = StdWidth - 20
            Part16View.layer.borderWidth = 1
            Part16View.layer.borderColor = UIColor.blue.cgColor
            Part16View.layer.cornerRadius = 5
            let Part16Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part16Name.text = PartInfo[67]
            let Part16Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part16Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[68])!)
            let Part16Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part16Date.text = PartInfo[69]
            Part16View.addSubview(Part16Name)
            Part16View.addSubview(Part16Cost)
            Part16View.addSubview(Part16Date)
            BigView.addSubview(Part16View)
        } else {
            Part16Exists = false
        }
        if (PartInfo[70] == "true") {
            Part17Exists = true
            Part17View.isHidden = false
            Part17View.frame.size.width = StdWidth - 20
            Part17View.layer.borderWidth = 1
            Part17View.layer.borderColor = UIColor.blue.cgColor
            Part17View.layer.cornerRadius = 5
            let Part17Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part17Name.text = PartInfo[71]
            let Part17Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part17Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[72])!)
            let Part17Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part17Date.text = PartInfo[73]
            Part17View.addSubview(Part17Name)
            Part17View.addSubview(Part17Cost)
            Part17View.addSubview(Part17Date)
            BigView.addSubview(Part17View)
        } else {
            Part17Exists = false
        }
        if (PartInfo[74] == "true") {
            Part18Exists = true
            Part18View.isHidden = false
            Part18View.frame.size.width = StdWidth - 20
            Part18View.layer.borderWidth = 1
            Part18View.layer.borderColor = UIColor.blue.cgColor
            Part18View.layer.cornerRadius = 5
            let Part18Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part18Name.text = PartInfo[75]
            let Part18Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part18Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[76])!)
            let Part18Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part18Date.text = PartInfo[77]
            Part18View.addSubview(Part18Name)
            Part18View.addSubview(Part18Cost)
            Part18View.addSubview(Part18Date)
            BigView.addSubview(Part18View)
        } else {
            Part18Exists = false
        }
        if (PartInfo[78] == "true") {
            Part19Exists = true
            Part19View.isHidden = false
            Part19View.frame.size.width = StdWidth - 20
            Part19View.layer.borderWidth = 1
            Part19View.layer.borderColor = UIColor.blue.cgColor
            Part19View.layer.cornerRadius = 5
            let Part19Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part19Name.text = PartInfo[79]
            let Part19Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part19Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[80])!)
            let Part19Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part19Date.text = PartInfo[81]
            Part19View.addSubview(Part19Name)
            Part19View.addSubview(Part19Cost)
            Part19View.addSubview(Part19Date)
            BigView.addSubview(Part19View)
        } else {
            Part19Exists = false
        }
        if (PartInfo[82] == "true") {
            Part20Exists = true
            Part20View.isHidden = false
            Part20View.frame.size.width = StdWidth - 20
            Part20View.layer.borderWidth = 1
            Part20View.layer.borderColor = UIColor.blue.cgColor
            Part20View.layer.cornerRadius = 5
            let Part20Name = UILabel(frame: CGRect(x: 8, y: 8, width: StdWidth / 2, height: 21))
            Part20Name.text = PartInfo[83]
            let Part20Cost = UILabel(frame: CGRect(x: 8, y: 65, width: StdWidth / 2, height: 21))
            Part20Cost.text = String(format: currencySymbol + "%.02f", Double(PartInfo[84])!)
            let Part20Date = UILabel(frame: CGRect(x: 8, y: 120, width: StdWidth / 2, height: 21))
            Part20Date.text = PartInfo[85]
            Part20View.addSubview(Part20Name)
            Part20View.addSubview(Part20Cost)
            Part20View.addSubview(Part20Date)
            BigView.addSubview(Part20View)
        } else {
            Part20Exists = false
        }
    }
    
    @IBAction func AddPartPushed(_ sender: Any) {
        if (!Part1Exists) {
            showInputDialog(partNum: 1)
            print("Add Part 1")
            Part1Exists = true
            setup()
        } else if (!Part2Exists) {
            showInputDialog(partNum: 2)
            print("Add Part 2")
            Part2Exists = true
            setup()
        } else if (!Part3Exists) {
            showInputDialog(partNum: 3)
            print("Add Part 3")
            Part3Exists = true
            setup()
        } else if (!Part4Exists) {
            showInputDialog(partNum: 4)
            print("Add Part 4")
            Part4Exists = true
            setup()
        } else if (!Part5Exists) {
            showInputDialog(partNum: 5)
            print("Add Part 5")
            Part5Exists = true
            setup()
        } else if (!Part6Exists) {
            showInputDialog(partNum: 6)
            print("Add Part 6")
            Part6Exists = true
            setup()
        } else if (!Part7Exists) {
            showInputDialog(partNum: 7)
            print("Add Part 7")
            Part7Exists = true
            setup()
        } else if (!Part8Exists) {
            showInputDialog(partNum: 8)
            print("Add Part 8")
            Part8Exists = true
            setup()
        } else if (!Part9Exists) {
            showInputDialog(partNum: 9)
            print("Add Part 9")
            Part9Exists = true
            setup()
        } else if (!Part10Exists) {
            showInputDialog(partNum: 10)
            print("Add Part 10")
            Part10Exists = true
            setup()
        } else if (!Part11Exists) {
            showInputDialog(partNum: 11)
            print("Add Part 11")
            Part11Exists = true
            setup()
        } else if (!Part12Exists) {
            showInputDialog(partNum: 12)
            print("Add Part 12")
            Part12Exists = true
            setup()
        } else if (!Part13Exists) {
            showInputDialog(partNum: 13)
            print("Add Part 13")
            Part13Exists = true
            setup()
        } else if (!Part14Exists) {
            showInputDialog(partNum: 14)
            print("Add Part 14")
            Part14Exists = true
            setup()
        } else if (!Part15Exists) {
            showInputDialog(partNum: 15)
            print("Add Part 15")
            Part15Exists = true
            setup()
        } else if (!Part16Exists) {
            showInputDialog(partNum: 16)
            print("Add Part 16")
            Part16Exists = true
            setup()
        } else if (!Part17Exists) {
            showInputDialog(partNum: 17)
            print("Add Part 17")
            Part17Exists = true
            setup()
        } else if (!Part18Exists) {
            showInputDialog(partNum: 18)
            print("Add Part 18")
            Part18Exists = true
            setup()
        } else if (!Part19Exists) {
            showInputDialog(partNum: 19)
            print("Add Part 19")
            Part19Exists = true
            setup()
        } else if (!Part20Exists) {
            showInputDialog(partNum: 20)
            print("Add Part 20")
            Part20Exists = true
            setup()
        } else {
            let alert = UIAlertController(title: "Error", message: "Cannot add any more parts", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            print("No Mo Parts!")
        }
    }
    
    func showInputDialog(partNum: Int) {
        let legalCharacters = "0123456789."
        var decimal = false
        var newCost = ""
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Add Part " + String(partNum), message: "", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            // Do stuff with inputed values
            var partName = alertController.textFields?[0].text
            var partCost = alertController.textFields?[1].text
            let partDate = alertController.textFields?[2].text
            
            if (partName == "") {
                partName = "Part " + String(partNum)
            }
            // removes any character from partCost that isn't allowed
            for character in partCost! {
                for symbol in legalCharacters {
                    if character == symbol {
                        if character == "." {
                            if decimal == false {
                                newCost += String(character)
                                decimal = true
                            }
                        } else if (character  == ","){
                            if decimal == false {
                                newCost += "."
                                decimal = true
                            }
                        } else {
                            newCost += String(character)
                        }
                    }
                }
            }
            partCost = newCost
            if (partCost == "") {
                partCost = "00.00"
            }

            self.TotalCost += Double(partCost!)!
            // Write To File, Update Screen
            self.writeNewStuff(partNum: partNum, partName: partName!, partCost: partCost!, partDate: partDate!, doIExist: "true", edit: false)
            self.setup()
            switch(partNum) {
            case 1:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part1View.frame.minY)
            case 2:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part1View.frame.minY)
            case 3:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part2View.frame.minY)
            case 4:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part3View.frame.minY)
            case 5:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part4View.frame.minY)
            case 6:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part5View.frame.minY)
            case 7:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part6View.frame.minY)
            case 8:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part7View.frame.minY)
            case 9:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part8View.frame.minY)
            case 10:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part9View.frame.minY)
            case 11:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part10View.frame.minY)
            case 12:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part11View.frame.minY)
            case 13:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part12View.frame.minY)
            case 14:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part13View.frame.minY)
            case 15:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part14View.frame.minY)
            case 16:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part15View.frame.minY)
            case 17:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part16View.frame.minY)
            case 18:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part17View.frame.minY)
            case 19:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part18View.frame.minY)
            case 20:
                self.ScrollView.contentOffset = CGPoint(x:self.view.frame.minX, y:self.Part18View.frame.minY)
            default:
                self.ScrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to the dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Cost"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Date"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    func writeNewStuff(partNum: Int, partName: String, partCost: String, partDate: String, doIExist: String, edit: Bool) {
        let start = 7 + ((partNum - 1) * 4)
        if (doIExist == "true") {
            if (!edit) {
                //only updates part count if user not editing part
                if (Double(PartInfo[3]) != nil) {
                    PartInfo[3] = String(Int(Double(PartInfo[3])! + 1))
                } else {
                    PartInfo[3] = "1"
                }
            }
            PartInfo[start - 1] = "true" // do i exist
        } else {
            let tempCost = PartInfo[start + 1]
            TotalCost -= Double(tempCost)!
            PartInfo[3] = String(Int(Double(PartInfo[3])! - 1))
            PartInfo[start - 1] = "false"
        }
        PartInfo[2] = String(self.TotalCost)
        PartInfo[start] = partName
        PartInfo[start + 1] = partCost
        PartInfo[start + 2] = partDate
        let PartInfoString = PartInfo.joined(separator: "\n")
        do {
            // get the documents folder url
            if let DocumentDirectory = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first {
                // create the destination url for the text file to be saved
                let fileURL = DocumentDirectory.appendingPathComponent("file1.txt")
                // clear the file
                let text = ""
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                // writing to disk
                try PartInfoString.write(to: fileURL, atomically: false, encoding: .utf8)
                    print("saving was successful")
                }
        } catch {
            print("error with file1:", error)
        }
        general.reorganizeParts(project: 1, partRemoved: partNum)
        setupConstraints()
        setup()
    }
    
    @IBAction func Part1Clicked(_ sender: Any) {
        let partNum = 1
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part2Clicked(_ sender: Any) {
        let partNum = 2
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part3Clicked(_ sender: Any) {
        let partNum = 3
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part4Clicked(_ sender: Any) {
        let partNum = 4
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part5Clicked(_ sender: Any) {
        let partNum = 5
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part6Clicked(_ sender: Any) {
        let partNum = 6
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part7Clicked(_ sender: Any) {
        let partNum = 7
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part8Clicked(_ sender: Any) {
        let partNum = 8
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part9Clicked(_ sender: Any) {
        let partNum = 9
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part10Clicked(_ sender: Any) {
        let partNum = 10
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part11Clicked(_ sender: Any) {
        let partNum = 11
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part12Clicked(_ sender: Any) {
        let partNum = 12
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part13Clicked(_ sender: Any) {
        let partNum = 13
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part14Clicked(_ sender: Any) {
        let partNum = 14
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part15Clicked(_ sender: Any) {
        let partNum = 15
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func Part16Clicked(_ sender: Any) {
        let partNum = 16
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    @IBAction func Part17Clicked(_ sender: Any) {
        let partNum = 17
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    @IBAction func Part18Clicked(_ sender: Any) {
        let partNum = 18
 
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    @IBAction func Part19Clicked(_ sender: Any) {
        let partNum = 19
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    @IBAction func Part20Clicked(_ sender: Any) {
        let partNum = 20
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let editButton = UIAlertAction(title: "Edit Part", style: .default) { (alert : UIAlertAction!) in
            self.editPart(partNum: partNum)
        }
        let deleteButton = UIAlertAction(title: "Delete Part", style: .destructive) { (alert : UIAlertAction!) in
            self.deletePart(partNum: partNum)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        
        optionMenu.addAction(editButton)
        optionMenu.addAction(deleteButton)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func deletePart(partNum: Int) {
        var viewsArray: [UIView] = [Part1View, Part2View, Part3View, Part4View, Part5View, Part6View, Part7View, Part8View, Part9View, Part10View, Part11View, Part12View, Part13View, Part14View, Part15View, Part16View, Part17View, Part18View, Part19View, Part20View]
        print("Deleting part " + String(partNum))
        viewsArray[partNum - 1].isHidden = true
        self.writeNewStuff(partNum: partNum, partName: "Part", partCost: "0", partDate: "0", doIExist: "false", edit: false)
        let labels = viewsArray[partNum - 1].subviews
        for label in labels {
            label.removeFromSuperview()
        }
    }
    
    func editPart(partNum: Int) {
        let legalCharacters = "0123456789."
        var decimal = false
        var newCost = ""
        let infoLoc = ((partNum * 4) + 3)
        var viewsArray: [UIView] = [Part1View, Part2View, Part3View, Part4View, Part5View, Part6View, Part7View, Part8View, Part9View, Part10View, Part11View, Part12View, Part13View, Part14View, Part15View, Part16View, Part17View, Part18View, Part19View, Part20View]
        let alertController = UIAlertController(title: "Edit part " + String(partNum), message: "", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            var partName = alertController.textFields?[0].text
            var partCost = alertController.textFields?[1].text
            let partDate = alertController.textFields?[2].text
            self.PartInfo[infoLoc] = partName!
            let oldCost = self.PartInfo[infoLoc + 1]
            self.PartInfo[infoLoc + 1] = partCost!
            self.PartInfo[infoLoc + 2] = partDate!
            let labels = viewsArray[partNum-1].subviews
            for label in labels {
                label.removeFromSuperview()
            }
            
            if (partName == "") {
                partName = "Part " + String(partNum)
            }
            // removes any character from partCost that isn't allowed
            for character in partCost! {
                for symbol in legalCharacters {
                    if character == symbol {
                        if character == "." {
                            if decimal == false {
                                newCost += String(character)
                                decimal = true
                            }
                        } else if (character  == ","){
                            if decimal == false {
                                newCost += "."
                                decimal = true
                            }
                        } else {
                            newCost += String(character)
                        }
                    }
                }
            }
            partCost = newCost
            if (partCost == "") {
                partCost = "00.00"
            }
            self.TotalCost -= Double(oldCost)!
            self.TotalCost += Double(partCost!)!
            self.writeNewStuff(partNum: partNum, partName: partName!, partCost: partCost!, partDate: partDate!, doIExist: "true", edit: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //edit part name
        alertController.addTextField { (textField) in
            textField.text = self.PartInfo[infoLoc]
            textField.placeholder = self.PartInfo[infoLoc]
        }
        //edit part cost
        alertController.addTextField { (textField) in
            textField.text = self.PartInfo[infoLoc + 1]
            textField.placeholder = self.PartInfo[infoLoc + 1]
        }
        //edit part date
        alertController.addTextField { (textField) in
            textField.text = self.PartInfo[infoLoc + 2]
            textField.placeholder = self.PartInfo[infoLoc + 2]
        }
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        self.present(alertController, animated: true, completion: nil)
    }// end of editPart()
    
    
    func recenterViews(except: Int) {
        var viewsArray: [UIView] = [Part1View, Part2View, Part3View, Part4View, Part5View, Part6View, Part7View, Part8View, Part9View, Part10View, Part11View, Part12View, Part13View, Part14View, Part15View, Part16View, Part17View, Part18View, Part19View, Part20View]
        for index in 0...19 {
            if (index != (except - 1)) {
                viewsArray[index].center.x = view.center.x
            }
        }
    }
}
