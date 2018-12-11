//
//  CraftSelectViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 13/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class CraftSelectViewController: OnboardingViewController {
    
    private let continueButton = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "craftCell")
        
        setup()
        
        bindContinueButton()
        bindTableView()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        titleLabel.text = "Complete your profile"
        subtitleLabel.text = "I am interested in..."
        
        tableView.delegate = self
        tableView.dataSource = nil
        
        tableView.separatorStyle = .none
    }
    
    private func bindContinueButton() {
        continueButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.selectedCrafts()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        let data = Observable<[Craft]>.just(Craft.allCases)
        data.bind(to: tableView.rx.items(cellIdentifier: "craftCell")) { index, model, cell in
            cell.textLabel?.text = model.rawValue
            cell.textLabel?.style(alignment: .center)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                
                guard let cell = self?.tableView.cellForRow(at: indexPath) else { return }
                guard let user = User.get() else { return }
                
                let craft = Craft.allCases[indexPath.row]
                
                if user.crafts.contains(craft) {
                    cell.accessoryType = .none
                    user.crafts.removeAll(where: { predicate -> Bool in
                        return predicate == craft
                    })
                } else {
                    cell.accessoryType = .checkmark
                    user.crafts.append(craft)
                }
                user.store()
            })
            .disposed(by: disposeBag)
    }
    
    private func selectedCrafts() {
        navigationController?.pushViewController(WelcomeViewController(), animated: true)
    }
}

extension CraftSelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = UIColor(named: "baseColor")
        continueButton.layer.cornerRadius = 8
        return continueButton
    }
}
