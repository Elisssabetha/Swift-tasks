//
//  LoginForm.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 26.04.2025.
//

import UIKit
import SnapKit

class LoginFormView: UIView {
    
    weak var delegate: LoginFormDelegate?
    
    private let stackFields: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var passwordBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "hidePassword"), for: .normal)
        btn.addTarget(self, action: #selector(showPassword), for: .touchDown)
        btn.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
        
        return btn
    }()
    
    private var email: InputView = {
        let email = InputView()
        
        email.fieldName.text = "EMAIL"
        
        email.field.attributedPlaceholder = NSAttributedString(string: "example@gmail.com", attributes: [.foregroundColor: UIColor(red: 160/255, green: 165/255, blue: 186/255, alpha: 1)])
        email.field.keyboardType = .emailAddress
        
        return email
    }()
    
    private lazy var password: InputView = {
        let password = InputView()
        
        password.fieldName.text = "PASSWORD"
        
        password.field.isSecureTextEntry = true
        password.field.attributedPlaceholder = NSAttributedString(string: "**********", attributes: [.foregroundColor: UIColor(red: 160/255, green: 165/255, blue: 186/255, alpha: 1)])
        password.field.rightView = passwordBtn
        return password
    }()
    
    private let btnStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var forgotPasswordBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Forgot Password", for: .normal)
        btn.setTitleColor(.orang, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return btn
    }()
    
    private let rememberBtn: RememberMeBtn = {
        let btn = RememberMeBtn()
        let checkedImage = UIImage(systemName: "checkmark.square.fill")
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var loginBtn: OrangeButton = {
        let btn = OrangeButton()
        btn.setTitle("LOG IN", for: .normal)
        btn.addTarget(self, action: #selector(login), for: .touchUpInside)
        return btn
    }()
    
    private let signUpStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let signUpLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Don’t have an account?"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .subtitle
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var signUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("SIGN UP", for: .normal)
        btn.setTitleColor(.orang, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return btn
    }()
    
    private let orLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Or"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .subtitle
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let networkStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let fbButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "fb"), for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    private let twiButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "twi"), for: .normal)
        btn.backgroundColor = .clear
        return btn
    }()
    
    private let appleButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "apple"), for: .normal)
        
        return btn
    }()
    
    init () {
        super.init(frame: .zero)
    
        [stackFields, btnStack, loginBtn, signUpStack, orLbl, networkStack].forEach { addSubview($0) }
        
        layer.cornerRadius = 24
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundColor = .white
        
        [email, password].forEach { stackFields.addArrangedSubview($0) }
        [rememberBtn, forgotPasswordBtn].forEach { btnStack.addArrangedSubview($0) }
        [signUpLbl, signUpBtn].forEach { signUpStack.addArrangedSubview($0) }
        [fbButton, twiButton, appleButton].forEach { networkStack.addArrangedSubview($0) }
        
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        stackFields.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(24)
        }
        
        btnStack.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(stackFields.snp.bottom).offset(26)
            $0.top.greaterThanOrEqualTo(stackFields.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        loginBtn.snp.makeConstraints {
            $0.height.equalTo(62)
            $0.top.lessThanOrEqualTo(btnStack.snp.bottom).offset(29)
            $0.top.greaterThanOrEqualTo(btnStack.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        signUpStack.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(loginBtn.snp.bottom).offset(38)
            $0.top.greaterThanOrEqualTo(loginBtn.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(63)
        }
        
        orLbl.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(signUpStack.snp.bottom).offset(17)
            $0.top.greaterThanOrEqualTo(signUpStack.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        networkStack.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(orLbl.snp.bottom).offset(25)
            $0.top.greaterThanOrEqualTo(orLbl.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview().inset(39)
        }
        
    }
    
    @objc private func showPassword() {
        password.field.isSecureTextEntry = false
    }
    
    @objc private func hidePassword() {
        password.field.isSecureTextEntry = true
    }
    
    private func validate() -> Bool {
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
        return isEmailValid && isPasswordValid
    }
    
    @objc private func login() {
        if validate() {
            delegate?.loginTapped(self)
        }
    }
    
    @objc private func forgotPasswordTapped() {
        delegate?.forgotPasswordTapped(self)
    }
    
    @objc private func signUp() {
        delegate?.signupTapped(self)
    }
    
}
