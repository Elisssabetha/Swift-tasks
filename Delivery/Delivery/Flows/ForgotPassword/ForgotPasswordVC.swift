//
//  ForgotPasswordVC.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 28.04.2025.
//

import UIKit

protocol ForgotPasswordFormDelegate: AnyObject {
    func sendCodeTapped(_ form: ForgotPasswordFormView)
}


class ForgotPasswordVC: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Forgot Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Please sign in to your existing account"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let forgotPasswordForm: ForgotPasswordFormView = {
        let view = ForgotPasswordFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        
        [titleLabel, subtitleLabel, forgotPasswordForm].forEach { view.addSubview($0) }
        
        setupConstraints()
        
        forgotPasswordForm.delegate = self
        
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
        
        forgotPasswordForm.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(subtitleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.lessThanOrEqualTo(620)
            $0.height.greaterThanOrEqualTo(534)
        }
    }

}


extension ForgotPasswordVC: ForgotPasswordFormDelegate {
    func sendCodeTapped(_ form: ForgotPasswordFormView) {
        navigationController?.pushViewController(VerificationVC(), animated: true)
    }
    
}
