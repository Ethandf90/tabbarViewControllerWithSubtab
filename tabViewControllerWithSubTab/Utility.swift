//
//  Utility.swift
//  tabViewControllerWithSubTab
//
//  Created by Fei Dong on 2017-06-09.
//  Copyright © 2017 Ethan Dong. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    static func frameFromPercentage(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
        return CGRect(x: relativeX(x),
                      y: relativeY(y),
                      width: relativeX(width),
                      height: relativeY(height))
    }
    
    // MARK: internal
    private static func relativeX(_ relativeX: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.width * relativeX
    }
    private static func relativeY(_ relativeY: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height * relativeY
    }
    
}
