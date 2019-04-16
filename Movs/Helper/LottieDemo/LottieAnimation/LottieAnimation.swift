//
//  LottieAnimationVisibility.swift
//  Movs
//
//  Created by BRQ on 10/04/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit
import Lottie

protocol LottieAnimationVisibility {
    func setupAnimation(animationMode: String, view: LOTAnimationView)
}

extension LottieAnimationVisibility {
    
    func setupAnimation(animationMode: String, view: LOTAnimationView) {
        view.isHidden = false
        view.setAnimation(named: animationMode)
        view.play()
        view.loopAnimation = true
    }
    
}
