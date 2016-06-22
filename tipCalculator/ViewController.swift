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
    
    weak var settingsViewController: SettingsViewController!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    var selectedSegmentIndex: Int = 0
    
    var backgroundImageView: UIImageView!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //MARK: - System methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "background")
        view.insertSubview(backgroundImageView, atIndex: 0)
        
        tipControl.selectedSegmentIndex = 0
        selectedSegmentIndex = 0
        billField.becomeFirstResponder()
        
        billField.text = defaults.stringForKey("kBill")
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        backgroundImageView.alpha = 0.5
        UIView.animateWithDuration(1.5, animations: {
            self.backgroundImageView.alpha = 1
        })
        print("view will appear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
       
    }

    
    //MARK: - IBAction methods
    
    @IBAction func enterBillAmount(sender: AnyObject) {
       
        defaults.setObject(billField.text, forKey: "kBill")
        defaults.synchronize()
        
        var tipPercentages = [0.3, 0.25, 0.2, 0.15]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let whenSegmentIs:Int = tipControl.selectedSegmentIndex
        selectedSegmentIndex = whenSegmentIs

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
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipAmount = billAmount * tipPercentage
        let totalAmount = billAmount + tipAmount
        
    tipLabel.text = "$\(tipAmount)"
    totalLabel.text = "$\(totalAmount)"
    }
    
    // 4

    @IBAction func pushToSettingsViewControllerAction(sender: UIBarButtonItem) {
        settingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        settingsViewController.currentImage = backgroundImageView.image
        settingsViewController.delegate = self
        settingsViewController.tipValue = tipFirstLabel.text!
        
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
   
    @IBAction func dismissKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    //MARK: - Private methods
    
    func changeSelectedSegmentIndex() {
        selectedSegmentIndex += 1
        if selectedSegmentIndex > 3 {
            selectedSegmentIndex = 0
        }
        tipControl.selectedSegmentIndex = selectedSegmentIndex
        
    }
}


//MARK: - SettingsViewControllerDelegate methods

extension ViewController: SettingsViewControllerDelegate {
    func changeBackGroundImage(image: UIImage, owner: SettingsViewController) {
        self.backgroundImageView.image = image
    }
    //5.1
    func changeSelectedSegmentIndex(owner: SettingsViewController) {
        changeSelectedSegmentIndex()
        enterBillAmount(tipControl)
        
        if settingsViewController != nil {
            settingsViewController.tipLabel.text = tipFirstLabel.text
        }
    }
}

