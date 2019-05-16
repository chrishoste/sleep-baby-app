//
//  NightLightSmallView.swift
//  babyApp
//
//  Created by Christophe Hoste on 13.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class NightLightView: UIView {

    let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var imageHeight: NSLayoutConstraint!
    var imageWidth: NSLayoutConstraint!

    let nightLightId: Int

    var stackView: UIStackView!

    let controlView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.alpha = 0
        return view
    }()

    init(nightLight: NightLight, controlView: Bool = false) {
        nightLightId = nightLight.identifier
        super.init(frame: .zero)

        setupView(nightLight)
        setupImage(nightLight)
        setupStackViews(nightLight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if frame.height > frame.width {
            constraintImageView(width: frame.width)
        } else {
            constraintImageView(width: frame.height)
        }
    }

    fileprivate func setupView(_ nightLight: NightLight) {
        clipsToBounds = true
        layer.cornerRadius = 10
        backgroundColor = nightLight.color
    }

    fileprivate func setupImage(_ nightLight: NightLight) {
        animalImageView.image = nightLight.image
    }

    fileprivate func setupStackViews(_ nightLight: NightLight) {
        let topStackView = CustomStackView(arrangedSubviews: [NightLightTitleLabel(key: nightLight.title), NightLightDescriptionLabel(key: nightLight.description), UIView()], axis: .vertical)
        topStackView.alignment = nightLight.identifier.isMultiple(of: 2) ? .trailing : .leading

        let playView = nightLight.identifier.isMultiple(of: 2) ? [UIView(), PlayView(color: nightLight.color)] : [PlayView(color: nightLight.color), UIView()]
        let playStackView = CustomStackView(arrangedSubviews: playView)
        playStackView.alignment = .center

        stackView = CustomStackView(arrangedSubviews: [topStackView, playStackView], axis: .vertical, distribution: .fillEqually)

        addSubview(animalImageView)
        imageWidth = animalImageView.widthAnchor.constraint(equalToConstant: 0)
        imageWidth.isActive = true
        imageHeight = animalImageView.heightAnchor.constraint(equalToConstant: 0)
        imageHeight.isActive = true
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 8, right: 16))

        constraintImageView(width: frame.height)
    }

    fileprivate func constraintImageView(width: CGFloat) {
        imageHeight.constant = width
        imageWidth.constant = width

        if nightLightId.isMultiple(of: 2) {
            animalImageView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil)
        } else {
            animalImageView.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor)
        }
    }

    func handleFullscreen() {
        stackView.insertArrangedSubview(controlView, at: 1)
        stackView.distribution = .fill
        stackView.arrangedSubviews.last?.alpha = 0
    }

    func handleClose() {
        stackView.distribution = .fillEqually

        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            self.stackView.arrangedSubviews[1].alpha = 0
            self.stackView.arrangedSubviews.last?.alpha = 1
        }, completion: { (_) in
            self.stackView.removeArrangedSubview(self.controlView)
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
