//
//  RememberMeBtn.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 27.04.2025.
//

import UIKit
import SnapKit

class RememberMeBtn: UIButton {

    let img: UIImageView = {
        let img = UIImageView(image: UIImage(named: "checkbox"))
        return img
    }()
    
    let text: UILabel = {
        let text = UILabel()
        text.textColor = UIColor(red: 126/255, green: 138/255, blue: 151/255, alpha: 1)
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        text.text = "Remember me"
        return text
    }()
    
    init () {
        super.init(frame: .zero)
        
        [img, text].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        img.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        
        }
        
        text.snp.makeConstraints {
            $0.leading.equalTo(img.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

}
