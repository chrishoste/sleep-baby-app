//
//  UIStackView.swift
//  babyApp
//
//  Created by Christophe Hoste on 06.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class CustomStackView: UIStackView {

	init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill) {
			super.init(frame: .zero)

			arrangedSubviews.forEach({addArrangedSubview($0)})

			self.spacing = spacing
			self.distribution = distribution
			self.axis = axis
		}

		required init(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

}
