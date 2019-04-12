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
        bindTableView()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        titleLabel.text = "Complete your profile"
        subtitleLabel.text = "I am working from..."
        
        tableView.delegate = self
        tableView.dataSource = nil
    }

    private func bindTableView() {
        let data = Observable<[Office]>.just(Office.allCases)
        
        data.bind(to: tableView.rx.items(cellIdentifier: "officeCell")) { index, model, cell in
            cell.textLabel?.text = model.rawValue
        }.disposed(by: disposeBag)
    }
    
    private func selectedOffice() {
        navigationController?.pushViewController(CraftSelectViewController(), animated: true)
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
