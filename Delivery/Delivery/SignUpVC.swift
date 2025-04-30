//
//  SignUpVC.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 28.04.2025.
//

import UIKit
import SnapKit
import SwiftUI

class SignUpVC: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Sign Up"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Please sign up to get started"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpForm: SignUpForm = {
        let view = SignUpForm()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let views = [titleLabel, subtitleLabel, signUpForm]
        views.forEach { view.addSubview($0) }
        
        setupConstraints()
        
        signUpForm.delegate = self
        
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(65) // по макету 121
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        signUpForm.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    

}


protocol SignUpFormDelegate: AnyObject {
    func singUpTapped(_ form: SignUpForm)
}

extension SignUpVC: SignUpFormDelegate {
    func singUpTapped(_ form: SignUpForm) {
        navigationController?.pushViewController(FirstPageVC(), animated: true)
    }

}

//
//struct ViewControllerWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> SignUpVC {
//        return SignUpVC()
//    }
//    
//    func updateUIViewController(_ uiViewController: SignUpVC, context: Context) {
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
