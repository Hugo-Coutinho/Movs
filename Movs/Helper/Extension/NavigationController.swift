//
//  NavigationController.swift
//  Movs
//
//  Created by Hugo Coutinho on 26/07/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationController {
    func mainNavigationBarColorConfiguration() {
        if #available(iOS 13.0, *) {
            let standard = UINavigationBarAppearance()
            standard.configureWithOpaqueBackground()
            standard.backgroundColor = UIColor.themeColor()
            standard.titleTextAttributes = [.foregroundColor: UIColor.black]
            standard.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            self.navigationBar.standardAppearance = standard
            self.navigationBar.scrollEdgeAppearance = standard
            self.navigationBar.tintColor = UIColor.black
            }
    }
}
