//
//  SettingsViewController.swift
//  babyApp
//
//  Created by Christophe Hoste on 08.05.19.
//  Copyright © 2019 hoste. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewControllerDelegate: class {
    func handleClose()
}

class SettingsViewController: UITableViewController {

    weak var delegate: SettingsViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }

    private func setupNavigationController() {
        title = localized(.titleSettings)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
    }

    @objc func handleDone() {
        delegate?.handleClose()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
