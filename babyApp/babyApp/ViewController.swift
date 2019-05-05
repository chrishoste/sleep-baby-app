//
//  ViewController.swift
//  babyApp
//
//  Created by Christophe Hoste on 05.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	let view1: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		view.layer.cornerRadius = 10
		return view
	}()

	let view2: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		view.layer.cornerRadius = 10
		return view
	}()

	let subView1: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		view.layer.cornerRadius = 10
		return view
	}()

	let subView2: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		view.layer.cornerRadius = 10
		return view
	}()

	let subView3: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		view.layer.cornerRadius = 10
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .red

		view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTab(_:))))
		view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTab(_:))))

		subView1.constraintSquare(spacing: 16, screenWitdth: view.frame.width, numberOfItems: 3)
		subView2.constraintSquare(spacing: 16, screenWitdth: view.frame.width, numberOfItems: 3)
		subView3.constraintSquare(spacing: 16, screenWitdth: view.frame.width, numberOfItems: 3)

		let subStackView = UIStackView(arrangedSubviews: [subView1, subView2, subView3])
		subStackView.distribution = .fillEqually
		subStackView.spacing = 16

		let topStackView = UIStackView(arrangedSubviews: [view1, view2])
		topStackView.axis = .vertical
		topStackView.distribution = .fillEqually
		topStackView.spacing = 16

		let stackView = UIStackView(arrangedSubviews: [topStackView, subStackView])
		stackView.axis = .vertical
		stackView.spacing = 16

		view.addSubview(stackView)

		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
		stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
	}

	@objc func handleTab(_ sender: UITapGestureRecognizer) {

		let melodyLightViewController = MelodyLightViewController(frame: ((sender.view?.superview?.convert(sender.view!.frame, to: self.view))!))
		melodyLightViewController.delegate = self
		melodyLightViewController.modalPresentationStyle = .overCurrentContext

		self.present(melodyLightViewController, animated: false) {
			sender.view?.alpha = 0
		}
	}

}

extension ViewController: MelodyLightViewControllerDelegate {
	func didClose() {
		view1.alpha = 1
		view2.alpha = 1
	}
}

extension UIView {
	func constraintSquare(spacing: CGFloat, screenWitdth: CGFloat, numberOfItems: CGFloat) {
		let size = (screenWitdth - (spacing*(numberOfItems+1))) / numberOfItems

		self.widthAnchor.constraint(equalToConstant: size).isActive = true
		self.heightAnchor.constraint(equalToConstant: size).isActive = true
	}
}
