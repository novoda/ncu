//
//  WelcomeViewController.swift
//  NCU
//
//  Created by Simon Rowlands on 12/11/2018.
//  Copyright © 2018 simonrowlands. All rights reserved.
//

import UIKit

import Cartography
import RxSwift
import RxCocoa

final class WelcomeViewController: UIViewController {
    
    private let profileImageView = UIImageView(image: UIImage(named: "userPlaceholder"))
    private let titleLabel = UILabel()
    private let craftLabel = UILabel()
    private let officeLabel = UILabel()
    private let textView = UITextView()
    private let continueButton = UIButton(type: .custom)
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setup()
        
        if let user = User.get() {
            titleLabel.text = "Welcome \(user.givenName)!"
            craftLabel.text = user.crafts.map { $0.rawValue }.joined(separator: ", ")
            officeLabel.text = "\(user.office?.rawValue ?? "")"
        }
        
        bindContinueButton()
    }
    
    private func bindContinueButton() {
        continueButton.rx.tap
            .subscribe(onNext: { _ in
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.setRootWithFade(to: HomeViewController())
                User.get()?.hasSeenOnboarding = true
            })
            .disposed(by: disposeBag)
    }
}

extension WelcomeViewController: Subviewable {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func setupSubviews() {
        
        titleLabel.text = "Welcome!"
        textView.text = "Welcome and congratulations on your admission to the Novoda Craftsmanship University. We are thrilled to have you onboard and look forward to the journey we will take together.\n\nContinuous learning and mentorship are significant parts of Novoda, and we pride ourselves on the quality of the work we provide to our clients and the people that make achieving such a high level of quality possible.\n\nAs a result, Novoda is not just a place to work but also a place to learn, grow, and share the crafts of software development, app design, and project management. In exchange for applying your time and effort to the NCU programme we will commit to your professional growth by providing you with a personalised platform for your continuous learning and improvement.\n\nThe journey of a craftsman is long and never-ending, full of hard work, sweat, and tears but it is also a journey of joy, discovery, knowledge acquisition, and professional growth.\n\nLet’s take it together!"
        
        textView.isEditable = false
        textView.isSelectable = false
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        craftLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        officeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        
        continueButton.setTitle("Continue", for: .normal)
        continueButton.backgroundColor = UIColor(named: "baseColor")
        continueButton.layer.cornerRadius = 8
    }
    
    func setupStyles() {
        titleLabel.style(with: .title1, alignment: .center)
        textView.style(with: .footnote)
        craftLabel.style(with: .subheadline, alignment: .center)
        officeLabel.style(with: .subheadline, alignment: .center)
    }
    
    func setupHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(titleLabel)
        view.addSubview(craftLabel)
        view.addSubview(officeLabel)
        view.addSubview(textView)
        view.addSubview(continueButton)
    }
    
    func setupAutoLayout() {
        constrain(profileImageView, titleLabel, view) { imageView, titleLabel, view in
            imageView.top == view.safeAreaLayoutGuide.topMargin + 20
            imageView.width == imageView.height
            imageView.centerX == view.centerX
            imageView.height == view.height * 0.1
            imageView.bottom == titleLabel.top - 12
        }
        constrain(titleLabel, craftLabel, view) { titleLabel, craftLabel, view in
            titleLabel.left >= view.safeAreaLayoutGuide.leftMargin + 20
            titleLabel.right >= view.safeAreaLayoutGuide.rightMargin - 20
            titleLabel.centerX == view.centerX
            titleLabel.bottom == craftLabel.top - 12
        }
        constrain(craftLabel, officeLabel, view) { craftLabel, officeLabel, view in
            craftLabel.left >= view.safeAreaLayoutGuide.leftMargin + 20
            craftLabel.right >= view.safeAreaLayoutGuide.rightMargin - 20
            craftLabel.centerX == view.centerX
            craftLabel.bottom == officeLabel.top
        }
        constrain(officeLabel, textView, view) { officeLabel, textView, view in
            officeLabel.left >= view.safeAreaLayoutGuide.leftMargin + 20
            officeLabel.right >= view.safeAreaLayoutGuide.rightMargin - 20
            officeLabel.centerX == view.centerX
            officeLabel.bottom == textView.top - 12
        }
        constrain(textView, continueButton, view) { textView, button, view in
            textView.left == view.safeAreaLayoutGuide.leftMargin + 12
            textView.right == view.safeAreaLayoutGuide.rightMargin - 12
            textView.bottom == button.top + 12
        }
        constrain(continueButton, view) { continueButton, view in
            continueButton.left == view.safeAreaLayoutGuide.leftMargin + 20
            continueButton.right == view.safeAreaLayoutGuide.rightMargin - 20
            continueButton.bottom == view.safeAreaLayoutGuide.bottomMargin - 20
            continueButton.height == 50
        }
    }
}
