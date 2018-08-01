//
//  DetailsBaseCollectionViewCell.swift
//  OneWallet
//
//  Created by Omar Alshammari on 17/02/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class DetailsBaseCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var seperatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.seperatorView.backgroundColor = .lightGray
    }
}
