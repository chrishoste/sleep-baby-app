//
//  SliderControl.swift
//  babyApp
//
//  Created by Christophe Hoste on 16.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class SliderControl: UIControl {

    var trackWidth: NSLayoutConstraint?
    var minimumValue: CGFloat
    var maximumValue: CGFloat
    private var value: CGFloat = 5 {
        didSet {
            updateSlider()
        }
    }

    let coloredTrackView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.sliderTrackBlue
        return view
    }()

    let trackView: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.sliderTrackBar
        return view
    }()

    let knobView = KnobView()

    init(minValue: CGFloat, maxValue: CGFloat) {
        minimumValue = minValue
        maximumValue = maxValue
        super.init(frame: .zero)
        commitInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commitInit() {
        trackView.addSubview(coloredTrackView)
        trackView.addSubview(knobView)
        coloredTrackView.anchor(top: trackView.topAnchor, leading: trackView.leadingAnchor, bottom: trackView.bottomAnchor, trailing: nil)

        addSubview(trackView)

        //trackView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 64, bottom: 0, right: 64))
        trackWidth = trackView.widthAnchor.constraint(equalToConstant: 0)
        trackWidth?.isActive = true
        trackView.centerInSuperview()

        trackView.isUserInteractionEnabled = false

        layoutIfNeeded()
        knobView.constrainWidth(constant: 44)
        knobView.constrainHeight(constant: 44)

        trackView.constrainHeight(constant: 44*0.55)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if frame.width > 128 {
            trackWidth?.constant = frame.width - 128
        } else {
            trackWidth?.constant = frame.width
        }

        trackView.layer.cornerRadius = (frame.height*0.55)/5
        coloredTrackView.layer.cornerRadius = trackView.layer.cornerRadius
    }

    func updateSlider() {
        let xPoint = position(for: value)
        knobView.center = .init(x: xPoint, y: trackView.bounds.height / 2)
        coloredTrackView.frame.size.width = xPoint
    }

    func position(for value: CGFloat) -> CGFloat {
        layoutIfNeeded()
        let newX = (value - minimumValue) / (maximumValue - minimumValue)
        knobView.setImage(forValue: boundValue(newX, toLowerValue: 0, upperValue: 1))
        return trackView.bounds.width * boundValue(newX, toLowerValue: 0, upperValue: 1)
    }

    func setImages(images: [UIImage]?, minImage: UIImage?) {
        knobView.images = images
        knobView.minImage = minImage
    }

    func setValue(_ value: CGFloat) {
        self.value = boundValue(value, toLowerValue: minimumValue, upperValue: maximumValue)
    }

    func getValue() -> CGFloat {
        return boundValue(value, toLowerValue: minimumValue, upperValue: maximumValue)
    }
}

extension SliderControl {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // Start something
        return true
    }

    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: trackView).x
        let deltaValue = (maximumValue - minimumValue) * location / trackView.bounds.width

        value = deltaValue

        sendActions(for: .valueChanged)
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        // End something
    }

    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat, upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
}
