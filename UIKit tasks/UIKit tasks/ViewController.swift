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
    
    
    // констрейнты для изменения
    @IBOutlet weak var labelCenterX: NSLayoutConstraint! //центрирование лэйбла по Х
    @IBOutlet weak var textFieldCenterX: NSLayoutConstraint! // центрирование тэестфилд по Х
    @IBOutlet weak var buttonCenterX: NSLayoutConstraint! // центрирование кнопки по Х
    @IBOutlet weak var imgCenterX: NSLayoutConstraint! // центрирование картинки по Х
    @IBOutlet weak var labelButtomConstr: NSLayoutConstraint! // вертикальный отступ от лэйбл до тэкстфилд
    @IBOutlet weak var buttonButtomConst: NSLayoutConstraint! // вертикальный оступ от кнопки до картинки
    @IBOutlet weak var textFieldButtomConst: NSLayoutConstraint! // вертикальный отступ от тэкстфилд до кнопки
    
    
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            let isLandscape = size.width > size.height
            
            if isLandscape {
                print("Переход в landscape")
                self.labelButtomConstr.constant = 20
                self.textFieldButtomConst.constant = 20
                self.buttonButtomConst.isActive = false
                self.labelCenterX.constant = -size.width / 4
                self.textFieldCenterX.constant = -size.width / 4
                self.buttonCenterX.constant = -size.width / 4
                self.imgCenterX.constant = size.width / 4
                
                self.img.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            } else {
                print("Переход в portrait")
                
                self.buttonButtomConst.isActive = true
                self.labelButtomConstr.constant = 50
                self.textFieldButtomConst.constant = 60
                self.labelCenterX.constant = 0
                self.textFieldCenterX.constant = 0
                self.buttonCenterX.constant = 0
                self.imgCenterX.constant = 0
            }
        }, completion: nil)
    }
    
    
    //    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    //        super.traitCollectionDidChange(previousTraitCollection)
    //
    //        updateConstraintsForCurrentTrait()
    //    }
    //
    //    // изменение констрейнтов
    //    private func updateConstraintsForCurrentTrait() {
    //        let isLandscape = UIDevice.current.orientation.isLandscape
    //
    //        if isLandscape {
    //            labelButtomConstr.constant = 20
    //            textFieldButtomConst.constant = 20
    //            buttonButtomConst.isActive = false
    //            labelCenterX.constant = -view.bounds.width / 4
    //            textFieldCenterX.constant = -view.bounds.width / 4
    //            buttonCenterX.constant = -view.bounds.width / 4
    //            imgCenterX.constant = view.bounds.width / 4
    //
    //            img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    //        } else {
    //            buttonButtomConst.constant = 60
    //            buttonButtomConst.isActive = true
    //            labelButtomConstr.constant = 50
    //            textFieldButtomConst.constant = 60
    //            labelCenterX.constant = 0
    //            textFieldCenterX.constant = 0
    //            buttonCenterX.constant = 0
    //            imgCenterX.constant = 0
    //        }
    //        self.view.layoutIfNeeded()
    //    }
    
    // что происходит при нажатии на кнопку
    @IBAction func pressButton() {
        if let text = textField.text, !text.isEmpty {
            label.text = text
        } else {
            label.text = "Поле ввода пустое"
        }
    }
    
    
}

