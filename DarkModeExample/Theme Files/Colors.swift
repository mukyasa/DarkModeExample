//
//  Colors.swift
//  DarkModeExample
//
//  Created by mukesh on 1/5/20.
//  Copyright © 2020 mandy. All rights reserved.
//

import UIKit

extension UIColor {
    @Theme(light: UIColor.white,
           dark: UIColor.safeSystemBackground)
    static var background: UIColor

    @Theme(light: UIColor(hex: "333333"),
           dark: UIColor.safeLabel)
    static var primaryText: UIColor

    @Theme(light: UIColor(hex: "EEEFF2"),
           dark: UIColor.safeSeperator)
    static var seperator: UIColor
    
    @Theme(light: UIColor(hex: "1F82FB"),
           dark: UIColor(hex: "7C7FED"))
    static var navBar: UIColor
    
}

// MARK: - BackPort iOS 13 and older Colors

extension UIColor {
    static var safeSystemBackground: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .black
        }
    }

    static var safeLabel: UIColor {
        if #available(iOS 13, *) {
            return .label
        } else {
            return .white
        }
    }

    static var safeSeperator: UIColor {
        if #available(iOS 13, *) {
            return .separator
        } else {
            return UIColor.gray.withAlphaComponent(0.6)
        }
    }
}
