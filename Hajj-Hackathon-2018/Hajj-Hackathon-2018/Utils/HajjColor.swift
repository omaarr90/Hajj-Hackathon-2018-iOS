//
//  HajjColor.swift
//  Hajj-Hackathon-2018
//
//  Created by Omar Alshammari on 02/08/2018.
//  Copyright © 2018 Omar Alshammari. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
    
    class var chickenColor: UIColor { get {return UIColor(rgb: 0xdec7a9)}}
    class var vagenColor: UIColor { get {return UIColor(rgb: 0xa6d8de)}}
    class var fishColor: UIColor { get {return UIColor(rgb: 0xa9c6de)}}
    class var meatColor: UIColor { get {return UIColor(rgb: 0xdeb3a9)}}
    class var hajjTintColor: UIColor { get {return UIColor(rgb: 0xdadada)}}
    class var HajjPurbleColor: UIColor { get {return UIColor(rgb: 0x8c03ae)}}
    class var hajjTextColor: UIColor { get {return UIColor(rgb: 0xa1a1a1)}}

    class var warning: UIColor { get {return UIColor(rgb: 0xFF9F68)}}
}


extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
