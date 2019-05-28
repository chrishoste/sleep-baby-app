//
//  SlideUpMenuController.swift
//  babyApp
//
//  Created by Christophe Hoste on 07.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

enum MenuState {
    case close, open, fullScreen
}

class SlideUpMenuController: UIViewController {

    private var stackView: UIStackView!
    private var topStackView: UIStackView!

    private let overlayDarkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        view.alpha = 0
        return view
    }()

   private  let menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()

    private var menuHeightAnchor: NSLayoutConstraint?
    private var menuBottomAnchor: NSLayoutConstraint?

    private var panGesture: UIPanGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performAnimation(forState: .open)
    }

    fileprivate func setupViews() {
        view.addSubview(overlayDarkView)
        overlayDarkView.fillSuperview()
        overlayDarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleClose)))
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        view.addGestureRecognizer(panGesture)

        view.addSubview(menuView)
        menuView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)

        menuBottomAnchor = menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constant.menuHeight)
        menuBottomAnchor?.isActive = true
        menuHeightAnchor = menuView.heightAnchor.constraint(equalToConstant: Constant.menuHeight)
        menuHeightAnchor?.isActive = true

        let controller = setupViewController()

        topStackView = CustomStackView(arrangedSubviews: [UIView(), ThumbSlidingView(), UIView()], distribution: .equalCentering)
        topStackView.isLayoutMarginsRelativeArrangement = true
        topStackView.layoutMargins = .init(top: 8, left: 0, bottom: 0, right: 0)
        stackView = CustomStackView(arrangedSubviews: [topStackView, controller.view], axis: .vertical, spacing: 8)

        menuView.addSubview(stackView)
        stackView.fillSuperview()

        addChild(controller)
    }

    private func setupViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        if let settingsController = storyboard.instantiateViewController(withIdentifier: "settings") as? SettingsViewController {
            settingsController.delegate = self
            let navController = UINavigationController(rootViewController: settingsController)
            return navController
        }

        return UIViewController()
    }

    @objc internal func handleClose() {
        performAnimation(forState: .close)
    }

    private func performAnimation(forState state: MenuState) {

        var menuHeight: CGFloat = 0

        switch state {
        case .fullScreen:
            menuHeight = view.frame.height
        default:
            menuHeight = Constant.menuHeight
        }

        menuBottomAnchor?.constant = state == .close ? menuHeight : 0
        menuHeightAnchor?.constant = state == .close ? Constant.menuHeight : menuHeight

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
            self.overlayDarkView.alpha = state == .close ? 0 : 1
            self.view.layoutIfNeeded()
        }) { (_) in
            if state == .close {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }

    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            handleChanged(gesture)
        case .ended:
            hanldeEnded(gesture)
        default:
            return
        }
    }

    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translationsY = gesture.translation(in: view).y
        var newHeight = Constant.menuHeight + (translationsY/2)*(-1)

        newHeight = min(700, newHeight)
        newHeight = max(Constant.menuHeight, newHeight)
        menuHeightAnchor?.constant = newHeight

        if newHeight <= Constant.menuHeight {
            menuBottomAnchor?.constant = 0 + translationsY
        } else {
            menuBottomAnchor?.constant = 0
        }
    }

    fileprivate func hanldeEnded(_ gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: view).y
        if abs(menuBottomAnchor!.constant) > Constant.menuHeight/2 || velocity > 500 {
            performAnimation(forState: .close)
        } else {
            performAnimation(forState: .open)
        }
    }
}

extension SlideUpMenuController: SettingsViewControllerDelegate {
    func handleFullScreen() {
        stackView.removeArrangedSubview(topStackView)
        topStackView.removeFromSuperview()
        panGesture.isEnabled = false
        performAnimation(forState: .fullScreen)
    }
}
