//
//  FoodItemCollectionViewCell.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 01/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class FoodItemCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = .orange
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.clipsToBounds = true
    }

}
