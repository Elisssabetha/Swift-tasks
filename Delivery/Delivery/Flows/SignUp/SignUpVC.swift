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
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let signUpForm: SignUpFormView = {
        let view = SignUpFormView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)
        
        [stack, signUpForm].forEach { view.addSubview($0) }
        
        setupConstraints()
        
        signUpForm.delegate = self
        
    }
// MARK: TODO view VC сжимается
    private func setupConstraints() {
//        titleLabel.snp.makeConstraints {
//            $0.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(65)
//            $0.top.greaterThanOrEqualToSuperview().offset(24)
//             // по макету 121
//            $0.centerX.equalToSuperview()
//        }
//        
//        subtitleLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
//            $0.centerX.equalToSuperview()
//        }
        stack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
            $0.bottom.equalTo(signUpForm.snp.top).offset(-10)
        }
        signUpForm.snp.makeConstraints {
//            $0.top.lessThanOrEqualTo(subtitleLabel.snp.bottom).offset(50)
//            $0.top.greaterThanOrEqualTo(subtitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
//            $0.height.equalToSuperview().multipliedBy(0.72)
//            $0.height.greaterThanOrEqualTo(534)
            $0.bottom.equalToSuperview()
//            $0.height.lessThanOrEqualTo(330)
            
        }
    }
    

}


protocol SignUpFormDelegate: AnyObject {
    func singUpTapped(_ form: SignUpFormView)
}

extension SignUpVC: SignUpFormDelegate {
    func singUpTapped(_ form: SignUpFormView) {
        navigationController?.pushViewController(FirstPageVC(), animated: true)
    }

}


struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SignUpVC {
        return SignUpVC()
    }
    
    func updateUIViewController(_ uiViewController: SignUpVC, context: Context) {
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
