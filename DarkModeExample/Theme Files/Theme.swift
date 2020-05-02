//
//  Theme.swift
//  DarkModeExample
//
//  Created by mukesh on 1/5/20.
//  Copyright © 2020 mandy. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    func addThemeChangeObserver()
    func configureSubviewsColors()
}

extension ThemeProtocol  {
    func addThemeChangeObserver() {
        if #available(iOS 13, *) {
        } else {
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "themeChange"),
                                                   object: nil,
                                                   queue: OperationQueue.main) { _ in
                self.configureSubviewsColors()
            }
        }
    }

}

@propertyWrapper
struct Theme {
    let light: UIColor
    let dark: UIColor

    var wrappedValue: UIColor {
        if #available(iOS 13, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                if traitCollection.userInterfaceStyle == .dark {
                    return self.dark
                } else {
                    return self.light
                }
            }
        } else {
            return ThemeManager.isDarkModeEnabled ? self.dark : self.light
        }
    }
}

enum ThemeManager {
    static var isDarkModeEnabled = false
}
