//
//  ForgotPasswordVC.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 28.04.2025.
//

import UIKit

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
    
    private let forgotPasswordForm: ForgotPasswordForm = {
        let view = ForgotPasswordForm()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let views = [titleLabel, subtitleLabel, forgotPasswordForm]
        views.forEach { view.addSubview($0) }
        
        setupConstraints()
        
//        forgotPasswordForm.delegate = self
        
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(65) // по макету 121
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        forgotPasswordForm.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

}
