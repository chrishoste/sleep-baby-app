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

        let slider = SliderControl()
        slider.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)

        view.addSubview(slider)
        slider.centerInSuperview()

        slider.constrainWidth(constant: view.frame.width)
        slider.constrainHeight(constant: 44)

        slider.setValue(0.5)
    }

    @objc
    func handleValueChanged(_ slider: SliderControl) {
        print(slider.getValue())
    }
}
