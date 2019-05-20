//
//  SliderModel.swift
//  babyApp
//
//  Created by Christophe Hoste on 20.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

struct SliderModel {
    let identifier: Int
    let title: LocalizationKey
    let minValue: CGFloat
    let maxValue: CGFloat
    let images: [UIImage]?
    let minImage: UIImage?
}
