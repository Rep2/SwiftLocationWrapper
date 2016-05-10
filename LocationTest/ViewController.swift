//
//  ViewController.swift
//  LocationTest
//
//  Created by Macbook Pro 1 on 10/05/2016.
//  Copyright © 2016 rep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LocationManager.instance.getLocation { (location) in
            print(location)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

