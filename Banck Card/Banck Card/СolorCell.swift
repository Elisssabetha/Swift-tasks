//
//  СolorCell.swift
//  Banck Card
//
//  Created by Елизавета Каранкевич on 05.04.2025.
//

import UIKit

class ColorCell: UICollectionViewCell {
    static let reuseIdentifier = "ColorCell"
    
    let markImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "mark")
        return img
    }()
    
    override var isSelected: Bool {
        didSet {
            markImage.isHidden = !isSelected
        }
    }
    
    func setCell(colors: [UIColor]) {
        let sublayer = makeGradientLayer(with: colors, frame: bounds)
        layer.addSublayer(sublayer)
        addSubview(markImage)
        markImage.translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 12
        markImage.isHidden = true
        clipsToBounds = true
        
        markImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
