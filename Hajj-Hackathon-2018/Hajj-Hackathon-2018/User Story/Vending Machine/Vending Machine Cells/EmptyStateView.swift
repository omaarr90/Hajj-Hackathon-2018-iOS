//
//  EmptyStateView.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 03/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit
import StatefulViewController

class EmptyStateView: UIImageView, StatefulPlaceholderView {
    func placeholderViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
    }

}
