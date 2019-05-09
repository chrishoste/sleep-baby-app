//
//  Localization.swift
//  babyApp
//
//  Created by Christophe Hoste on 06.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

public func localized(_ key: LocalizationKey) -> String {
	return NSLocalizedString(key.rawValue, comment: "localized")
}

public enum LocalizationKey: String {

//    case done, ok, yes, no

	case titleBabyApp
	case titleMelodySound
	case titleQuickSound
    case titleSettings

    case quickSoundShower
    case quickSoundVacuum
    case quickSoundWashingMachine
}
