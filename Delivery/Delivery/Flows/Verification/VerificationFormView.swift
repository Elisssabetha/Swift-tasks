//
//  VerificationFormView.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 10.06.2025.
//

import UIKit
import SnapKit
import SVPinView

class VerificationFormView: UIView {
    
    private let pinView: SVPinView = {
        let pinView = SVPinView(frame: .zero)
        pinView.pinLength = 4
        pinView.interSpace = 20
        pinView.keyboardType = .numberPad
        pinView.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        pinView.backgroundColor = UIColor(red: 240/255, green: 245/255, blue: 250/255, alpha: 1.0)
        pinView.textColor = .black //
        pinView.borderLineColor = .lightGray
        pinView.activeBorderLineColor = .black // граница у активной ячейки
        pinView.borderLineThickness = 1
        pinView.shouldSecureText = true // опказывать ли что введено
        pinView.translatesAutoresizingMaskIntoConstraints = false
        return pinView
    }()
    
    private let btn: OrangeButton = {
        let btn = OrangeButton()
        btn.setTitle("Verify", for: .normal)
        return btn
    }()

    init () {
        super.init(frame: .zero)
        
        [pinView, btn].forEach { addSubview($0) }
        
        layer.cornerRadius = 24
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundColor = .white
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        pinView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(49)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(62)
        }
        
        btn.snp.makeConstraints {
            $0.top.equalTo(pinView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(62)
        }
    }

}
