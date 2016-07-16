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
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var tauTextField: UITextField!
    @IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var tauStepper: UIStepper!
    @IBOutlet weak var reverseTimeSwitch: UISwitch!
    @IBOutlet weak var velocityStepper: UIStepper!
    @IBOutlet weak var accelerationStepper: UIStepper!
    @IBOutlet weak var velocityTextField: UITextField!
    @IBOutlet weak var accelerationTextField: UITextField!

    var timer: Timer?
    var originDate: Date = Date()
    var tmDateTime = Time.secsToDateTime(sec: Date().timeIntervalSince1970)
    let originDateFormatter =  DateFormatter()
    let tmYearFormatter = DateFormatter()
    let tmMonthFormatter = DateFormatter()
    var tmDayFormatter = DateFormatter()
    var tmTimeFormatter = DateFormatter()
    
    var tau: Double = 1.0
    let maxTau: Double = 10_000_000_000_000.0
    let minTau: Double = 0.0001
    var previousTauStepperValue = 0.0
    var velocity: Double = 0.0
    let maxVelocity = 1.0  // = c
    let velocityStepSize = 0.01
    var acceleration: Double = 0.0
    let maxAcceleration = 100.0 // 100 g
    let accelerationStepSize = 0.1
    

    
    let controlTitle = "CONTROL"
    let updateInterval = 0.001
    var counter: Int = 0
    var initialDate = Date()
    var reverseTime = false

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
        // TODO: remove
        print ("\(originDateFormatter.string(from: Date.distantFuture))")
        print ("\(originDateFormatter.string(from: Date.distantPast))")
        // Set up indicators
        tauTextField.delegate = self
        tauTextField.text = "1.0"
        tauStepper.wraps = true
        tauStepper.minimumValue = -10
        tauStepper.maximumValue = 10
        tauStepper.value = 0
        velocityTextField.text = "0"
        accelerationTextField.text = "0"
        velocityStepper.wraps = false
        velocityStepper.minimumValue = 0
        velocityStepper.maximumValue = maxVelocity / velocityStepSize
        velocityStepper.stepValue = 1
        accelerationStepper.wraps = false
        accelerationStepper.minimumValue = 0
        accelerationStepper.maximumValue = maxAcceleration / accelerationStepSize
        accelerationStepper.stepValue = 1
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
            tmMonthLabel.text = "\(Time.monthName[(tmDateTime.month)])"
            tmDayLabel.text = "\(tmDateTime.day)"
            tmTimeLabel.text = tmDateTime.formatTime()
        }
    }
    
    private func updateTmTimeWithNSDate() {
        let secDiff = tau * updateInterval
        initialDate = initialDate.addingTimeInterval(secDiff)
        tmYearLabel.text = tmYearFormatter.string(from: initialDate)
        tmMonthLabel.text = tmMonthFormatter.string(from: initialDate)
        tmDayLabel.text = tmDayFormatter.string(from: initialDate)
        tmTimeLabel.text = tmTimeFormatter.string(from: initialDate)
        
    }
    
    // MARK: actions
    
    @IBAction func reverseTime(_ sender: AnyObject) {
        reverseTime = reverseTimeSwitch.isOn
        tau = resignTau(tau)
        tauTextField.text = "\(tau)"
    }
    
    @IBAction func changeVelocity(_ sender: AnyObject) {
        velocity = velocityStepper.value * velocityStepSize
        updateVelocityIndicator(velocity)
    }
    
    func updateVelocityIndicator(_ value: Double) {
        velocityTextField.text = String(format: "%.2g", value)
    }
    
    @IBAction func changeAcceleration(_ sender: AnyObject) {
        acceleration = accelerationStepper.value * accelerationStepSize
        updateAccelerationIndicator(acceleration)
    }
    
    func updateAccelerationIndicator(_ value: Double) {
        accelerationTextField.text = String(format: "%.3g", value)
    }
    
    
    @IBAction func changeTau(_ sender: AnyObject) {
        tau = unsignTau(tau)
        if stepperDirection(tauStepper, previousValue: &previousTauStepperValue) == .Increment {
            print("increment")
            if tau == 0 {
                tau = minTau
            }
            else if tau < maxTau {
                tau *= 10
            }
        }
        else {
            print("decrement")
            if tau <= minTau {
                tau = 0
            }
            else {
                tau /= 10
            }
        }
        tau = signTau(tau)
        updateTauIndicator(tau)
    }
    
    func unsignTau(_ signedTau: Double) -> Double {
        return abs(signedTau)
    }
    
    // assumes passing directionless (positive) tau
    func signTau(_ unsignedTau: Double) -> Double {
        var newTau = unsignedTau
        if reverseTime {
            newTau = -newTau
        }
        return newTau
    }
    
    // returns tau signed for time direction
    func resignTau(_ value: Double) -> Double {
        return signTau(unsignTau(value))
    }
    
    func updateTauIndicator(_ value: Double) {
        tauTextField.text = "\(value)"
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
        acceleration = 0
        velocity = 0

        resetTauStepper()
        accelerationStepper.value = accelerationStepper.minimumValue
        velocityStepper.value = velocityStepper.minimumValue
        
        updateTauIndicator(tau)
        updateVelocityIndicator(velocity)
        updateAccelerationIndicator(acceleration)
        
        reverseTime = false
        reverseTimeSwitch.isOn = false
    }
    
    func resetTauStepper() {
        tauStepper.value = 0
        previousTauStepperValue = 0
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

