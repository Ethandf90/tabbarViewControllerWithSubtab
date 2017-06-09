//
//  UIImage+Extension.swift
//  tabViewControllerWithSubTab
//
//  Created by Fei Dong on 2017-06-09.
//  Copyright © 2017 Ethan Dong. All rights reserved.
//

import Foundation
import UIKit

typealias Asset = UIImage.Asset

//usage: Asset.launchImage.image  -> UIImage

extension UIImage {
    enum Asset : String {
        case first = "first"
        case second = "second"
        
        var image: UIImage {
            return UIImage(asset: self)
        }
    }
    
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
