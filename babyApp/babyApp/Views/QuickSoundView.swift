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

    init(quickSound: QuickSound) {
        super.init(frame: .zero)
        commitInit(quickSound)
    }

    private func commitInit(_ quickSound: QuickSound) {
        setupView(quickSound)
        setupSubviews(quickSound)
    }

    private func setupView(_ quickSound: QuickSound) {
        backgroundColor = quickSound.color
        layer.cornerRadius = 10
    }

    private func setupSubviews(_ quickSound: QuickSound) {
        let imageView = UIImageView()
        imageView.image = quickSound.image
        imageView.contentMode = .scaleAspectFit
        let stackView = CustomStackView(arrangedSubviews: [imageView, UIStackView(arrangedSubviews: [PlayView(color: quickSound.color), UIView()]), UIView()], axis: .vertical, spacing: 8, distribution: .fill)

        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 8, bottom: 8, right: 8))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
