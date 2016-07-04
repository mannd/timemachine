//
//  ViewController.swift
//  timemachine
//
//  Created by David Mann on 6/8/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import UIKit

enum StepperDirection {
    case Increment
    case Decrement
}

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
    @IBOutlet weak var tauStepper: UIStepper!

    var timer: Timer?
    var originDate: Date = Date()
    var tmDateTime: DateTime = Time.secsToDateTime(sec: Date().timeIntervalSince1970)
    let originDateFormatter =  DateFormatter()
    let tmYearFormatter = DateFormatter()
    let tmMonthFormatter = DateFormatter()
    var tmDayFormatter = DateFormatter()
    var tmTimeFormatter = DateFormatter()
    
    var tau: Double = 1.0
    let maxTau: Double = 10_000_000_000_000.0
    var previousTauStepperValue = 0.0

    
    let controlTitle = "CONTROL"
    let updateInterval = 0.001
    var counter: Int = 0
    var initialDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(timerDidTick), userInfo: nil, repeats: true)
        originDateFormatter.dateFormat = "yyyy MMM d HH:mm:ss"
        originDateFormatter.timeZone = TimeZone(name: "UTC")
        tmYearFormatter.dateFormat = "yyyy"
        tmMonthFormatter.dateFormat = "MMM"
        tmDayFormatter.dateFormat = "d"
        tmTimeFormatter.dateFormat = "HH:mm:ss"
        tmTimeFormatter.timeZone = TimeZone(name: "UTC")
        print ("\(originDateFormatter.string(from: Date.distantFuture))")
        print ("\(originDateFormatter.string(from: Date.distantPast))")
        tauTextField.delegate = self
        tauTextField.text = "1.0"
        tauStepper.wraps = true
        tauStepper.minimumValue = -10
        tauStepper.maximumValue = 10
        tauStepper.value = 0

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
//        updateTmTimeWithNSDate()
//        return
        // test assume tau = 10
        let secDiff = tau * updateInterval
        if tau == 1 {
            tmYearLabel.text = "CE " + tmYearFormatter.string(from: originDate)
            tmMonthLabel.text = tmMonthFormatter.string(from: originDate)
            tmDayLabel.text = tmDayFormatter.string(from: originDate)
            tmTimeLabel.text = tmTimeFormatter.string(from: originDate)
        }
        else  {
            tmDateTime = Time.addSecsToDateTime(dateTime: tmDateTime, sec: secDiff)
            tmYearLabel.text = "CE \(tmDateTime.year)"
            tmMonthLabel.text = "\(Time.monthName[tmDateTime.month])"
            tmDayLabel.text = "\(tmDateTime.day)"
            tmTimeLabel.text = tmDateTime.formatTime()
        }
    }
    
    private func updateTmTimeWithNSDate() {
        tau = 10_000_000_000_000
        let secDiff = tau * updateInterval
        initialDate = initialDate.addingTimeInterval(secDiff)
        tmYearLabel.text = tmYearFormatter.string(from: initialDate)
        tmMonthLabel.text = tmMonthFormatter.string(from: initialDate)
        tmDayLabel.text = tmDayFormatter.string(from: initialDate)
        tmTimeLabel.text = tmTimeFormatter.string(from: initialDate)
        
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
    
    @IBAction func changeTau(_ sender: AnyObject) {
//        if let newTau = logChangeTau(value: Double(tauTextField.text!), power: tauStepper.value) {
//            tauTextField.text = "\(newTau)"
//            tau = newTau
//        }
        if stepperDirection(tauStepper, previousValue: &previousTauStepperValue) == .Increment {
            print("increment")
            tau *= 10

        }
        else {
            print("decrement")
            tau /= 10
        }
        tauTextField.text = "\(tau)"
     }
    
    // TODO:
    /*
     We want tau to equal the previous tau * 10 to the power of the stepper value. 
     We need to check for max and min tau and not exceed them.
     Negative stepper values are just negative 
     May need to reset stepper to 0 whenever tau is edited directly or if
     tau is nil.
 
 
     */
//    func logChangeTau(value: Double?, power: Double) -> Double? {
//        var newTau: Double? = nil
//        if let tauValue = value {
//            if power >= 0 {
//                if power > previousStepperValue {
//                    newTau = tauValue * 10
//                }
//                else {
//                    newTau = tauValue / 10
//                }
//            }
//            else  { // power < 0
//                if power < previousStepperValue {
//                    newTau = tauValue * 10
//                }
//                else {
//                    newTau = tauValue / 10
//                }
//            }
//        }
//        previousStepperValue = power
//        return newTau
//    }
    
    // There is no direct way to just get boolean increment or decrement from a UIStepper, so this
    // function does that for us.
    func stepperDirection(_ stepper: UIStepper, previousValue: inout Double) -> StepperDirection {
        let minValue = stepper.minimumValue
        let maxValue = stepper.maximumValue
        let value = stepper.value
        var direction: StepperDirection
        if previousValue == maxValue && value == minValue {
            direction =  .Increment
        }
        else if previousValue == minValue && value == maxValue {
            direction = .Decrement
        }
        else if value > previousValue {
            direction = .Increment
        }
        else {
            direction = .Decrement
        }
        previousValue = value
        return direction
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
        tau = 1.0
        if let tauString = tauTextField.text {
            if let newTau = Double(tauString) {
                tau = newTau
            }
        }

    }
    
    @IBAction func stopButtonAction(_ sender: AnyObject) {
        tau = 1.0
    }
    
    @IBAction func resetButtonAction(_ sender: AnyObject) {
        tau = 1.0
        
    }
    
    @IBAction func settingsButtonAction(_ sender: AnyObject) {
    }
    
    @IBAction func helpButtonAction(_ sender: AnyObject) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let enableTauStepper = (tauTextField.text != nil && tauTextField.text?.characters.count > 0)
        tauStepper.isUserInteractionEnabled = enableTauStepper
    }
    
    
    



}

