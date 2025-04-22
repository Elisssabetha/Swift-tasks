//
//  CardView.swift
//  Banck Card
//
//  Created by Елизавета Каранкевич on 01.04.2025.
//

import UIKit
import SnapKit

class CardView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.opacity = 0.32
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 27)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$9,999"
        return label
    }()
    
    let cardNumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.layer.opacity = 0.35
        label.text = "****1644"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init () {
        super.init(frame: .zero)
        addSubview(imageView)
        addSubview(stackView)
        
        clipsToBounds = true // ничего не вылазит за пределы карточки
        layer.cornerRadius = 30
        
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(cardNumLabel)
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpGradient(index: Int) {
//        layer.sublayers?.remove(at: 0)
        layer.sublayers?
                .filter { $0 is CAGradientLayer }
                .forEach { $0.removeFromSuperlayer() }

        layer.insertSublayer(makeGradientLayer(with: gradients[index], frame: bounds), at: 0)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(37)
        }
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(154)
            $0.left.equalToSuperview().offset(-5)
            $0.bottom.equalToSuperview().offset(32)
        }
    }
}

