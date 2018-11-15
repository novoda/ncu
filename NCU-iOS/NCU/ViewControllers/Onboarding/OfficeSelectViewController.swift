//
//  OfficeSelectViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 13/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import Cartography
import RxSwift
import RxCocoa

final class OfficeSelectViewController: OnboardingViewController { // Should be part of a pageViewController maybe?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "officeCell")
        
        setup()
    }
    
    func selectedOffice() {
        navigationController?.pushViewController(CraftSelectViewController(), animated: true)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        titleLabel.text = "Complete your profile"
        subtitleLabel.text = "I am working from..."
        
        tableView.delegate = self
        tableView.dataSource = self
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
            selectedOffice()
        }
    }
}

extension OfficeSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Office.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "officeCell", for: indexPath)
        cell.textLabel?.text = Office.allCases[indexPath.row].rawValue
//        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return cell
    }
}
