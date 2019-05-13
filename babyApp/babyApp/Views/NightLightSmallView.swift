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
        label.text = "Night light with some blue accents"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "pinguin")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        backgroundColor = CustomColor.nightLightSmallView1
        clipsToBounds = true

        let topStackView = CustomStackView(arrangedSubviews: [titleLabel, descriptionLabel, UIView()], axis: .vertical)
        let playStackView = CustomStackView(arrangedSubviews: [PlayView(), UIView()])
        playStackView.alignment = .center

        let stackView = CustomStackView(arrangedSubviews: [topStackView, playStackView], axis: .vertical, distribution: .fillEqually)

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 8, right: 8))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
