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

    private let controllerView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    private var menuHeightAnchor: NSLayoutConstraint?
    private var menuBottomAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(overlayDarkView)
        overlayDarkView.fillSuperview()
        overlayDarkView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDarkViewTap)))

        view.addSubview(menuView)
        menuView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)

        menuBottomAnchor = menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300)
        menuBottomAnchor?.isActive = true
        menuHeightAnchor = menuView.heightAnchor.constraint(equalToConstant: 300)
        menuHeightAnchor?.isActive = true

        let stackView = CustomStackView(arrangedSubviews: [CustomStackView(arrangedSubviews: [UIView(), ThumbSlidingView(), UIView()], distribution: .equalCentering), controllerView], axis: .vertical, spacing: 8)

        menuView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performAnimation(forState: .open)
    }

    @objc func handleDarkViewTap() {
        performAnimation(forState: .close)
    }

    func performAnimation(forState state: MenuState) {
        menuBottomAnchor?.constant = state.rawValue < 1 ? 300 : 0
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: .curveEaseOut, animations: {
            self.overlayDarkView.alpha = CGFloat(state.rawValue)
            self.view.layoutIfNeeded()
        }) { (_) in
            if state == .close {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
}
