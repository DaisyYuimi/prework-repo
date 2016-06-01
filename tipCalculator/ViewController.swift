//
//  ViewController.swift
//  tipCalculator
//
//  Created by sophie on 6/1/16.
//  Copyright © 2016 CorazonCreations. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!

    @IBOutlet weak var tipFirstLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "background")
        view.insertSubview(backgroundImageView, atIndex: 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
    }

    
    //MARK: - IBAction methods
    
    @IBAction func enterBillAmount(sender: AnyObject) {
        var tipPercentages = [0.3, 0.25, 0.2, 0.15]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var whenSegmentIs:Int = tipControl.selectedSegmentIndex

        switch whenSegmentIs {
        case 0:
            tipFirstLabel.text = "30%"
        case 1:
            tipFirstLabel.text = "25%"
        case 2:
            tipFirstLabel.text = "20%"
        case 3:
            tipFirstLabel.text = "15%"
        default:
            tipFirstLabel.text = "30%"
        }
        
        var billAmount = NSString(string: billField.text!).doubleValue
        var tipAmount = billAmount * tipPercentage
        var totalAmount = billAmount + tipAmount
        
    tipLabel.text = "$\(tipAmount)"
    totalLabel.text = "$\(totalAmount)"
  
    }
    
    // 4

    @IBAction func pushToSettingsViewControllerAction(sender: UIBarButtonItem) {
        let settingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        settingsViewController.currentImage = backgroundImageView.image
        settingsViewController.delegate = self
        
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
   
    @IBAction func dismissKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
}

// 5

extension ViewController: SettingsViewControllerDelegate {
    func changeBackGroundImage(image: UIImage, owner: SettingsViewController) {
        self.backgroundImageView.image = image
    }
}

