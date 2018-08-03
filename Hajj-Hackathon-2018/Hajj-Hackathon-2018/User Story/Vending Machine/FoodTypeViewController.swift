//
//  FoodTypeViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 02/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class FoodTypeViewController: UIViewController {

    
    @IBOutlet weak var chickenImageView: UIButton!
    @IBOutlet weak var vagenImageView: UIButton!
    @IBOutlet weak var fishImageView: UIButton!
    @IBOutlet weak var meatImageView: UIButton!
    
    var foodType: SelectionType!
    
    @IBOutlet var sizeConstraint: [NSLayoutConstraint]!
    
    var vendingMachine: VendingMachine!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Select"
        
        for constraint in sizeConstraint {
            constraint.constant = 300
        }

        self.chickenImageView.layer.cornerRadius = 150.0
        self.vagenImageView.layer.cornerRadius = 150.0
        self.fishImageView.layer.cornerRadius = 150.0
        self.meatImageView.layer.cornerRadius = 150.0
        
        self.chickenImageView.clipsToBounds = true
        self.vagenImageView.clipsToBounds = true
        self.fishImageView.clipsToBounds = true
        self.meatImageView.clipsToBounds = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.hajjTextColor
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destinationVC = segue.destination as? VendingMachineCollectionViewController {
            destinationVC.vendingMachine = self.vendingMachine
            destinationVC.foodType = foodType
        }
    }
    
    
    @IBAction func showFoodSelection(_ sender: UIButton) {
        if sender == self.chickenImageView {
            self.foodType = .chicken
        }
        
        if sender == self.fishImageView {
            self.foodType = .seafood
        }
        
        if sender == self.vagenImageView {
            self.foodType = .vagen
        }
        
        if sender == self.meatImageView {
            self.foodType = .meat
        }
        self.performSegue(withIdentifier: "showFoodSelection", sender: self)
    }
}
