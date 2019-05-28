//
//  Vibrations.swift
//  babyApp
//
//  Created by Christophe Hoste on 20.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

struct Vibrations {

    static func light() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
