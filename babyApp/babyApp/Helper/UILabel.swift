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

	init(key: LocalizationKey) {
		super.init(frame: .zero)
		self.text = localized(key)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class TitleLabel: UILabel {

	init(key: LocalizationKey) {
		super.init(frame: .zero)
		self.text = localized(key)
		self.textAlignment = .center
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class NightLightTitleLabel: UILabel {

    init(key: LocalizationKey) {
        super.init(frame: .zero)
        self.text = localized(key)
        self.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.textColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NightLightDescriptionLabel: UILabel {

    init(key: LocalizationKey) {
        super.init(frame: .zero)
        self.text = localized(key)
        self.font = UIFont.systemFont(ofSize: 14, weight: .light)
        self.numberOfLines = 0
        self.textColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BigLabel: UILabel {

    init(key: LocalizationKey) {
        super.init(frame: .zero)
        self.text = localized(key)
        self.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        self.numberOfLines = 1
        self.textColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
