//
//  PerosnCollectionViewCell.swift
//  OneWallet
//
//  Created by Omar Alshammari on 18/02/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class PerosnCollectionViewCell: DetailsBaseCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.textColor = .black
    }

}
