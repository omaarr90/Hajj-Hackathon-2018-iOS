//
//  LandingViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit


class LandingViewController: UIViewController {
    
    var vendingMachine: VendingMachine!
    @IBOutlet weak var titleLabel: UILabel!
    
    let itemList = ["Food",
                    "طعام",
                    "Comida",
                    "フード",
                    "Gıda",
                    "کھانا",
                    "cibus",
                    "खाना"]
    
    var currentIndex = 0
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.fadeTransition(0.2)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.titleLabel.text = self.itemList[self.currentIndex]
            self.currentIndex = self.currentIndex + 1
            if self.currentIndex == 8 {
                self.currentIndex = 0
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
