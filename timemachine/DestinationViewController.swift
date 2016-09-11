//
//  DestinationViewController.swift
//  timemachine
//
//  Created by David Mann on 7/21/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import UIKit

protocol DestinationViewControllerDelegate {
    func setDestinationMoment(moment: Moment)
}

class DestinationViewController: UIViewController,
    UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var monthPicker = UIPickerView()
    var monthData = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
        "Aug", "Sep", "Oct", "Nov", "Dec"
    ]
    let monthTag = 9999
    
    var timePicker = UIDatePicker()

    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var eraSegmentedControl: UISegmentedControl!
    
    var destinationMoment = Moment()
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
        dayTextField.delegate = self
        // if no previous destination, make destination moment = now
        if destinationMoment.era() == .BCE {
            eraSegmentedControl.selectedSegmentIndex = 0
        }
        else {
            eraSegmentedControl.selectedSegmentIndex = 1
        }
        yearTextField.text = destinationMoment.year()
        monthTextField.text = destinationMoment.month()
        monthPicker.selectRow(destinationMoment.monthNumber(), inComponent: 0, animated: false)
        dayTextField.text = destinationMoment.day()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeZone = Time.UtcTimeZone
        timeTextField.text = destinationMoment.time(dateFormatter: timeFormatter)
        timePicker.date = destinationMoment.date
        timePicker.timeZone = Time.UtcTimeZone
        
        //
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        print(sender.date.description)
        let date = timePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = Time.UtcTimeZone
        timeTextField.text = dateFormatter.string(from: date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func setDestinationMoment(_ sender: AnyObject) {
        // MARK: TODO
        // set destinationMoment to results of textfields here
//        destinationMoment = Moment(era: .CE, year: Int(yearTextField.text!)!, month: 0, day: Int(dayTextField.text!)!, hour: 0, minute: 0, second: 0)
        print(destinationMoment.formattedMoment())
        delegate?.setDestinationMoment(moment: destinationMoment)
        dismiss(animated: true, completion: nil)
    }

    
    
    @IBAction func cancel(_ sender: AnyObject) {
        print("Cancel")
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
            dateFormatter.dateFormat = "H:mm"
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
