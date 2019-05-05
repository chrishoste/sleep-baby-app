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

}

extension UIView {
	func constraintSquare(spacing: CGFloat, screenWitdth: CGFloat, numberOfItems: CGFloat) {
		let size = (screenWitdth - (spacing*(numberOfItems+1))) / numberOfItems

		self.widthAnchor.constraint(equalToConstant: size).isActive = true
		self.heightAnchor.constraint(equalToConstant: size).isActive = true
	}
}
