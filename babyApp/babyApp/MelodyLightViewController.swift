//
//  MelodyLightViewController.swift
//  babyApp
//
//  Created by Christophe Hoste on 05.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

protocol MelodyLightViewControllerDelegate: class {
	func didClose()
}

class MelodyLightViewController: UIViewController {

	let view1: UIView = {
		let view = UIView()
		view.backgroundColor = .blue
		return view
	}()

	var smallViewFrame: CGRect
	var viewsTopAnchor: NSLayoutConstraint?
	var viewsLeadingAnchor: NSLayoutConstraint?
	var viewsHeightAnchor: NSLayoutConstraint?
	var viewsWidthAnchor: NSLayoutConstraint?

	weak var delegate: MelodyLightViewControllerDelegate?

	init(frame: CGRect) {
		smallViewFrame = frame
		super.init(nibName: nil, bundle: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .clear

		view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClose(_:))))
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		setupViews(frame: smallViewFrame)
	}

	func setupViews(frame: CGRect) {
		view.addSubview(view1)
		view1.layer.cornerRadius = 10
		view1.translatesAutoresizingMaskIntoConstraints = false
		viewsTopAnchor = view1.topAnchor.constraint(equalTo: view.topAnchor, constant: smallViewFrame.origin.y)
		viewsLeadingAnchor = view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallViewFrame.origin.x)

		viewsHeightAnchor = view1.heightAnchor.constraint(equalToConstant: smallViewFrame.height)
		viewsWidthAnchor = view1.widthAnchor.constraint(equalToConstant: smallViewFrame.width)

		[viewsTopAnchor, viewsLeadingAnchor, viewsHeightAnchor, viewsWidthAnchor].forEach({$0?.isActive = true})

		animateView()
	}

	func animateView() {
		self.view.layoutIfNeeded()

		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

			self.viewsTopAnchor?.constant = 0
			self.viewsLeadingAnchor?.constant = 0
			self.viewsWidthAnchor?.constant = self.view.frame.width
			self.viewsHeightAnchor?.constant = self.view.frame.height

			self.view.layoutIfNeeded() // starts animation

		}, completion: nil)
	}

	@objc func handleClose(_ sender: UITapGestureRecognizer) {
		self.view.layoutIfNeeded()

		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {

			self.viewsTopAnchor?.constant = self.smallViewFrame.origin.y
			self.viewsLeadingAnchor?.constant = self.smallViewFrame.origin.x
			self.viewsWidthAnchor?.constant = self.smallViewFrame.width
			self.viewsHeightAnchor?.constant = self.smallViewFrame.height

			self.view.layoutIfNeeded() // starts animation

		}, completion: {(_) in
			self.dismiss(animated: false) {
				self.delegate?.didClose()
			}
		})

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}