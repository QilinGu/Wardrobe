//
//  Color.swift
//  Box8
//
//  Created by Vinita Miranda on 8/16/15.
//  Copyright (c) 2015 Box8. All rights reserved.
//

import Foundation
import UIKit
extension UIColor
{
    convenience init(r: Int, g:Int , b:Int , a: Double) {
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(a))
    }

    class func getBlueBackgroundForShirt() -> UIColor
    {
        return UIColor(r: 181, g: 215, b: 214, a: 1)
    }

    class func navigationBarColor() -> UIColor
    {
        return UIColor(r: 238, g: 238, b: 238, a: 1)
    }

}