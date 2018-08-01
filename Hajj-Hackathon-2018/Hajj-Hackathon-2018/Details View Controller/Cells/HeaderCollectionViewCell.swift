//
//  HeaderCollectionViewCell.swift
//  CollectionViewDemoApp
//
//  Created by Omar Alshammari on 10/11/1439 AH.
//  Copyright © 1439 Omar Alshammari. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: DetailsBaseCollectionViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.headerLabel.textColor = .black
        self.headerLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        self.seperatorView.backgroundColor = .black
    }

}
