//
//  forgotPasswordForm.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 28.04.2025.
//

import UIKit
import SnapKit

class ForgotPasswordForm: UIView {
    
    private var email: InputField = {
        let email = InputField()
        
        email.fieldName.text = "EMAIL"
        
        email.field.attributedPlaceholder = NSAttributedString(string: "example@gmail.com", attributes: [.foregroundColor: UIColor(red: 160/255, green: 165/255, blue: 186/255, alpha: 1)])
        email.field.keyboardType = .emailAddress
        
        return email
    }()
    
    private lazy var sendCodeBtn: OrangeButton = {
        let btn = OrangeButton()
        btn.setTitle("SEND CODE", for: .normal)
        btn.addTarget(self, action: #selector(sendCode), for: .touchUpInside)
        return btn
    }()
    
    init () {
        super.init(frame: .zero)
        
        let views = [email, sendCodeBtn]
        views.forEach { addSubview($0) }
        
        layer.cornerRadius = 24
        backgroundColor = .white
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        email.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(24)
        }
        
        sendCodeBtn.snp.makeConstraints {
            $0.top.equalTo(email.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(62)
        }
    }
    
    func validate() {
        
        guard let emailText = email.field.text,
              !emailText.isEmpty,
              email.isEmailValid(emailText) else {
            email.field.layer.borderWidth = 1
            email.field.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        email.field.layer.borderWidth = 0
        email.field.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    
    
    @objc func sendCode() {
        print("send code")
        validate()
        
    }
    
}
