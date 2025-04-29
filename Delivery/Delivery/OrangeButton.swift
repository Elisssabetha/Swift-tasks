//
//  OrangeButton.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 28.04.2025.
//

import UIKit

class OrangeButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .orang
        layer.cornerRadius = 12
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold) // размер и жирность
        translatesAutoresizingMaskIntoConstraints = false
    }
}
