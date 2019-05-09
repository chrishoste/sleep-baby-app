//
//  SlideUpMenuController.swift
//  babyApp
//
//  Created by Christophe Hoste on 07.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

enum MenuState: Int {
    case close = 0, open
}

class SlideUpMenuController: UIViewController {

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
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:))))

        view.addSubview(menuView)
        menuView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)

        menuBottomAnchor = menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constant.menuHeight)
        menuBottomAnchor?.isActive = true
        menuHeightAnchor = menuView.heightAnchor.constraint(equalToConstant: Constant.menuHeight)
        menuHeightAnchor?.isActive = true

        let controller = setupViewController()

        let stackView = CustomStackView(arrangedSubviews: [CustomStackView(arrangedSubviews: [UIView(), ThumbSlidingView(), UIView()], distribution: .equalCentering), controller.view], axis: .vertical, spacing: 8)

        menuView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 0, bottom: 0, right: 0))

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
        menuBottomAnchor?.constant = state.rawValue < 1 ? Constant.menuHeight : 0
        menuHeightAnchor?.constant = Constant.menuHeight
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
            self.overlayDarkView.alpha = CGFloat(state.rawValue)
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

extension SlideUpMenuController: SettingsViewControllerDelegate {}
