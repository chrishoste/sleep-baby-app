//
//  UILabel.swift
//  babyApp
//
//  Created by Christophe Hoste on 06.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

class SubLabel: UILabel {

	init(text: String) {
		super.init(frame: .zero)
		self.text = text
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class TitleLabel: UILabel {

	init(text: String) {
		super.init(frame: .zero)
		self.text = text
		self.textAlignment = .center
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
