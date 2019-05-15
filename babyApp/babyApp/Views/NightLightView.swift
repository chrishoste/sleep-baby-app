//
//  NightLightSmallView.swift
//  babyApp
//
//  Created by Christophe Hoste on 13.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class NightLightView: UIView {

    let animalImageView = UIImageView()
    let nightLightId: Int

    init(nightLight: NightLight) {
        nightLightId = nightLight.identifier
        super.init(frame: .zero)

        setupView(nightLight)
        setupImage(nightLight)
        setupStackViews(nightLight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        constraintImageView()
    }

    fileprivate func setupView(_ nightLight: NightLight) {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = nightLight.color
    }

    fileprivate func setupImage(_ nightLight: NightLight) {
        animalImageView.image = nightLight.image
        animalImageView.contentMode = .scaleAspectFill
    }

    fileprivate func setupStackViews(_ nightLight: NightLight) {
        let topStackView = CustomStackView(arrangedSubviews: [NightLightTitleLabel(key: nightLight.title), NightLightDescriptionLabel(key: nightLight.description), UIView()], axis: .vertical)
        topStackView.alignment = nightLight.identifier.isMultiple(of: 2) ? .trailing : .leading

        let playView = nightLight.identifier.isMultiple(of: 2) ? [UIView(), PlayView(color: nightLight.color)] : [PlayView(color: nightLight.color), UIView()]
        let playStackView = CustomStackView(arrangedSubviews: playView)
        playStackView.alignment = .center

        let stackView = CustomStackView(arrangedSubviews: [topStackView, playStackView], axis: .vertical, distribution: .fillEqually)

        addSubview(animalImageView)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 8, right: 16))
    }

    fileprivate func constraintImageView() {
        animalImageView.constrainWidth(constant: frame.height)

        if nightLightId.isMultiple(of: 2) {
            animalImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil)
        } else {
            animalImageView.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
