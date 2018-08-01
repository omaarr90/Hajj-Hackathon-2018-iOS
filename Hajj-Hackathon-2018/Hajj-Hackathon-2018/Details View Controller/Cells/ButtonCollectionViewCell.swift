//
//  ButtonCollectionViewCell.swift
//  OneWallet
//
//  Created by Omar Alshammari on 17/02/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

class ButtonCollectionViewCell: DetailsBaseCollectionViewCell {

    @IBOutlet weak var button: UIButton!
    var handler: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.seperatorView.backgroundColor = .clear
        self.button.layer.cornerRadius = 0.5
        self.button.clipsToBounds = true
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        self.handler?()
    }
}
