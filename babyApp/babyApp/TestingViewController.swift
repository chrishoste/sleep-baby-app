//
//  TestingViewController.swift
//  babyApp
//
//  Created by Christophe Hoste on 16.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class TestingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let slider = SliderControl(minValue: 0, maxValue: 1)
        slider.setImages(images: Data.brightnessSlider.images, minImage: nil)
        slider.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)

        view.addSubview(slider)
        slider.centerInSuperview()

        slider.constrainWidth(constant: view.frame.width)
        slider.constrainHeight(constant: 44)

        slider.setValue(UIScreen.main.brightness)
    }

    @objc
    func handleValueChanged(_ slider: SliderControl) {
        print(slider.getValue())
        UIScreen.main.brightness = slider.getValue()
    }
}
