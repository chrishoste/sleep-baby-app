//
//  PlayView.swift
//  babyApp
//
//  Created by Christophe Hoste on 13.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class PlayView: UIView {

    let playLabel: UILabel = {
        let label = UILabel()
        label.text = "Play"
        label.textColor = CustomColor.nightLightSmallView1
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    let playImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "play")
        imageView.contentMode = .center
        imageView.tintColor = CustomColor.nightLightSmallView1
        imageView.constrainWidth(constant: 20)
        return imageView
    }()

    init() {
        super.init(frame: .zero)

        backgroundColor = .white
        layer.cornerRadius = 15

        constrainWidth(constant: 90)
        constrainHeight(constant: 30)

        let stackView = CustomStackView(arrangedSubviews: [playImageView, playLabel], spacing: 8)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 4, left: 8, bottom: 4, right: 4))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
