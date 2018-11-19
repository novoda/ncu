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
        
        continueButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.selectedCrafts()
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let cell = self?.tableView.cellForRow(at: indexPath) {
                    
                    if let user = User.get() {
                        
                        let craft = Craft.allCases[indexPath.row]
                        
                        if user.crafts.contains(craft) {
                            user.crafts.removeAll(where: { predicate -> Bool in
                                return predicate == craft
                            })
                        } else {
                            user.crafts.append(craft)
                        }
                        user.store()
                    }
                    
                    cell.accessoryType = cell.accessoryType == .checkmark ? .none : .checkmark
                }
            })
            .disposed(by: disposeBag)
    }
    
    func selectedCrafts() {
//        User.get()?.hasSeenOnboarding = true
        
        navigationController?.pushViewController(WelcomeViewController(), animated: true)
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.setRootWithFade(to: HomeViewController())
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        titleLabel.text = "Complete your profile"
        subtitleLabel.text = "I am interested in..."
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
}

extension CraftSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension CraftSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Craft.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "craftCell", for: indexPath)
        cell.textLabel?.text = Craft.allCases[indexPath.row].rawValue
        cell.textLabel?.style(alignment: .center)
        cell.selectionStyle = .none
        //        cell.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = UIColor(named: "baseColor")
        continueButton.layer.cornerRadius = 8
        return continueButton
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
}
