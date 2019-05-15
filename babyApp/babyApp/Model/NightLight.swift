//
//  NightLight.swift
//  babyApp
//
//  Created by Christophe Hoste on 15.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

struct NightLight {
    let identifier: Int
    let title: LocalizationKey
    let description: LocalizationKey
    let color: UIColor
    let image: UIImage
    let nightLightColors: [UIColor]
}
