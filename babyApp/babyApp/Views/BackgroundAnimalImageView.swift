//
//  UIImageView.swift
//  babyApp
//
//  Created by Christophe Hoste on 16.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class BackgroundAnimalImageView: UIImageView {

    private var identifier: Int
    private var imageHeight: NSLayoutConstraint!
    private var imageWidth: NSLayoutConstraint!

    var size: CGFloat = 0 {
        didSet {
            imageHeight.constant = size
            imageWidth.constant = size
        }
    }

    init(nightLight: NightLight) {
        identifier = nightLight.identifier
        super.init(frame: .zero)
        commitInit(nightLight)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if identifier.isMultiple(of: 2) {
            self.anchor(top: nil, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: nil)
        } else {
            self.anchor(top: nil, leading: nil, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
        }
    }

    private func commitInit(_ nightLight: NightLight) {
        setupView(nightLight.image)
    }

    private func setupView(_ image: UIImage) {
        self.image = image
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false

        imageWidth = widthAnchor.constraint(equalToConstant: size)
        imageWidth.isActive = true
        imageHeight = heightAnchor.constraint(equalToConstant: size)
        imageHeight.isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
