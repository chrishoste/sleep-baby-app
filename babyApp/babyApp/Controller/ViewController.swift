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

	let quickSounds = [QuickSound(identifier: 1), QuickSound(identifier: 2), QuickSound(identifier: 3)]
	let melodySounds = [MelodySound(identifier: 1), MelodySound(identifier: 2)]

	let settingsButton: UIButton = {
		let button = UIButton()
		button.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 44, height: 44))
		button.setImage(#imageLiteral(resourceName: "settings"), for: .normal)
		return button
	}()

	let emptyButton: UIButton = {
		let button = UIButton()
		button.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 44, height: 44))
		return button
	}()

	var lastTabedView: UIView?

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white

		setupView()
	}

	fileprivate func setupView() {
		let titleStackView = CustomStackView(arrangedSubviews: [emptyButton, TitleLabel(key: .titleBabyApp), settingsButton], spacing: 16)

		let topStackView = CustomStackView(arrangedSubviews: [
			SubLabel(key: .titleMelodySound),
			CustomStackView(arrangedSubviews: generateMelodyViews(melodySounds), axis: .vertical, spacing: 16, distribution: .fillEqually)
			], axis: .vertical, spacing: 4)

		let subStackView = CustomStackView(arrangedSubviews: [
			SubLabel(key: .titleQuickSound),
			CustomStackView(arrangedSubviews: generateQuickSoundViews(quickSounds), spacing: 16, distribution: .fillEqually)
			], axis: .vertical, spacing: 4)

		let stackView = CustomStackView(arrangedSubviews: [titleStackView, topStackView, subStackView], axis: .vertical, spacing: 16)

		view.addSubview(stackView)
		stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 16, bottom: 8, right: 16))
	}

	@objc func handleTab(_ sender: UITapGestureRecognizer) {

		let melodyLightViewController = MelodyLightViewController(frame: ((sender.view?.superview?.convert(sender.view!.frame, to: self.view))!))
		melodyLightViewController.delegate = self
		melodyLightViewController.modalPresentationStyle = .overCurrentContext

		self.present(melodyLightViewController, animated: false) {
			self.lastTabedView = sender.view
			sender.view?.alpha = 0
		}
	}

	func generateMelodyViews(_ melodys: [MelodySound]) -> [UIView] {
		var views: [UIView] = []

		for _ in melodys {
			let melodyView = UIView()
			melodyView.layer.cornerRadius = 10
			melodyView.backgroundColor = .lightGray
			melodyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTab(_:))))
			views.append(melodyView)
		}

		return views
	}

	func generateQuickSoundViews(_ sounds: [QuickSound]) -> [UIView] {
		var views: [UIView] = []

		for _ in sounds {
			let soundView = UIView()
			soundView.layer.cornerRadius = 10
			soundView.backgroundColor = .lightGray
			soundView.constraintSquare(spacing: 16, screenWitdth: view.frame.width, count: sounds.count)
			views.append(soundView)
		}

		return views
	}

}

extension ViewController: MelodyLightViewControllerDelegate {
	func didClose() {
		lastTabedView?.alpha = 1
	}
}

extension UIView {
	func constraintSquare(spacing: CGFloat, screenWitdth: CGFloat, count: Int) {
		let numberOfViews = CGFloat(count)
		let size = (screenWitdth - (spacing*(numberOfViews+1))) / numberOfViews

		self.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: size, height: size))
	}
}
