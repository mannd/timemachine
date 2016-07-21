//
//  DestinationViewController.swift
//  timemachine
//
//  Created by David Mann on 7/21/16.
//  Copyright © 2016 EP Studios. All rights reserved.
//

import UIKit

class DestinationViewController: UIViewController {
    
    var date:NSDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func setDestinationMoment(_ sender: AnyObject) {
        // for now just dismiss
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

}
