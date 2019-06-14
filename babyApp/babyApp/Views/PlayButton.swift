//
//  PlayButton.swift
//  babyApp
//
//  Created by Christophe Hoste on 27.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class PlayButton: UIView {

    private var height: NSLayoutConstraint?
    private var width: NSLayoutConstraint?
    private var imageView: UIImageView?

    var color: UIColor = .white {
        didSet {
            setColor()
        }
    }

    var size: CGFloat = 0 {
        didSet {
            setConstraint()
        }
    }

    init() {
        super.init(frame: .zero)
        commitInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
    }

    private func commitInit() {
        setupView()
        setupSubviews()
    }

    private func setupView() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        height = heightAnchor.constraint(equalToConstant: 0)
        height?.isActive = true
        width = widthAnchor.constraint(equalToConstant: 0)
        width?.isActive = true
    }

    private func setupSubviews() {
        imageView = UIImageView()

        guard let imageView = imageView else {
            return
        }

        imageView.image = #imageLiteral(resourceName: "play").withAlignmentRectInsets(.init(top: 0, left: -2, bottom: 0, right: 0))
        imageView.contentMode = .center

        addSubview(imageView)
        imageView.fillSuperview()
    }

    private func setConstraint() {
        width?.constant = size
        height?.constant = size
    }

    private func setColor() {
        imageView?.tintColor = color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
