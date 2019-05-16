//
//  Data.swift
//  babyApp
//
//  Created by Christophe Hoste on 14.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

struct Data {
    // Staubsauger, Spühlmaschine/Waschmaschine, Dusche, Auto, Spühlen
    public static let quickSounds1 = [QuickSound(identifier: 1), QuickSound(identifier: 2)]
    public static let quickSounds2 = [QuickSound(identifier: 3), QuickSound(identifier: 4)]
    public static let nightLight = [
        NightLight(identifier: 1, title: .nightLightTitle1, description: .nightLightDescription1, color: CustomColor.nightLightSmallView2, image: #imageLiteral(resourceName: "pinguin"), nightLightColors: [CustomColor.nightLightSmallView2, .orange, .yellow, .green, .blue, .purple]),
        NightLight(identifier: 2, title: .nightLightTitle2, description: .nightLightDescription2, color: CustomColor.nightLightSmallView1, image: #imageLiteral(resourceName: "fox"), nightLightColors: [CustomColor.nightLightSmallView1, .orange, .yellow, .green, .blue, .purple])
    ]
}
