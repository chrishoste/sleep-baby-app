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

    private let colors: [UIColor]
    private var stopAnimation = false

    private let snapView = UIView()
    private let nightLightView: NightLightView

	private var smallViewFrame: CGRect
	private var viewsTopAnchor: NSLayoutConstraint?
	private var viewsLeadingAnchor: NSLayoutConstraint?
	private var viewsHeightAnchor: NSLayoutConstraint?
	private var viewsWidthAnchor: NSLayoutConstraint?

	weak var delegate: NightLightViewControllerDelegate?

    init(frame: CGRect, nightLight: NightLight) {
		smallViewFrame = frame
        nightLightView = NightLightView(nightLight: nightLight, clipped: false)
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
        backgroundTransition(index: 0)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		setupViews(frame: smallViewFrame)
    }

    private func setupViews(frame: CGRect) {
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

	private func animateView() {
		self.view.layoutIfNeeded()

		UIView.animate(withDuration: 0.30, delay: 0, options: .curveEaseOut, animations: {

			self.viewsTopAnchor?.constant = 0
			self.viewsLeadingAnchor?.constant = 0
			self.viewsWidthAnchor?.constant = self.view.frame.width
			self.viewsHeightAnchor?.constant = self.view.frame.height
            self.snapView.layer.cornerRadius = 0
            self.nightLightView.backgroundColor = .clear

			self.view.layoutIfNeeded() // starts animation

        }, completion: { (_) in
            self.showCloseButton()
        })
	}

	@objc private func handleClose(_ sender: UIButton) {
        sender.removeFromSuperview()
		self.view.layoutIfNeeded()
        nightLightView.backgroundColor = colors[0]
        nightLightView.handleClose()

		UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: .curveEaseOut, animations: {

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

    func showCloseButton() {
        let closeButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = true
            button.constrainWidth(constant: 44)
            button.constrainHeight(constant: 44)
            button.setImage(#imageLiteral(resourceName: "closeIcon"), for: .normal)
            button.alpha = 0.7
            button.addTarget(self, action: #selector(handleClose(_:)), for: .touchUpInside)
            return button
        }()

        view.addSubview(closeButton)

        closeButton.transform = .init(translationX: 0, y: -200)

        if nightLightView.nightLightId.isMultiple(of: 2) {
            closeButton.anchor(top: nightLightView.topAnchor, leading: nightLightView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: 16, bottom: 0, right: 0))
        } else {
            closeButton.anchor(top: nightLightView.topAnchor, leading: nil, bottom: nil, trailing: nightLightView.trailingAnchor, padding: .init(top: 8, left: 0, bottom: 0, right: 16))
        }

        UIView.animate(withDuration: 0.35, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
            closeButton.transform = .identity
        }, completion: nil)
    }

    private func backgroundTransition(index: Int) {
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