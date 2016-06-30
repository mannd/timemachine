//
//  ViewController.swift
//  timemachine
//
//  Created by David Mann on 6/8/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: outlets
    @IBOutlet weak var originTimeLabel: UILabel!
    @IBOutlet weak var tmYearLabel: UILabel!
    @IBOutlet weak var tmMonthLabel: UILabel!
    @IBOutlet weak var tmDayLabel: UILabel!
    @IBOutlet weak var tmTimeLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var accelerationLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var tauSwitch: UISwitch!
    @IBOutlet weak var tauTextField: UITextField!
    @IBOutlet weak var velocitySwitch: UISwitch!
    @IBOutlet weak var accelerationSwitch: UISwitch!
    @IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var controlSlider: UISlider!

    var timer: Timer?
    var originDate: Date = Date()
    var tmDateTime: DateTime = Time.secsToDateTime(sec: Date().timeIntervalSince1970)
    let originDateFormatter =  DateFormatter()
    let tmYearFormatter = DateFormatter()
    let tmMonthFormatter = DateFormatter()
    var tmDayFormatter = DateFormatter()
    var tmTimeFormatter = DateFormatter()
    
    var tau: Double = 1.0
    
    let controlTitle = "CONTROL"
    let updateInterval = 0.001
    var counter: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(timerDidTick), userInfo: nil, repeats: true)
        originDateFormatter.dateFormat = "yyyy MMM d HH:mm:ss"
        originDateFormatter.timeZone = TimeZone(name: "UTC")
        tmYearFormatter.dateFormat = "yyyy"
        tmMonthFormatter.dateFormat = "MMMM"
        tmDayFormatter.dateFormat = "d"
        tmTimeFormatter.dateFormat = "HH:mm:ss"
        tmTimeFormatter.timeZone = TimeZone(name: "UTC")
        print ("\(originDateFormatter.string(from: Date.distantFuture))")
        print ("\(originDateFormatter.string(from: Date.distantPast))")
        tauTextField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerDidTick() {
        updateOriginTime()
        updateTmTime()
    }
    
    private func updateOriginTime() {
        originDate = Date()
        originTimeLabel.text = ("CE \(originDateFormatter.string(from: originDate))")
    }
    
    private func updateTmTime() {
        // test assume tau = 10
        tau = 1000000000000
        let secDiff = tau * updateInterval
        if tau == -11 {
            tmYearLabel.text = tmYearFormatter.string(from: originDate)
            tmMonthLabel.text = tmMonthFormatter.string(from: originDate)
            tmDayLabel.text = tmDayFormatter.string(from: originDate)
            tmTimeLabel.text = tmTimeFormatter.string(from: originDate)
        }
        else  {
            tmDateTime = Time.addSecsToDateTime(dateTime: tmDateTime, sec: secDiff)
            tmYearLabel.text = "\(tmDateTime.year)"
            tmMonthLabel.text = "\(Time.monthName[tmDateTime.month])"
            tmDayLabel.text = "\(tmDateTime.day)"
            tmTimeLabel.text = tmDateTime.formatTime()
        }
    }
    
    // MARK: actions
    @IBAction func tauSwitchAction(_ sender: AnyObject) {
        if tauSwitch.isOn {
            velocitySwitch.setOn(false, animated: true)
            accelerationSwitch.setOn(false, animated: true)
            controlLabel.text = "TAU"
            if let value = Float(tauTextField.text!) {
                controlSlider.value = value
            }
        }
        else {
            controlLabel.text = controlTitle
        }
    }
    
    @IBAction func velocitySwitchAction(_ sender: AnyObject) {
        if velocitySwitch.isOn {
            tauSwitch.setOn(false, animated: true)
            accelerationSwitch.setOn(false, animated: true)
            controlLabel.text = "VELOCITY"
            if let value = Float(velocityLabel.text!) {
                controlSlider.value = value
            }        }
        else {
            controlLabel.text = controlTitle
        }
    }
    
    @IBAction func accelerationSwitchAction(_ sender: AnyObject) {
        if accelerationSwitch.isOn {
            velocitySwitch.setOn(false, animated: true)
            tauSwitch.setOn(false, animated: true)
            controlLabel.text = "ACCELERATION"
            if let value = Float(accelerationLabel.text!) {
                controlSlider.value = value
            }        }
        else {
            controlLabel.text = controlTitle
        }
    }
    
    @IBAction func controlSliderAction(_ sender: AnyObject) {
        if tauSwitch.isOn {
            tauTextField.text = "\(controlSlider.value)"
        }
        else if velocitySwitch.isOn {
            velocityLabel.text = "\(controlSlider.value)"
        }
        else if accelerationSwitch.isOn {
            accelerationLabel.text = "\(controlSlider.value)"
        }
    }
    
    @IBAction func startButtonAction(_ sender: AnyObject) {
    }
    
    @IBAction func stopButtonAction(_ sender: AnyObject) {
    }
    
    @IBAction func resetButtonAction(_ sender: AnyObject) {
    }
    
    @IBAction func settingsButtonAction(_ sender: AnyObject) {
    }
    
    @IBAction func helpButtonAction(_ sender: AnyObject) {
    }
    
//    - (IBAction)textFieldDoneEditing:(id)sender {
//    [sender resignFirstResponder];
//    }
//    
//    - (IBAction)backgroundTap:(id)sender {
//    [self.numberOfDaysTextField resignFirstResponder];
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    



}

