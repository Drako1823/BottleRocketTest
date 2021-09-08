//
//  UIColorExtension.swift
//  testBottleRocket
//
//  Created by roreyesl on 08/09/21.
//

import UIKit

extension UIColor {
    
    //MARK: - Functions
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
