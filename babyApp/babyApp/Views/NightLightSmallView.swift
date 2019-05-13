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

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Melody 1"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Night light chilly colors"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let melodyId: Int

    init(melody: MelodySound) {
        melodyId = melody.identifier
        super.init(frame: .zero)

        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = melody.color

        titleLabel.text = melody.title
        descriptionLabel.text = melody.description
        animalImageView.image = melody.image

        let topStackView = CustomStackView(arrangedSubviews: [titleLabel, descriptionLabel, UIView()], axis: .vertical)
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
        animalImageView.constrainHeight(constant: frame.height)

        if melodyId.isMultiple(of: 2) {
            animalImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil)
        } else {
            animalImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: trailingAnchor)
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
