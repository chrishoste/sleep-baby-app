//
//  QuickSoundView.swift
//  babyApp
//
//  Created by Christophe Hoste on 26.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class QuickSoundView: UIView {

    let playButton = PlayButton()

    init(quickSound: QuickSound) {
        super.init(frame: .zero)
        commitInit(quickSound)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playButton.size = frame.height*0.25
    }

    private func commitInit(_ quickSound: QuickSound) {
        setupView(quickSound)
        setupSubviews(quickSound)
    }

    private func setupView(_ quickSound: QuickSound) {
        clipsToBounds = true
        backgroundColor = quickSound.color
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = quickSound.color.cgColor
    }

    private func setupSubviews(_ quickSound: QuickSound) {

        let bottomView = UIView()
        bottomView.backgroundColor = .white

        let quickSoundTitle: UILabel = {
            let label = UILabel()
            label.text = localized(.quickSoundWashingMachine)
            label.textColor = quickSound.color
            label.adjustsFontSizeToFitWidth = true
            label.numberOfLines = 0
            return label
        }()

        playButton.color = quickSound.color

        let stackView = UIStackView(arrangedSubviews: [playButton, quickSoundTitle])
        stackView.spacing = 8

        bottomView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))

        addSubview(bottomView)
        bottomView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
