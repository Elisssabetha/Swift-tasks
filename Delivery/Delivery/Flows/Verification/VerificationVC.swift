//
//  VerificationVC.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 10.06.2025.
//

import UIKit

class VerificationVC: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Verification"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "We have sent a code to your email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "example@gmail.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let forgotPasswordForm: VerificationFormView = {
        let view = VerificationFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        [titleLabel, subtitleLabel, emailLabel, forgotPasswordForm].forEach { view.addSubview($0) }
        
        setupConstraints()
    
        
//        ForgotPasswordFormView.delegate = self
        
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(65) //макет 121
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        forgotPasswordForm.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(emailLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.lessThanOrEqualTo(620)
            $0.height.greaterThanOrEqualTo(534)
        }
    }

}
