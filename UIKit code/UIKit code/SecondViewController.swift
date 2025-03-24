//
//  SecondViewController.swift
//  UIKit code
//
//  Created by Елизавета Каранкевич on 24.03.2025.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let label = UILabel()
    let picker = UIPickerView()
    let slider = UISlider()
    let sliderNumLabel = UILabel()
    let btnForAlert = UIButton()
    let backBtn = UIButton()
    
    
    var pickerText = ["Текст 1", "Текст 2", "Текст 3", "Текст 4"] // данные для пикера
    
    var portraitConstraints: [NSLayoutConstraint]!
    var landscapeConstraints: [NSLayoutConstraint]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabel()
        setupPicker()
        setupSlider()
        setupsliderNumLabel()
        setupBtnForAlert()
        setupBackBtn()
        
        setupConstraints()
        updateConstraintsForCurrentTraitCollection()
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
        label.text = "Лэйбл для пикера"
        label.font = .systemFont(ofSize: 32) //шрифт
        label.textColor = UIColor(red: 69/255, green: 64/255, blue: 61/255, alpha: 1) //цвет
        label.textAlignment = .center // центрирование текста внутри блока
        label.numberOfLines = 0 // несколько строк
        label.lineBreakMode = .byWordWrapping // перенос текста
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: steupPicker
    private func setupPicker() {
        picker.delegate = self
        picker.dataSource = self
        view.addSubview(picker)
        picker.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // кол-во столбцов в пикере
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // кол-во строк в пикере
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerText.count
    }
    
    // текст строк пикера
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerText[row]
    }
    
    // меняем текст лэйбла на выбор в пикере
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = pickerText[row]
    }
    
    //MARK: setupSlider
    private func setupSlider() {
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValue), for: .valueChanged)
    }
    
    // MARK: setupsliderNumLabel
    private func setupsliderNumLabel() {
        sliderNumLabel.text = String(Int(slider.value))
        view.addSubview(sliderNumLabel)
        sliderNumLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: setupBtnForAlert
    private func setupBtnForAlert() {
        btnForAlert.setTitle("Кнопка алерта", for: .normal)
        btnForAlert.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.7)
        btnForAlert.setTitleColor(.black, for: .normal)
        btnForAlert.layer.borderWidth = 1
        btnForAlert.layer.borderColor = UIColor.gray.cgColor
        
        view.addSubview(btnForAlert)
        btnForAlert.translatesAutoresizingMaskIntoConstraints = false
        btnForAlert.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    // MARK: setupBackBtn
    private func setupBackBtn() {
        backBtn.setTitle("Back", for: .normal)
        backBtn.setTitleColor(.systemBlue, for: .normal)
        
        view.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    // MARK: setupConstraints
    private func setupConstraints() {
        portraitConstraints = [
            //для лэйбла
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picker.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 20),
            slider.widthAnchor.constraint(equalToConstant: 300),
            sliderNumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sliderNumLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            btnForAlert.topAnchor.constraint(equalTo: sliderNumLabel.bottomAnchor, constant: 20),
            btnForAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnForAlert.widthAnchor.constraint(equalToConstant: 150),
            
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
        ]
        
        landscapeConstraints = [
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 350),
            
            
            picker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picker.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 20),
            slider.widthAnchor.constraint(equalToConstant: 300),
            
            sliderNumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sliderNumLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            
            btnForAlert.widthAnchor.constraint(equalToConstant: 150),
            btnForAlert.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            btnForAlert.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
        ]
    }
    
    private func updateConstraintsForCurrentTraitCollection() {
        NSLayoutConstraint.deactivate(portraitConstraints + landscapeConstraints)
        
        let isLandscape = view.bounds.width > view.bounds.height
        
        if isLandscape {
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            NSLayoutConstraint.activate(portraitConstraints)
        }
        view.layoutIfNeeded()
    }
    
    @objc func sliderValue() {
        sliderNumLabel.text = String(Int(slider.value))
    }
    
    @objc func showAlert() {
        //  создаем алерт
        let alert = UIAlertController(
            title: "Всплывающее окно",
            message: "Ура, алерт открылся!",
            preferredStyle: .alert
        )
        
        // создаем алерт эшкн
        let okAction = UIAlertAction(
            title: "OK", // это написано на кнопке
            style: .default
        )
        
        // Добавляем действие в Alert
        alert.addAction(okAction)
        
        // Показываем Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func goBack() {
        dismiss(animated: true)
    }
}
