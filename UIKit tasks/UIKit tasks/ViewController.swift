//
//  ViewController.swift
//  UIKit tasks
//
//  Created by Елизавета Каранкевич on 22.03.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // Основные элементы
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var switchColorText: UISwitch!
    
    
    // констрейнты для изменения
    @IBOutlet var labelCenterX: NSLayoutConstraint! //центрирование лэйбла по Х
    @IBOutlet var textFieldCenterX: NSLayoutConstraint! // центрирование тэестфилд по Х
    @IBOutlet var buttonCenterX: NSLayoutConstraint! // центрирование кнопки по Х
    @IBOutlet var imgCenterX: NSLayoutConstraint! // центрирование картинки по Х
    @IBOutlet var labelButtomConstr: NSLayoutConstraint! // вертикальный отступ от лэйбл до тэкстфилд
    @IBOutlet var buttonButtomConst: NSLayoutConstraint! // вертикальный оступ от кнопки до картинки
    @IBOutlet var textFieldButtomConst: NSLayoutConstraint! // вертикальный отступ от тэкстфилд до кнопки
    @IBOutlet var switchCenterX: NSLayoutConstraint! // центрирование свитч по х
    @IBOutlet var switchTop: NSLayoutConstraint! // отступ свитч от кнопки
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // задаем текст Label
        label.text = "Здесь появится текст"
        
        // чуть стилизуем кнопку
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        
        // чуть стилизуем  textFiled
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        
        // загружжаем картинку
        img.image = UIImage(named: "img")
        
    }
    
    // поворот экрана
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            let isLandscape = size.width > size.height
            
            if isLandscape {
                self.labelButtomConstr.constant = 20
                self.textFieldButtomConst.constant = 20
                self.buttonButtomConst.isActive = false
                self.labelCenterX.constant = -size.width / 4
                self.textFieldCenterX.constant = -size.width / 4
                self.buttonCenterX.constant = -size.width / 4
                self.imgCenterX.constant = size.width / 4
                self.img.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                self.switchCenterX.constant = -size.width / 4
                self.switchTop.constant = 20
                
            } else {
              
                self.buttonButtomConst.isActive = true
                self.labelButtomConstr.constant = 50
                self.textFieldButtomConst.constant = 60
                self.labelCenterX.constant = 0
                self.textFieldCenterX.constant = 0
                self.buttonCenterX.constant = 0
                self.imgCenterX.constant = 0
                self.switchTop.constant = 300
                self.switchCenterX.constant = 0
                print("labelCenterX: \(self.labelCenterX.constant)")
                print("labelButtomConstr: \(self.labelButtomConstr.constant)")
            }
        }, completion: nil)
    }
    
    // что происходит при нажатии на кнопку
    @IBAction func pressButton() {
        if let text = textField.text, !text.isEmpty {
            label.text = text
        } else {
            label.text = "Поле ввода пустое"
        }
    }
    
    @IBAction func changeLabelColor() {
        if switchColorText.isOn {
            label.textColor = .blue
        } else {
            label.textColor = .black
        }
    }
    
    
}

