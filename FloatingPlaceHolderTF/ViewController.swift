//
//  ViewController.swift
//  FloatingPlaceHolderTF
//
//  Created by Dhairya Uniyal on 27/12/17.
//  Copyright © 2017 NEO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textfield_UserName: FPHtextfield!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(self.textfield_UserName.frame)
    }


}

