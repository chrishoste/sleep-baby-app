//
//  Data.swift
//  babyApp
//
//  Created by Christophe Hoste on 14.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

struct MelodySound {
    let identifier: Int
    let title: LocalizationKey
    let description: LocalizationKey
    let color: UIColor
    let image: UIImage
    let colors: [UIColor]
}

struct QuickSound {
    let identifier: Int
}

struct Data {
    // Staubsauger, Spühlmaschine/Waschmaschine, Dusche, Auto, Spühlen
    public static let quickSounds1 = [QuickSound(identifier: 1), QuickSound(identifier: 2)]
    public static let quickSounds2 = [QuickSound(identifier: 3), QuickSound(identifier: 4)]
    public static let melodySounds = [
        MelodySound(identifier: 0, title: .nightLightTitle1, description: .nightLightDescription1, color: CustomColor.nightLightSmallView2, image: #imageLiteral(resourceName: "pinguin"), colors: [CustomColor.nightLightSmallView2, .orange, .yellow, .green, .blue, .purple]),
        MelodySound(identifier: 1, title: .nightLightTitle2, description: .nightLightDescription2, color: CustomColor.nightLightSmallView1, image: #imageLiteral(resourceName: "fox"), colors: [CustomColor.nightLightSmallView1, .orange, .yellow, .green, .blue, .purple])
    ]
}
