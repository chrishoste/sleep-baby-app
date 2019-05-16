//
//  NightLightViewController.swift
//  babyApp
//
//  Created by Christophe Hoste on 05.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

protocol NightLightViewControllerDelegate: class {
	func didClose()
}

class NightLightViewController: UIViewController {

    let colors: [UIColor]
    var stopAnimation = false

    let snapView = UIView()
    let nightLightView: NightLightView

	var smallViewFrame: CGRect
	var viewsTopAnchor: NSLayoutConstraint?
	var viewsLeadingAnchor: NSLayoutConstraint?
	var viewsHeightAnchor: NSLayoutConstraint?
	var viewsWidthAnchor: NSLayoutConstraint?

	weak var delegate: NightLightViewControllerDelegate?

    init(frame: CGRect, nightLight: NightLight) {
		smallViewFrame = frame
        nightLightView = NightLightView(nightLight: nightLight)
        nightLightView.handleFullscreen()
        colors = nightLight.nightLightColors
		super.init(nibName: nil, bundle: nil)
	}

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        stopAnimation = true

        snapView.layer.removeAllAnimations()
        view.layer.removeAllAnimations()
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .clear

		snapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClose(_:))))
        backgroundTransition(index: 0)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		setupViews(frame: smallViewFrame)
    }

    func setupViews(frame: CGRect) {
        view.addSubview(snapView)
        snapView.layer.cornerRadius = 10
        snapView.layer.masksToBounds = true
        snapView.translatesAutoresizingMaskIntoConstraints = false
        viewsTopAnchor = snapView.topAnchor.constraint(equalTo: view.topAnchor, constant: smallViewFrame.origin.y)
        viewsLeadingAnchor = snapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: smallViewFrame.origin.x)

        viewsHeightAnchor = snapView.heightAnchor.constraint(equalToConstant: smallViewFrame.height)
        viewsWidthAnchor = snapView.widthAnchor.constraint(equalToConstant: smallViewFrame.width)

        [viewsTopAnchor, viewsLeadingAnchor, viewsHeightAnchor, viewsWidthAnchor].forEach({$0?.isActive = true})

        snapView.addSubview(nightLightView)
        nightLightView.fillSafeAreaSuperview(bottom: false)
        animateView()
    }

	func animateView() {
		self.view.layoutIfNeeded()

		UIView.animate(withDuration: 0.20, delay: 0, options: .curveEaseOut, animations: {

			self.viewsTopAnchor?.constant = 0
			self.viewsLeadingAnchor?.constant = 0
			self.viewsWidthAnchor?.constant = self.view.frame.width
			self.viewsHeightAnchor?.constant = self.view.frame.height
            self.snapView.layer.cornerRadius = 0
            self.nightLightView.backgroundColor = .clear

			self.view.layoutIfNeeded() // starts animation

		}, completion: nil)
	}

	@objc func handleClose(_ sender: UITapGestureRecognizer) {
		self.view.layoutIfNeeded()
        nightLightView.backgroundColor = colors[0]
        nightLightView.handleClose()

		UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: .curveEaseOut, animations: {

			self.viewsTopAnchor?.constant = self.smallViewFrame.origin.y
			self.viewsLeadingAnchor?.constant = self.smallViewFrame.origin.x
			self.viewsWidthAnchor?.constant = self.smallViewFrame.width
			self.viewsHeightAnchor?.constant = self.smallViewFrame.height
            self.snapView.layer.cornerRadius = 10

			self.view.layoutIfNeeded() // starts animation

		}, completion: {(_) in
			self.dismiss(animated: false) {
				self.delegate?.didClose()
			}
		})

	}

    func backgroundTransition(index: Int) {
        UIView.animate(withDuration: 5, delay: 0, options: [.curveEaseOut, .allowUserInteraction], animations: {
            self.snapView.backgroundColor = self.colors[index]
        }, completion: { (_) in
            if self.stopAnimation {
                return
            }
            self.backgroundTransition(index: index < self.colors.count - 1 ? index + 1 : 0)
        })
    }

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
