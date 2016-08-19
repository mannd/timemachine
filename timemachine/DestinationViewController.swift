//
//  DestinationViewController.swift
//  timemachine
//
//  Created by David Mann on 7/21/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import UIKit

protocol DestinationViewControllerDelegate {
    func setDestinationMoment(date: NSDate)
}

class DestinationViewController: UIViewController,
    UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var monthPicker = UIPickerView()
    var monthData = [
        "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL",
        "AUG", "SEP", "OCT", "NOV", "DEC"
    ]
    let monthTag = 9999
    
    var timePicker = UIDatePicker()

    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    var date = Date()
    var delegate: DestinationViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        monthPicker.dataSource = self
        monthPicker.delegate = self
        monthPicker.tag = monthTag
        monthTextField.inputView = monthPicker
        
        
        timePicker.datePickerMode = UIDatePickerMode.time
        timeTextField.inputView = timePicker
        timePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        yearTextField.delegate = self
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        print(sender.date.description)
        let date = timePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        timeTextField.text = dateFormatter.string(from: date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func setDestinationMoment(_ sender: AnyObject) {
        // for now just dismiss
        delegate?.setDestinationMoment(date: date as NSDate)
        dismiss(animated: true, completion: nil)
    }

    
    
    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == monthTag {
            return monthData.count
        }
        else {
            return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == monthTag {
            return monthData[row]
        }
        else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == monthTag {
            monthTextField.text = monthData[row]
            monthTextField.resignFirstResponder()
        }
        else {
            let date = timePicker.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            timeTextField.text = dateFormatter.string(from: date)
            timeTextField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        textField.resignFirstResponder()
        return false
    }
    
    

}
