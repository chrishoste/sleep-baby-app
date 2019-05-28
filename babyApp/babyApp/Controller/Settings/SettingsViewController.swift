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
    func handleFullScreen()
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("dosomething")
        default:
            handleFullScreen()
        }
    }

    func handleFullScreen() {
        tableView.isScrollEnabled = true
        delegate?.handleFullScreen()
        let vcc = UIViewController()
        vcc.view.backgroundColor = .white
        navigationController?.pushViewController(vcc, animated: true)
    }

    @objc func handleDone() {
        delegate?.handleClose()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}
