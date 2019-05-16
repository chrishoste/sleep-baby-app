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

    let view1: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.alpha = 0.5
        return view
    }()
    let viewclear: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.alpha = 0.5
        return view
    }()

    let view2: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.constrainHeight(constant: 44)
        view.constrainWidth(constant: 44)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray

        let stackView = CustomStackView(arrangedSubviews: [viewclear, Slider(), view1], axis: .vertical, distribution: .fillEqually)
        view.addSubview(stackView)
        stackView.backgroundColor = .purple
        stackView.centerYInSuperview()
        stackView.constrainHeight(constant: view.frame.width)
        stackView.constrainWidth(constant: view.frame.width)
    }
}
