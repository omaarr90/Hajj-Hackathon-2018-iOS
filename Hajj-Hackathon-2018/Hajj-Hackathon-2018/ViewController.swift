//
//  ViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 31/07/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class ViewController: DetailsCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addHeader(with: "Hajj Hackathon 2018")
        self.addDetails(with: "Key", and: "Value")
        self.addPersonCell(name: "Omar", image:UIImage(named: "profile")!)
        self.addButtonCell(title: "Button Test", color: UIColor.blue, titleColor: UIColor.white) {
            //
        }
        
        self.addEmptyCell()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

