//
//  ViewController.swift
//  babyApp
//
//  Created by Christophe Hoste on 05.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

		view.backgroundColor = .white

		setupView()
	}

	fileprivate func setupView() {
		let titleStackView = CustomStackView(arrangedSubviews: [emptyButton, TitleLabel(key: .titleBabyApp), settingsButton], spacing: 16)

		let topStackView = CustomStackView(arrangedSubviews: [
			SubLabel(key: .titleMelodySound),
			CustomStackView(arrangedSubviews: generateMelodyViews(Data.melodySounds), axis: .vertical, spacing: Constant.spacing, distribution: .fillEqually)
			], axis: .vertical, spacing: 4)

		let subStackView = CustomStackView(arrangedSubviews: [
                SubLabel(key: .titleQuickSound),
                CustomStackView(arrangedSubviews: [
                    CustomStackView(arrangedSubviews: generateQuickSoundViews(Data.quickSounds1), spacing: Constant.spacing, distribution: .fillEqually),
                    CustomStackView(arrangedSubviews: generateQuickSoundViews(Data.quickSounds2), spacing: Constant.spacing, distribution: .fillEqually)
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
        if let melodyView = sender.view as? NightLightSmallView {
            tabOnNightLightView(melodyView, sender)
        }
	}

    private func tabOnNightLightView(_ melodyView: NightLightSmallView, _ sender: UITapGestureRecognizer) {
        let melodyLightViewController = MelodyLightViewController(frame: (melodyView.superview?.convert(melodyView.frame, to: view))!, melody: Data.melodySounds[melodyView.melodyId])
        melodyLightViewController.delegate = self
        melodyLightViewController.modalPresentationStyle = .overCurrentContext

        self.present(melodyLightViewController, animated: false) {
            self.lastTabedView = sender.view
            sender.view?.alpha = 0
        }
    }

	private func generateMelodyViews(_ melodys: [MelodySound]) -> [UIView] {
		var views: [UIView] = []

		for melody in melodys {
			let melodyView = NightLightSmallView(melody: melody)
			melodyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTab(_:))))
			views.append(melodyView)
		}

		return views
	}

	private func generateQuickSoundViews(_ sounds: [QuickSound]) -> [UIView] {
		var views: [UIView] = []

        sounds.forEach { (_) in
            let soundView = UIView()
            views.append(soundView)
            soundView.layer.cornerRadius = 10
            soundView.backgroundColor = .lightGray
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
