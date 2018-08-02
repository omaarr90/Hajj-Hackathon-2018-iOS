//
//  LandingViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit
import Lottie

class LandingViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    var vendingMachine: VendingMachine!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var animationContentView: UIView!
    
    
    var fingerprintView: LOTAnimationView!
    
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
        self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (timer) in
            self.titleLabel.text = self.itemList[self.currentIndex]
            self.titleLabel.textColor = .black
            self.currentIndex = self.currentIndex + 1
            if self.currentIndex == 8 {
                self.currentIndex = 0
            }
        }
        
        self.statusLabel.textColor = .red
        self.statusLabel.alpha = 0.0
        self.fingerprintView = fingerView()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destiationNavVC = segue.destination as? UINavigationController, let destinationVC = destiationNavVC.viewControllers.first as? FoodTypeViewController {
            destinationVC.vendingMachine = self.vendingMachine
        }
    }
 
    func fingerView() -> LOTAnimationView {
        let lotView = LOTAnimationView(name: "fingerprint-animation")
        lotView.loopAnimation = true
        lotView.translatesAutoresizingMaskIntoConstraints = false
        self.animationContentView.addSubview(lotView)
        
        //setupConstraints
        let leadingConstraint = NSLayoutConstraint(item: lotView, attribute: .leading, relatedBy: .equal, toItem: self.animationContentView, attribute: .leading, multiplier: 1.0, constant: 0.0)

        let trailingConstraint = NSLayoutConstraint(item: lotView, attribute: .trailing, relatedBy: .equal, toItem: self.animationContentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)

        let topConstraint = NSLayoutConstraint(item: lotView, attribute: .top, relatedBy: .equal, toItem: self.animationContentView, attribute: .top, multiplier: 1.0, constant: 0.0)

        let bottomConstraint = NSLayoutConstraint(item: lotView, attribute: .bottom, relatedBy: .equal, toItem: self.animationContentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)

//        self.animationContentView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])

        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(fingerprintClicked(tap:)))
        lotView.addGestureRecognizer(tapGesture)
        return lotView
    }
    
    @objc func fingerprintClicked(tap: UITapGestureRecognizer) {
        //
        self.fingerprintView.play()
        
        ApiManager.shared.getCustomerEligibility(self.vendingMachine.id) { (elibile) in
            self.fingerprintView.stop()
            if self.vendingMachine.id == 2 {
                self.performSegue(withIdentifier: "showFoodSelection", sender: self)
                return
            }
            if elibile {
                // show next page
                self.performSegue(withIdentifier: "showFoodSelection", sender: self)
            } else {
                // show alert
                self.statusLabel.text = "You're not Eligible"
                self.statusLabel.alpha = 1.0
                UIView.animate(withDuration: 3.0, animations: {
                    self.statusLabel.alpha = 0.0
                })
            }
        }
    }

}
