//
//  ViewController.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 22.04.2025.
//

import UIKit
import SnapKit
import SwiftUI

class ViewController: UIViewController {
    
    private lazy var pager: UIPageControl = {
        let pager = UIPageControl()
        pager.numberOfPages = 4 // всего страниц (4 не включается)
        pager.currentPage = 0 // текущая страница (0-3)
        pager.currentPageIndicatorTintColor  = .orang // активная страница (кружок)
        pager.pageIndicatorTintColor = .orang.withAlphaComponent(0.3) // неактивная страница
        pager.direction = .leftToRight
        pager.translatesAutoresizingMaskIntoConstraints = false
        pager.addTarget(self, action: #selector(handleChangePage), for: .valueChanged)
        pager.allowsContinuousInteraction = true
        return pager
    }()
    
    private let img: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .imageBg
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 12
        return img
    }()
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .title
        title.font = .boldSystemFont(ofSize: 24)
        title.textAlignment = .center
        title.text = "All your favorites"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let textLabel: UILabel = {
        let text = UILabel()
        text.textColor = .subtitle
        text.font = .systemFont(ofSize: 16)
        text.textAlignment = .center
        text.numberOfLines = 0
        text.text = "Get all your loved foods in one once place, you just place the orer we do the rest"
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var button: OrangeButton = {
        let button = OrangeButton()
        button.setTitle("NEXT", for: .normal)
        button.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.subtitle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
         
        [pager, img, titleLabel, textLabel, pager, button, skipBtn].forEach { view.addSubview($0) }
        
        setupConstraints()
        
    }
    
    @objc func handleChangePage() {
        switch pager.currentPage {
        case 0, 1:
            titleLabel.text = "All your favorites"
            button.setTitle("NEXT", for: .normal)
            skipBtn.isHidden = false
        case 2:
            titleLabel.text = "Order from choosen chef"
            button.setTitle("NEXT", for: .normal)
            skipBtn.isHidden = false
        case 3:
            titleLabel.text = "Free delivery offers"
            button.setTitle("GET STARTED", for: .normal)
            skipBtn.isHidden = true
        default:
            break
        }
    }
    
    @objc func goToNextPage() {
        if pager.currentPage == 3 {
            goToLogin()
        } else {
            pager.currentPage += 1
            handleChangePage()
        }
        
    }
    
    @objc func goToLogin() {
        navigationController?.pushViewController(LoginVC(), animated: true)
    }
    
    
    // MARK: setupConstraints
    func setupConstraints() {
        img.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide).offset(30)
            $0.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(65)// по макету 114, но не влазит
            $0.leading.trailing.equalToSuperview().inset(68)
            $0.height.equalTo(292)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(img.snp.bottom).offset(63) //63
            $0.top.greaterThanOrEqualTo(img.snp.bottom).offset(24)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        pager.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(textLabel.snp.bottom).offset(32)
            $0.top.greaterThanOrEqualTo(textLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(pager.snp.bottom).offset(69) //
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.greaterThanOrEqualTo(pager.snp.bottom).offset(8)
            $0.height.equalTo(62)
        }
        
        skipBtn.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(16)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
    }
    
}



// штука для предпросмотра
//struct ViewControllerWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> ViewController {
//        return ViewController()
//    }
//    
//    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
//        // ничего не обновляем
//    }
//}
//struct ContentView: View {
//    var body: some View {
//        ViewControllerWrapper()
//            .edgesIgnoringSafeArea(.all) // если нужно на весь экран
//    }
//}
//
//#Preview {
//    ContentView()
//}
