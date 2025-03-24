//
//  ViewController.swift
//  UIKit code
//
//  Created by Елизавета Каранкевич on 24.03.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // элементы
    let label = UILabel()
    let btn = UIButton()
    let textField = UITextField()
    let img = UIImageView()
    let swtch = UISwitch()
    let btn2ndPage = UIButton()
    
    var portraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
        setupBtn()
        setupTextField()
        setupImg()
        setupSwitch()
        setupBtn2ndPage()
        
        // констрейнты
        setupConstraints()
    }
    
    // MARK: viewWillTransition
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            let isLandscape = size.width > size.height
            NSLayoutConstraint.deactivate(self.portraitConstraints + self.landscapeConstraints)
            
            if isLandscape {
                NSLayoutConstraint.activate(self.landscapeConstraints)
            } else {
                NSLayoutConstraint.activate(self.portraitConstraints)
                
            }
        }, completion: nil)
    }
    
    // MARK: setupLabel
    private func setupLabel() {
        //стилизация лэйбла
        label.text = "Текст лэйбла"
        label.font = .systemFont(ofSize: 32) //шрифт
        label.textColor = UIColor(red: 69/255, green: 64/255, blue: 61/255, alpha: 1) //цвет
        label.textAlignment = .center // центрирование текста внутри блока
        label.numberOfLines = 0 // несколько строк
        label.lineBreakMode = .byWordWrapping // перенос текста
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: setupBtn
    private func setupBtn() {
        //стилизация кнопки
        btn.setTitle("Изменить текст", for: .normal) //надпись на кнопке
        btn.setTitleColor(.black, for: .normal) // цвет надписи
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 28) // шрифт
        btn.backgroundColor = UIColor(red: 127/255, green: 255/255, blue: 0/255, alpha: 0.5) //цвет фона
        btn.layer.cornerRadius = 20 // скругление рамки
        btn.layer.borderWidth = 1 // толщина рамки
        btn.layer.borderColor = UIColor.black.cgColor // цвет рамки
        
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        // нажатие на кнопку
        btn.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
    }
    
    // MARK: setupTextField
    private func setupTextField() {
        // стилизация textField
        textField.backgroundColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 0.5) // цвет фона
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.textAlignment = .center
        textField.textColor = UIColor(red: 69/255, green: 64/255, blue: 61/255, alpha: 1)
        textField.font = .systemFont(ofSize: 28)
        textField.placeholder = "Введите текст"
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    //MARK: setupImg
    private func setupImg() {
        img.image = UIImage(named: "img")
        view.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: setupSwitch
    private func setupSwitch() {
        view.addSubview(swtch)
        swtch.translatesAutoresizingMaskIntoConstraints = false
        //переключалка цвета
        swtch.addTarget(self, action: #selector(switching), for: .valueChanged)
    }
    
    //MARK: setup2ndBntPage
    private func setupBtn2ndPage() {
        btn2ndPage.setTitle("2nd Page", for: .normal)
        btn2ndPage.backgroundColor = UIColor(red: 255/255, green: 192/255, blue: 203/255, alpha: 0.5)
        btn2ndPage.setTitleColor(.black, for: .normal)
        btn2ndPage.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn2ndPage.layer.borderWidth = 1
        btn2ndPage.layer.borderColor = UIColor.gray.cgColor
        
        
        
        btn2ndPage.addTarget(self, action: #selector(push2ndPageBtn), for: .touchUpInside)
        view.addSubview(btn2ndPage)
        btn2ndPage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: setupConstraints
    private func setupConstraints() {
        portraitConstraints = [
            //для лэйбла
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            btn.widthAnchor.constraint(equalToConstant: 300),
            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 40),
            
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            img.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            img.topAnchor.constraint(equalTo: swtch.bottomAnchor, constant: 30),
            img.heightAnchor.constraint(equalTo: img.widthAnchor, multiplier: 0.625),
            
            swtch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swtch.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 40),
            
            btn2ndPage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            btn2ndPage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            btn2ndPage.widthAnchor.constraint(equalToConstant: 100),
        ]
        
        landscapeConstraints = [
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.widthAnchor.constraint(equalToConstant: 250),
            
            btn.widthAnchor.constraint(equalToConstant: 250),
            btn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            btn.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            img.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            img.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            img.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
            img.heightAnchor.constraint(equalTo: img.widthAnchor, multiplier: 0.625),
            
            swtch.topAnchor.constraint(equalTo: btn.bottomAnchor, constant: 20),
            swtch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 135),
            
            btn2ndPage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            btn2ndPage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            btn2ndPage.widthAnchor.constraint(equalToConstant: 100),
            
        ]
        
        NSLayoutConstraint.activate(portraitConstraints)
    }
    
    //MARK: pushButton
    @objc func pushButton() {
        textField.resignFirstResponder()
        label.textColor = UIColor(red: 69/255, green: 64/255, blue: 61/255, alpha: 1)
        
        if let userText = textField.text, !userText.isEmpty {
            label.text = userText
            textField.text = "" //убираем введенный текст из тэкстфилд
        } else {
            label.text = "Вы ничего не ввели"
            label.textColor = .systemRed
        }
    }
    // MARK: switchng
    @objc func switching() {
        if swtch.isOn {
            label.textColor = .blue
        } else {
            label.textColor = UIColor(red: 69/255, green: 64/255, blue: 61/255, alpha: 1)
        }
    }
    
    @objc func push2ndPageBtn() {
//        navigationController?.pushViewController(SecondViewController(), animated: true)
        present(SecondViewController(), animated: true)
    }
    
}

