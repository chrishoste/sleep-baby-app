//
//  ThumbSlidingView.swift
//  babyApp
//
//  Created by Christophe Hoste on 07.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class ThumbSlidingView: UIView {

    override var intrinsicContentSize: CGSize {
        return .init(width: 40, height: 6)
    }

    init() {
        super.init(frame: .zero)
        commitInit()
    }

    private func commitInit() {
        setupView()
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 3
        backgroundColor = UIColor(white: 0, alpha: 0.2)
        clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
