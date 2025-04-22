//
//  ViewController.swift
//  Banck Card
//
//  Created by Елизавета Каранкевич on 01.04.2025.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    // основной заголовок
    private let topLapel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.text = "Design your virtual card"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // банковская карта
    private var cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // заголовок перед цветам
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "Select color"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // заголовок перед картинками
    private let imagesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "Add shapes"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // нижний текст
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't worry. You can always change the design of your virtual card later. Just enter the settings."
        label.textColor = UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let btn: UIButton = {
        let button = UIButton()
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 32.6
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // коллекция цвето
    lazy private var colorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 62, height: 62)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.reuseIdentifier)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.restorationIdentifier = "color"
        return cv
    }()
    
    // коллекция картинок
    lazy private var imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 62, height: 62)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        
        let cv = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        cv.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.restorationIdentifier = "image"
        cv.allowsMultipleSelection = false
        return cv
    }()
    
    
    let gradients = [red, orange, lightorange, green, blue, violet]
    
    let imagesData: [UIImage] = [.img1, .img2, .img3, .img4, .img5, .img6]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        let views = [topLapel, cardView, colorLabel, imagesLabel, colorCollectionView, imagesCollectionView, infoLabel, btn]
        views.forEach { view.addSubview($0) }
        
        colorCollectionView.dataSource = self
        colorCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        
        
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 0, section: 0)
        imagesCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        colorCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        imagesCollectionView.delegate?.collectionView?(imagesCollectionView, didSelectItemAt: indexPath)
        colorCollectionView.delegate?.collectionView?(colorCollectionView, didSelectItemAt: indexPath)
    }
    
    
    // кол-во ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier {
        case CollectionIDs.color.rawValue:
            return gradients.count
        case CollectionIDs.image.rawValue:
            return imagesData.count
        default:
            return 0
        }
    }
    
    // настройка ячейки
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.restorationIdentifier {
            
        case CollectionIDs.color.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.reuseIdentifier, for: indexPath) as? ColorCell else { return UICollectionViewCell()}
            cell.setCell(colors: gradients[indexPath.item])
            return cell
            
        case CollectionIDs.image.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else { return UICollectionViewCell()}
            
            cell.mainImage.image = imagesData[indexPath.item]

            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    // при нажатии на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.restorationIdentifier {
            
        case CollectionIDs.color.rawValue:
            cardView.setUpGradient(index: indexPath.item)
            
        case CollectionIDs.image.rawValue:
            // картинка карточки
            cardView.imageView.image = imagesData[indexPath.item]
        default : break
        }
    }
    
    
    
    func setupConstraints() {
        topLapel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        cardView.snp.makeConstraints {
            $0.top.equalTo(topLapel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(175)
            $0.width.equalTo(306)
        }
        
        colorLabel.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(30)
            
        }
        colorCollectionView.snp.makeConstraints {
            $0.top.equalTo(colorLabel.snp.bottom).offset(23)
            $0.height.equalTo(62)
            $0.leading.trailing.equalToSuperview()
        }
        
        imagesLabel.snp.makeConstraints {
            $0.top.equalTo(colorCollectionView.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        imagesCollectionView.snp.makeConstraints {
            $0.top.equalTo(imagesLabel.snp.bottom).offset(21)
            $0.height.equalTo(62)
            $0.leading.trailing.equalToSuperview()
        }
        infoLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(imagesCollectionView.snp.bottom).offset(42)
            
        }
        
        btn.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(64)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(50)
            
        }
    }
    
}

enum CollectionIDs: String {
    case color
    case image
}




// штука для предпросмотра
struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // ничего не обновляем
    }
}
struct ContentView: View {
    var body: some View {
        ViewControllerWrapper()
            .edgesIgnoringSafeArea(.all) // если нужно на весь экран
    }
}

#Preview {
    ContentView()
}
