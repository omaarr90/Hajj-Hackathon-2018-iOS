//
//  FoodItemCollectionViewCell.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class FoodItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imageView.layer.cornerRadius = 80
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 5.0
        
        self.titleLabel.textColor = UIColor.hajjTextColor
        self.weightLabel.textColor = UIColor.hajjTextColor
        self.caloriesLabel.textColor = UIColor.hajjTextColor

    }

}
