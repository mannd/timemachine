//
//  ViewController.swift
//  timemachine
//
//  Created by David Mann on 6/8/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var originTimeLabel: UILabel!
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerDidTick), userInfo: nil, repeats: true)
         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerDidTick() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMM d HH:mm:ss.SS"
        originTimeLabel.text = (dateFormatter.string(from: date))
    }


}

