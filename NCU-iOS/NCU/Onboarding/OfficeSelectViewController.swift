//
//  OfficeSelectViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 13/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import Cartography

final class OfficeSelectViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "officeCell")
        
        setup()
    }
}

extension OfficeSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let user = User.get() {
            user.office = Office.allCases[indexPath.row]
            user.store()
//            navigationController?.pushViewController(CraftSelectViewController(), animated: true)
        }
    }
}

extension OfficeSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Office.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "officeCell", for: indexPath)
        cell.textLabel?.text = Office.allCases[indexPath.row].readable
//        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let remoteWorkerButton = UIButton()
        remoteWorkerButton.setTitle("I'm a remote worker", for: .normal)
        remoteWorkerButton.backgroundColor = UIColor(named: "baseColor")
        remoteWorkerButton.layer.cornerRadius = 8
        return remoteWorkerButton
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50 // UITableView.automaticDimension
    }
}

extension OfficeSelectViewController: Subviewable {
    func setupSubviews() {
        titleLabel.text = "Complete your profile"
        subtitleLabel.text = "I am working from..."
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInset = .init(top: 0, left: 0, bottom: 8, right: 0)
        
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
        constrain(titleLabel, subtitleLabel, view) { title, subtitle, view in
            title.top == view.safeAreaLayoutGuide.topMargin + 20
            title.left == view.safeAreaLayoutGuide.leftMargin + 8
            title.right == view.safeAreaLayoutGuide.rightMargin + 8
            title.bottom == subtitle.top
        }
        constrain(subtitleLabel, tableView, view) { subtitle, tableView, view in
            subtitle.left == view.safeAreaLayoutGuide.leftMargin + 8
            subtitle.right == view.safeAreaLayoutGuide.rightMargin + 8
            subtitle.bottom == tableView.top - 8
        }
        constrain(tableView, view) { tableView, view in
            tableView.left == view.safeAreaLayoutGuide.leftMargin + 8
            tableView.right == view.safeAreaLayoutGuide.rightMargin - 8
            tableView.bottom == view.safeAreaLayoutGuide.bottomMargin
        }
    }
}
