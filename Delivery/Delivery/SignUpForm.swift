//
//  SignUpForm.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 28.04.2025.
//

import UIKit

class SignUpForm: UIView {
    
    weak var delegate: SignUpFormDelegate?
    
    private let stackFields: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24 //было 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var passwordBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "eyeOff"), for: .normal)
        btn.addTarget(self, action: #selector(showPassword), for: .touchDown)
        btn.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
        
        return btn
    }()
    
    private var name: InputField = {
        let name = InputField()
        
        name.fieldName.text = "NAME"
        
        name.field.attributedPlaceholder = NSAttributedString(string: "John doe", attributes: [.foregroundColor: UIColor(red: 160/255, green: 165/255, blue: 186/255, alpha: 1)])
        
        return name
    }()
    
    private var email: InputField = {
        let email = InputField()
        
        email.fieldName.text = "EMAIL"
        
        email.field.attributedPlaceholder = NSAttributedString(string: "example@gmail.com", attributes: [.foregroundColor: UIColor(red: 160/255, green: 165/255, blue: 186/255, alpha: 1)])
        email.field.keyboardType = .emailAddress
        
        return email
    }()
    
    private lazy var password: InputField = {
        let password = InputField()
        
        password.fieldName.text = "PASSWORD"
        
        password.field.isSecureTextEntry = true
        password.field.attributedPlaceholder = NSAttributedString(string: "**********", attributes: [.foregroundColor: UIColor(red: 160/255, green: 165/255, blue: 186/255, alpha: 1)])
        password.field.rightView = passwordBtn
        return password
    }()
    
    private lazy var reTypePassword: InputField = {
        let password = InputField()
        
        password.fieldName.text = "RE-TYPE PASSWORD"
        
        password.field.isSecureTextEntry = true
        password.field.attributedPlaceholder = NSAttributedString(string: "**********", attributes: [.foregroundColor: UIColor(red: 160/255, green: 165/255, blue: 186/255, alpha: 1)])
        password.field.rightView = passwordBtn
        return password
    }()
    
    
    private lazy var signBtn: OrangeButton = {
        let btn = OrangeButton()
        btn.setTitle("SIGN UP", for: .normal)
        btn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return btn
    }()
    
    init () {
        super.init(frame: .zero)
        
        let views = [stackFields, signBtn, ]
        views.forEach { addSubview($0) }
        
        layer.cornerRadius = 24
        backgroundColor = .white
        
        stackFields.addArrangedSubview(name)
        stackFields.addArrangedSubview(email)
        stackFields.addArrangedSubview(password)
        stackFields.addArrangedSubview(reTypePassword)
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        stackFields.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(24)
        }
        signBtn.snp.makeConstraints {
            $0.height.equalTo(62)
            $0.top.equalTo(stackFields.snp.bottom).offset(47)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
    }
    
    @objc func showPassword() {
        password.field.isSecureTextEntry = false
        passwordBtn.setImage(UIImage(named: "hidePassword"), for: .normal)
    }
    
    @objc private func hidePassword() {
        password.field.isSecureTextEntry = true
        passwordBtn.setImage(UIImage(named: "eyeOff"), for: .normal)
    }
    
    func validate() -> Bool {
        let isNameValid: Bool = {
            guard let nameText = name.field.text,
                  !nameText.isEmpty else {
                name.field.layer.borderWidth = 1
                name.field.layer.borderColor = UIColor.red.cgColor
                return false
            }
            name.field.layer.borderWidth = 0
            name.field.layer.borderColor = UIColor.clear.cgColor
            return true
        }()
        
        let isEmailValid: Bool = {
            guard let emailText = email.field.text,
                  !emailText.isEmpty,
                  email.isEmailValid(emailText) else {
                email.field.layer.borderWidth = 1
                email.field.layer.borderColor = UIColor.red.cgColor
                return false
            }
            email.field.layer.borderWidth = 0
            email.field.layer.borderColor = UIColor.clear.cgColor
            return true
        }()
        
        let isPasswordValid: Bool = {
            guard let passwordText = password.field.text,
                  !passwordText.isEmpty,
                  password.isPasswordValid(passwordText) else {
                password.field.layer.borderWidth = 1
                password.field.layer.borderColor = UIColor.red.cgColor
                return false
            }
            password.field.layer.borderWidth = 0
            password.field.layer.borderColor = UIColor.clear.cgColor
            return true
        }()
        
        let isReTypePasswordValid: Bool = {
            guard let reTypePasswordText = reTypePassword.field.text,
                  reTypePasswordText == password.field.text else {
                reTypePassword.field.layer.borderWidth = 1
                reTypePassword.field.layer.borderColor = UIColor.red.cgColor
                return false
            }
            reTypePassword.field.layer.borderWidth = 0
            reTypePassword.field.layer.borderColor = UIColor.clear.cgColor
            return true
        }()
        return isNameValid && isEmailValid && isPasswordValid && isReTypePasswordValid
    }
    
    @objc private func signUp() {
        let valResult = validate()
        if valResult {
            delegate?.singUpTapped(self)
        }
    }
    
}


