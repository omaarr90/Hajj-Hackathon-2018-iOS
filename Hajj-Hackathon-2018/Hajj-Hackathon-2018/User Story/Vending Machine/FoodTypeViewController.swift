//
//  FoodTypeViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 02/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class FoodTypeViewController: UIViewController {

    
    @IBOutlet weak var chickenImageView: UIImageView!
    @IBOutlet weak var vagenImageView: UIImageView!
    @IBOutlet weak var fishImageView: UIImageView!
    @IBOutlet weak var meatImageView: UIImageView!
    
    @IBOutlet var sizeConstraint: [NSLayoutConstraint]!
    
    var vendingMachine: VendingMachine!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Select"
        
        self.chickenImageView.layer.cornerRadius = 35.0
        self.vagenImageView.layer.cornerRadius = 35.0
        self.fishImageView.layer.cornerRadius = 35.0
        self.meatImageView.layer.cornerRadius = 35.0
        
        self.chickenImageView.clipsToBounds = true
        self.vagenImageView.clipsToBounds = true
        self.fishImageView.clipsToBounds = true
        self.meatImageView.clipsToBounds = true
        
        for constraint in sizeConstraint {
            constraint.constant = 300
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showFoodList))
        self.chickenImageView.addGestureRecognizer(tapGesture)
        self.fishImageView.addGestureRecognizer(tapGesture)
        self.meatImageView.addGestureRecognizer(tapGesture)
        self.vagenImageView.addGestureRecognizer(tapGesture)

        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationVC = segue.destination as? VendingMachineCollectionViewController {
            destinationVC.vendingMachine = self.vendingMachine
        }
    }
    
    @objc func showFoodList()
    {
        self.performSegue(withIdentifier: "showFoodSelection", sender: self)
    }

}
