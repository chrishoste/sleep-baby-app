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

    let controlPanel = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let slider = SliderControl(minValue: 0, maxValue: 1)
        let slider2 = SliderControl(minValue: 0, maxValue: 1)

        view.addSubview(controlPanel)
        controlPanel.centerInSuperview()
        controlPanel.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        controlPanel.addSubview(slider)

        slider.setImages(images: Data.brightnessSlider.images, minImage: nil)
        slider.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)

        slider2.setImages(images: Data.brightnessSlider.images, minImage: nil)

        //view.addSubview(slider)

        //slider.anchor(top: controlPanel.topAnchor, leading: controlPanel.leadingAnchor, bottom: controlPanel.bottomAnchor, trailing: controlPanel.trailingAnchor)
        slider.constrainHeight(constant: 44)
        slider2.constrainHeight(constant: 44)

        let stackView = CustomStackView(arrangedSubviews: [UIView(), slider, slider2], axis: .vertical, spacing: 16, distribution: .fill)
        controlPanel.addSubview(stackView)
        stackView.fillSuperview()

        slider.setValue(UIScreen.main.brightness)
        slider2.setValue(1)
    }

    @objc
    func handleValueChanged(_ slider: SliderControl) {
        print(slider.getValue())
        UIScreen.main.brightness = slider.getValue()
    }
}
