//
//  HelpControl.swift
//  Project Car Build Log
//
//  Created by Nick Abel on 2/9/18.
//  Copyright © 2018 Nick Abel. All rights reserved.
//

import UIKit
import ImageIO
import MessageUI
import GoogleMobileAds
import Auk

class HelpViewController: UIViewController {
    
    //MARK: Initialization
    @IBOutlet weak var MainImage: UICollectionView!
    @IBOutlet weak var Scroller: UIScrollView!
    @IBOutlet weak var MainText: UITextView!
    @IBOutlet weak var Version: UILabel!
    @IBOutlet weak var HelpBanner: GADBannerView!
    let general = General()
    let timer = Timer()
    var images = [#imageLiteral(resourceName: "help1.png"),#imageLiteral(resourceName: "help2.png"),#imageLiteral(resourceName: "help3.png"),#imageLiteral(resourceName: "help4.png")]
    var imageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.view.removeConstraints(self.view.constraints)
        setupConstraints()
        Scroller.auk.show(image: images[0])
        Scroller.auk.show(image: images[1])
        Scroller.auk.show(image: images[2])
        Scroller.auk.show(image: images[3])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if general.getPro() {
            HelpBanner.isHidden = true
        } else {
            HelpBanner.isHidden = false
            self.HelpBanner.adUnitID = general.getGADUnitID(storyboard: "Help")
            self.HelpBanner.rootViewController = self
            HelpBanner.load(GADRequest())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupConstraints() {
        let centerX = view.center.x
        Scroller.center.x = centerX
        Scroller.center.y = view.center.y - 10
        Scroller.layer.borderWidth = 1
        if general.getPro() {
            HelpBanner.isHidden = true
            Version.center.y = view.frame.maxY - 50
        } else {
            HelpBanner.isHidden = false
            HelpBanner.center.x = centerX
            HelpBanner.center.y = view.frame.maxY - 50
            Version.center.y = HelpBanner.center.y - 35
        }
        Version.center.x = centerX
        Version.text = general.getVersion()
        Version.textAlignment = .center
    }
}
