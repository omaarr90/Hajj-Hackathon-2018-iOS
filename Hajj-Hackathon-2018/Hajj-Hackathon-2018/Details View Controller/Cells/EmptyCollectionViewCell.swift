//
//  EmptyCollectionViewCell.swift
//  OneWallet
//
//  Created by Omar Alshammari on 18/02/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class EmptyCollectionViewCell: DetailsBaseCollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.seperatorView.backgroundColor = .clear
    }

}
