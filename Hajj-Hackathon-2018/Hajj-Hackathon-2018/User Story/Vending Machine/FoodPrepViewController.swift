//
//  FoodPrepViewController.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 02/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit
import Lottie

protocol FoodPrepViewControllerDelegate {
    func didFinishPreparingFood(controller: FoodPrepViewController)
}

class FoodPrepViewController: UIViewController {

    @IBOutlet weak var animationContentView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var delegate: FoodPrepViewControllerDelegate?
    
    
    var animationView: LOTAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.animationView = self.loadingView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animationView.play()
        let _ = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { (timer) in
            self.delegate?.didFinishPreparingFood(controller: self)
        }
    }
 
    func loadingView() -> LOTAnimationView {
        let lotView = LOTAnimationView(name: "food-preparing")
        lotView.loopAnimation = true
        lotView.translatesAutoresizingMaskIntoConstraints = false
        self.animationContentView.addSubview(lotView)
        
        //setupConstraints
        let leadingConstraint = NSLayoutConstraint(item: lotView, attribute: .leading, relatedBy: .equal, toItem: self.animationContentView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        
        let trailingConstraint = NSLayoutConstraint(item: lotView, attribute: .trailing, relatedBy: .equal, toItem: self.animationContentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        let topConstraint = NSLayoutConstraint(item: lotView, attribute: .top, relatedBy: .equal, toItem: self.animationContentView, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        let bottomConstraint = NSLayoutConstraint(item: lotView, attribute: .bottom, relatedBy: .equal, toItem: self.animationContentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
                
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
        return lotView
    }

}
