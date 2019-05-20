//
//  KnobView.swift
//  babyApp
//
//  Created by Christophe Hoste on 20.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class KnobView: UIView {

    private var vibrate = false

    var images: [UIImage]?
    var minImage: UIImage?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()

    init() {
        super.init(frame: .zero)
        commitInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }

    private func commitInit() {
        backgroundColor = CustomColor.sliderKnob
        clipsToBounds = true
        setupImageView()
    }

    private func setupImageView() {
        addSubview(imageView)
        imageView.fillSuperview()
    }

    func setImage(forValue value: CGFloat) {
        if value <= 0 {
            guard let minImage = minImage else {
                return
            }
            triggerVibration()
            imageView.image = minImage
            return
        }

        guard let images = images else {
            return
        }

        if value >= 1 {
            triggerVibration()
            imageView.image = images[images.count - 1]
            return
        }

        let range = 1.0 / CGFloat(images.count)

        for index in 1...images.count {
            if value <= range * (CGFloat(index)) {
                imageView.image = images[index - 1]
                vibrate = true
                return
            }
        }
    }

    private func triggerVibration() {
        if vibrate {
            vibrate = false
            Vibrations.light()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
