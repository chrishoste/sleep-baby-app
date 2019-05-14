//
//  NightLightSmallView.swift
//  babyApp
//
//  Created by Christophe Hoste on 13.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class NightLightSmallView: UIView {

    let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let melodyId: Int

    init(melody: MelodySound) {
        melodyId = melody.identifier
        super.init(frame: .zero)

        setupView(melody)
        setupImage(melody)
        setupStackViews(melody)
    }

    fileprivate func setupView(_ melody: MelodySound) {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = melody.color
    }

    fileprivate func setupImage(_ melody: MelodySound) {
        animalImageView.image = melody.image
    }

    fileprivate func setupStackViews(_ melody: MelodySound) {
        let topStackView = CustomStackView(arrangedSubviews: [NightLightTitleLabel(key: melody.title), NightLightDescriptionLabel(key: melody.description), UIView()], axis: .vertical)
        topStackView.alignment = melody.identifier.isMultiple(of: 2) ? .trailing : .leading

        let playView = melody.identifier.isMultiple(of: 2) ? [UIView(), PlayView(color: melody.color)] : [PlayView(color: melody.color), UIView()]
        let playStackView = CustomStackView(arrangedSubviews: playView)
        playStackView.alignment = .center

        let stackView = CustomStackView(arrangedSubviews: [topStackView, playStackView], axis: .vertical, distribution: .fillEqually)

        addSubview(animalImageView)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 8, right: 16))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        animalImageView.constrainWidth(constant: frame.height)

        if melodyId.isMultiple(of: 2) {
            animalImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil)
        } else {
            animalImageView.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
