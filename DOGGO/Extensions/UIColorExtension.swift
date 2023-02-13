//
//  UIColorExtension.swift
//  DOGGO
//
//  Created by Lobster on 13.01.23.
//

import Foundation
import UIKit

extension UIColor {
    static let selectedItem = UIColor(red: 252.0 / 255.0,
                                      green: 147.0 / 255.0,
                                      blue: 64.0 / 255.0,
                                      alpha: 1.0)
    
    static let unselectedItem = UIColor.systemGray2
    //    UIColor(red: 245.0 / 255.0,
    //                                        green: 190.0 / 255.0,
    //                                        blue: 39.0 / 255.0,
    //                                        alpha: 0.6)
    
    static let cellsColor = UIColor(red: 244.0 / 255.0,
                                    green: 244.0 / 255.0,
                                    blue: 244.0 / 255.0,
                                    alpha: 1.0)
    
    static let tabBarColor = UIColor(red: 245.0 / 255.0,
                                     green: 245.0 / 255.0,
                                     blue: 245.0 / 255.0,
                                     alpha: 1.0)
    
    static let mainColor = UIColor(red: 240.0 / 255.0,
                                   green: 240.0 / 255.0,
                                   blue: 240.0 / 255.0,
                                   alpha: 1.0)
    
    static func customColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        let color = UIColor(red: red / 255.0,
                            green: green / 255.0,
                            blue: blue / 255.0,
                            alpha: alpha)
        return color
    }
}
