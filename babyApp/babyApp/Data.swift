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
    public static let quickSounds1 = [QuickSound(identifier: 1, title: .titleBabyApp, color: CustomColor.quickSoundBackgroundBlue, image: #imageLiteral(resourceName: "car")), QuickSound(identifier: 2, title: .titleBabyApp, color: CustomColor.quickSoundBackgroundBlue, image: #imageLiteral(resourceName: "microwave"))]
    public static let quickSounds2 = [QuickSound(identifier: 3, title: .titleBabyApp, color: CustomColor.quickSoundBackgroundBlue, image: #imageLiteral(resourceName: "washer")), QuickSound(identifier: 4, title: .titleBabyApp, color: CustomColor.quickSoundBackgroundBlue, image: #imageLiteral(resourceName: "shower"))]
    public static let nightLight = [
        NightLight(identifier: 1, title: .nightLightTitle1, description: .nightLightDescription1, color: CustomColor.nightLightSmallView2, image: #imageLiteral(resourceName: "pinguin"), nightLightColors: [CustomColor.nightLightSmallView2, .orange, .yellow, .green, .blue, .purple]),
        NightLight(identifier: 2, title: .nightLightTitle2, description: .nightLightDescription2, color: CustomColor.nightLightSmallView1, image: #imageLiteral(resourceName: "fox"), nightLightColors: [CustomColor.nightLightSmallView1, .orange, .yellow, .green, .blue, .purple])
    ]

    public static let volumeSlider = SliderModel(identifier: 1, title: .sliderVolume, minValue: 0, maxValue: 1, images: [#imageLiteral(resourceName: "soundLow"), #imageLiteral(resourceName: "soundHigh"), #imageLiteral(resourceName: "soundMax")], minImage: #imageLiteral(resourceName: "soundOut"))
    public static let brightnessSlider = SliderModel(identifier: 2, title: .sliderBrightness, minValue: 0, maxValue: 1, images: [#imageLiteral(resourceName: "limMin"), #imageLiteral(resourceName: "limLow"), #imageLiteral(resourceName: "limMid"), #imageLiteral(resourceName: "limHigh"), #imageLiteral(resourceName: "limMax")], minImage: nil)
}
