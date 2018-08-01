//
//  LabelCollectionViewCell.swift
//  CollectionViewDemoApp
//
//  Created by عمر سعيد الشمري on 10/11/1439 AH.
//  Copyright © 1439 Omar Alshammari. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: DetailsBaseCollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.subtitleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        self.titleLabel.textColor = UIColor.darkText
    }

}
