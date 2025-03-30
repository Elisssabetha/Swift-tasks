//
//  CustomTableViewCell.swift
//  Tables-Collections
//
//  Created by Елизавета Каранкевич on 29.03.2025.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let subtitleLabel:UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        subtitle.textAlignment = .left
        subtitle.textColor = .gray
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    let stackView:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center // выравнивание по центру по Y
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
    
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        // что происходит при излишнем пространстве
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal) // не растягивается
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal) // растягивается
       
        
    }
}
