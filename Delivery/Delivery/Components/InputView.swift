//
//  InputField.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 26.04.2025.
//

import UIKit
import SnapKit

class InputView: UIView {
    
    let fieldName: UILabel = {
        let label = UILabel()
        label.textColor = .title
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    let field: TextField = {
        let field = TextField()
        field.returnKeyType = .done
        field.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 257/255, alpha: 1)
        field.layer.cornerRadius = 10
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        return field
    }()
    
    
    init () {
        super.init(frame: .zero)
        
        [fieldName, field].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        fieldName.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        field.snp.makeConstraints {
            $0.top.equalTo(fieldName.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(62)
        }
    }
    
    func isEmailValid(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$" // Минимум 8 символов, 1 заглавная, 1 строчная, 1 цифра
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: password)
    }
    
}


class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 19, bottom: 0, right: 19)
    let rightViewPadding: CGFloat = 24
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.rightViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= rightViewPadding
        return rect
    }
}
