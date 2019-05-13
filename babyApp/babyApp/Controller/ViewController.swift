//
//  ViewController.swift
//  babyApp
//
//  Created by Christophe Hoste on 05.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import UIKit

struct MelodySound {
	let identifier: Int
}

struct QuickSound {
	let identifier: Int
}

class ViewController: UIViewController {

    // Staubsauger, Spühlmaschine/Waschmaschine, Dusche
	private let quickSounds1 = [QuickSound(identifier: 1), QuickSound(identifier: 2)]
    private let quickSounds2 = [QuickSound(identifier: 3), QuickSound(identifier: 4)]
	private let melodySounds = [MelodySound(identifier: 1), MelodySound(identifier: 2)]

	private let settingsButton: UIButton = {
		let button = UIButton()
		button.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 44, height: 44))
		button.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
		return button
	}()

	private let emptyButton: UIButton = {
		let button = UIButton()
		button.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 44, height: 44))
		return button
	}()

	private var lastTabedView: UIView?

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = CustomColor.backgroundColor

		setupView()
	}

	fileprivate func setupView() {
		let titleStackView = CustomStackView(arrangedSubviews: [emptyButton, TitleLabel(key: .titleBabyApp), settingsButton], spacing: 16)

		let topStackView = CustomStackView(arrangedSubviews: [
			SubLabel(key: .titleMelodySound),
			CustomStackView(arrangedSubviews: generateMelodyViews(melodySounds), axis: .vertical, spacing: Constant.spacing, distribution: .fillEqually)
			], axis: .vertical, spacing: 4)

		let subStackView = CustomStackView(arrangedSubviews: [
                SubLabel(key: .titleQuickSound),
                CustomStackView(arrangedSubviews: [
                    CustomStackView(arrangedSubviews: generateQuickSoundViews(quickSounds1), spacing: Constant.spacing, distribution: .fillEqually),
                    CustomStackView(arrangedSubviews: generateQuickSoundViews(quickSounds2), spacing: Constant.spacing, distribution: .fillEqually)
                    ], axis: .vertical, spacing: Constant.spacing, distribution: .fillEqually)
            ], axis: .vertical, spacing: 4)

		let stackView = CustomStackView(arrangedSubviews: [
                titleStackView,
                CustomStackView(arrangedSubviews: [topStackView, subStackView], axis: .vertical, spacing: Constant.spacing, distribution: .fillEqually)
            ], axis: .vertical, spacing: Constant.spacing)

		view.addSubview(stackView)
		stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 16, right: 16))
	}

	@objc private func handleTab(_ sender: UITapGestureRecognizer) {

		let melodyLightViewController = MelodyLightViewController(frame: ((sender.view?.superview?.convert(sender.view!.frame, to: self.view))!))
		melodyLightViewController.delegate = self
		melodyLightViewController.modalPresentationStyle = .overCurrentContext

		self.present(melodyLightViewController, animated: false) {
			self.lastTabedView = sender.view
			sender.view?.alpha = 0
		}
	}

	private func generateMelodyViews(_ melodys: [MelodySound]) -> [UIView] {
		var views: [UIView] = []

		for _ in melodys {
			let melodyView = NightLightSmallView()
			melodyView.layer.cornerRadius = 10
			melodyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTab(_:))))
			views.append(melodyView)
		}

		return views
	}

	private func generateQuickSoundViews(_ sounds: [QuickSound]) -> [UIView] {
		var views: [UIView] = []

		for _ in sounds {
			let soundView = UIView()
            views.append(soundView)
			soundView.layer.cornerRadius = 10
			soundView.backgroundColor = .lightGray
            //soundView.constraintSquare(spacing: Constant.spacing, fullWidth: (view.frame.width - 32), count: sounds.count)
			views.append(soundView)
		}

		return views
	}

    @objc private func openSettings() {
        let menuController = SlideUpMenuController()
        menuController.modalPresentationStyle = .overCurrentContext

        self.present(menuController, animated: false)
    }

}

extension ViewController: MelodyLightViewControllerDelegate {
	func didClose() {
		lastTabedView?.alpha = 1
	}
}

extension UIView {
	func constraintSquare(spacing: CGFloat, fullWidth: CGFloat, count: Int) {
		let numberOfViews = CGFloat(count)
		let size = (fullWidth - (spacing * (numberOfViews-1))) / numberOfViews

		self.constrainWidth(constant: size)
        self.constrainHeight(constant: size)
	}
}
