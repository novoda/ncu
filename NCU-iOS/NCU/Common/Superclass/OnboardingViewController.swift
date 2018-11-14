//
//  OnboardingViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 14/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import Cartography

public class OnboardingViewController: UIViewController {
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let tableView = UITableView()
}

extension OnboardingViewController: Subviewable {
    func setupSubviews() {
        tableView.contentInset = .init(top: 0, left: 0, bottom: 12, right: 0)
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        subtitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }
    
    func setupStyles() {
        titleLabel.style(with: .title1, alignment: .center)
        subtitleLabel.style(with: .subheadline, color: .darkGray, alignment: .center)
    }
    
    func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(tableView)
    }
    
    func setupAutoLayout() {
        constrain(titleLabel, subtitleLabel, view) { titleLabel, subtitleLabel, view in
            titleLabel.top == view.safeAreaLayoutGuide.topMargin + 20
            titleLabel.left == view.safeAreaLayoutGuide.leftMargin + 8
            titleLabel.right == view.safeAreaLayoutGuide.rightMargin + 8
            titleLabel.bottom == subtitleLabel.top
        }
        constrain(subtitleLabel, tableView, view) { subtitleLabel, tableView, view in
            subtitleLabel.left == view.safeAreaLayoutGuide.leftMargin + 8
            subtitleLabel.right == view.safeAreaLayoutGuide.rightMargin + 8
            subtitleLabel.bottom == tableView.top - 8
        }
        constrain(tableView, view) { tableView, view in
            tableView.left == view.safeAreaLayoutGuide.leftMargin + 12
            tableView.right == view.safeAreaLayoutGuide.rightMargin - 12
            tableView.bottom == view.safeAreaLayoutGuide.bottomMargin
        }
    }
}
