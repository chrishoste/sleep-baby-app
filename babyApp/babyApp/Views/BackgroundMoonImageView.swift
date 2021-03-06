//
//  BackgroundMoonImageView.swift
//  babyApp
//
//  Created by Christophe Hoste on 16.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class BackgroundMoonImageView: UIImageView {

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
        commitInit()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if identifier.isMultiple(of: 2) {
            self.anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: nil, trailing: nil)
        } else {
            self.anchor(top: superview?.topAnchor, leading: nil, bottom: nil, trailing: superview?.trailingAnchor)
        }
    }

    private func commitInit() {
        setupView()
    }

    private func setupView() {
        image = identifier.isMultiple(of: 2) ? #imageLiteral(resourceName: "moonL") : #imageLiteral(resourceName: "moonR")
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
