//
//  SettingsViewController.swift
//  tipCalculator
//
//  Created by sophie on 6/1/16.
//  Copyright © 2016 CorazonCreations. All rights reserved.
//

import UIKit


// 1
protocol SettingsViewControllerDelegate: class {
    func changeBackGroundImage(image: UIImage, owner: SettingsViewController)
    //1.1
    func changeSelectedSegmentIndex(owner: SettingsViewController)
}


class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    var currentImage: UIImage?
    
    // 2
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Setting"
        backgroundImageView.image = currentImage
        
        view.insertSubview(backgroundImageView, atIndex: 0)
        backgroundImageView.alpha = 0.5
        UIView.animateWithDuration(1.5, animations: {
            self.backgroundImageView.alpha = 1
        })

    }
    
    @IBAction func changeSelectedSegmentIndex(sender: UIButton) {
        //3.1
        self.delegate?.changeSelectedSegmentIndex(self)
    }
    
    @IBAction func changeBackgroundAction(sender: UIButton) {
        if currentImage == UIImage(named: "background") {
            currentImage = UIImage(named: "background2")
        }
        else {
            currentImage = UIImage(named: "background")
        }
        
        backgroundImageView.image = currentImage
        
        //3
        self.delegate?.changeBackGroundImage(currentImage!, owner: self)
    }

}

