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

    private var animalImageView: BackgroundAnimalImageView
    private var moonImageView: BackgroundMoonImageView

    let nightLightId: Int

    private var stackView: UIStackView!

    private lazy var controlPanel = UIView()
    private var slider: SliderControl?
    private var slider2: SliderControl?

    init(nightLight: NightLight, clipped: Bool = true) {
        nightLightId = nightLight.identifier
        animalImageView = BackgroundAnimalImageView(nightLight: nightLight)
        moonImageView = BackgroundMoonImageView(nightLight: nightLight)
        super.init(frame: .zero)

        clipsToBounds = clipped
        setupView(nightLight)
        setupStackViews(nightLight)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if frame.height > frame.width {
            animalImageView.size = frame.width
            moonImageView.size = frame.width*0.9
            moonImageView.transform = .init(translationX: 0, y: -44)
        } else {
            animalImageView.size = frame.height
            moonImageView.size = frame.height
        }

        slider?.setValue(UIScreen.main.brightness)
        slider2?.setValue(1)
    }

    fileprivate func setupView(_ nightLight: NightLight) {
        layer.cornerRadius = 10
        backgroundColor = nightLight.color
    }

    fileprivate func setupStackViews(_ nightLight: NightLight) {
        let topStackView = CustomStackView(arrangedSubviews: [NightLightTitleLabel(key: nightLight.title), NightLightDescriptionLabel(key: nightLight.description), UIView()], axis: .vertical)
        topStackView.alignment = nightLight.identifier.isMultiple(of: 2) ? .trailing : .leading

        let playView = nightLight.identifier.isMultiple(of: 2) ? [UIView(), PlayView(color: nightLight.color)] : [PlayView(color: nightLight.color), UIView()]
        let playStackView = CustomStackView(arrangedSubviews: playView)
        playStackView.alignment = .center

        stackView = CustomStackView(arrangedSubviews: [topStackView, playStackView], axis: .vertical, distribution: .fillEqually)

        addSubview(animalImageView)
        addSubview(moonImageView)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 8, right: 16))
    }

    func handleFullscreen() {
        setupControlPanel()
        //stackView.insertArrangedSubview(controlView, at: 1)
        stackView.distribution = .fill
        stackView.arrangedSubviews.last?.alpha = 0
    }

    func handleClose() {
        stackView.distribution = .fillEqually

        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseOut, animations: {
            self.stackView.arrangedSubviews[1].alpha = 0
            self.stackView.arrangedSubviews.last?.alpha = 1
            self.moonImageView.transform = .identity
        }, completion: { (_) in
            //self.stackView.removeArrangedSubview(self.controlView)
        })
    }

    func setupControlPanel() {

        slider = SliderControl(minValue: 0, maxValue: 1)
        slider2 = SliderControl(minValue: 0, maxValue: 1)

        guard let slider = slider, let slider2 = slider2 else {
            return
        }

        addSubview(controlPanel)
        controlPanel.centerInSuperview()
        controlPanel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        controlPanel.addSubview(slider)

        slider.setImages(images: Data.brightnessSlider.images, minImage: nil)
        slider2.setImages(images: Data.brightnessSlider.images, minImage: nil)

        //view.addSubview(slider)

        //slider.anchor(top: controlPanel.topAnchor, leading: controlPanel.leadingAnchor, bottom: controlPanel.bottomAnchor, trailing: controlPanel.trailingAnchor)
        slider.constrainHeight(constant: 44)
        slider2.constrainHeight(constant: 44)

        let stackView = CustomStackView(arrangedSubviews: [UIView(), slider, slider2], axis: .vertical, spacing: 16, distribution: .fill)
        controlPanel.addSubview(stackView)
        stackView.fillSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
