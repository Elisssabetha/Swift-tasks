//
//  ImageCell.swift
//  Banck Card
//
//  Created by Елизавета Каранкевич on 06.04.2025.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static let reuseIdentifier = "ImageCell"
    
    let markImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let mainImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.layer.opacity = 0.32
        return img
    }()
    
    override var isSelected: Bool {
        didSet {
            markImage.isHidden = !isSelected
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        markImage.image = UIImage(named: "mark")?.withRenderingMode(.alwaysOriginal)
        addSubview(markImage)
        markImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainImage)
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1)
        
        layer.cornerRadius = 12
        markImage.isHidden = !isSelected
        
        
        markImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        mainImage.snp.makeConstraints {
            $0.right.equalTo(self.snp.centerX)
            $0.top.equalTo(self.snp.centerY)
            $0.width.height.equalTo(31)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
