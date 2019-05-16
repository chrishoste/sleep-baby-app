//
//  Slider.swift
//  babyApp
//
//  Created by Christophe Hoste on 16.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class Slider: UIView {

    let sliderBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()

    let coloredInnerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    let thumbView: UIView = {
        let view = UIView()
        view.backgroundColor = .green

        view.translatesAutoresizingMaskIntoConstraints = false
        view.constrainWidth(constant: 64)
        view.constrainHeight(constant: 64)
        return view
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        sliderBackgroundView.clipsToBounds = true

        sliderBackgroundView.addSubview(coloredInnerView)

        coloredInnerView.anchor(top: sliderBackgroundView.topAnchor, leading: sliderBackgroundView.leadingAnchor, bottom: sliderBackgroundView.bottomAnchor, trailing: nil)

        addSubview(sliderBackgroundView)
        sliderBackgroundView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        sliderBackgroundView.constrainHeight(constant: 64*0.7)
        sliderBackgroundView.centerInSuperview()

        addSubview(thumbView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        sliderBackgroundView.layer.cornerRadius = 5
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        thumbView.center = sliderBackgroundView.center

        coloredInnerView.constrainWidth(constant: sliderBackgroundView.frame.width/2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
