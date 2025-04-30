//
//  LoginVC.swift
//  Delivery
//
//  Created by Елизавета Каранкевич on 22.04.2025.
//

import UIKit
import SwiftUI
import SnapKit

class LoginVC: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Log In"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Please sign in to your existing account"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginForm: LoginForm = {
        let view = LoginForm()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let views = [titleLabel, subtitleLabel, loginForm]
        views.forEach { view.addSubview($0) }
        
        setupConstraints()
        
        loginForm.delegate = self
        navigationItem.hidesBackButton = true
        
        //меняет кнопку назад на следующем экране
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(
                title: "",
                image: UIImage(named: "backBtn")?.withAlignmentRectInsets(UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)),
                primaryAction: nil,
                menu: nil
            )

        
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(65) //макет 121
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        loginForm.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(subtitleLabel.snp.bottom).offset(50)
            $0.top.greaterThanOrEqualTo(subtitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
            $0.height.lessThanOrEqualTo(620)
        }
    }
    

}

protocol LoginFormDelegate: AnyObject {
    func loginTapped(_ form: LoginForm)
    func forgotPasswordTapped(_ form: LoginForm)
    func signupTapped(_ form: LoginForm)
}

extension LoginVC: LoginFormDelegate {
    func loginTapped(_ form: LoginForm) {
        navigationController?.pushViewController(FirstPageVC(), animated: true)
    }
    
    func forgotPasswordTapped(_ form: LoginForm) {
        navigationController?.pushViewController(ForgotPasswordVC(), animated: true)
    }
    
    func signupTapped(_ form: LoginForm) {
        navigationController?.pushViewController(SignUpVC(), animated: true)
    }
}



// штука для предпросмотра
//struct ViewControllerWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> LoginVC {
//        return LoginVC()
//    }
//    
//    func updateUIViewController(_ uiViewController: LoginVC, context: Context) {
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
