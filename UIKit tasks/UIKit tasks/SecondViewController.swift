//
//  SecondViewController.swift
//  UIKit tasks
//
//  Created by Елизавета Каранкевич on 22.03.2025.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerText = ["Текст 1", "Текст 2", "Текст 3", "Текст 4"] // данные для пикера
    
    // Основные элементы
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sliderNumLabel: UILabel!
    
    // нажатие кнопки
    @IBAction func pressAlertBut(_ sender: Any) {
        
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
    
    // констрейнты
    @IBOutlet var sliderBottomConstr: NSLayoutConstraint! // отступ от низа до слайдера
    @IBOutlet var butAlertCenterX: NSLayoutConstraint! // центрирование кнопки для отображения алерта
    @IBOutlet var butAlertButtom: NSLayoutConstraint! // отступ от низа до кнопки
    
    
    @IBAction func sliderValue(_ sender: Any) {
        sliderNumLabel.text = String(Int(slider.value))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        sliderNumLabel.text = String(Int(slider.value))
        label.text = "Здесь появится текст из пикера"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateConstraints() // применение нужных констрейнтов
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.updateConstraints()
        }, completion: nil)
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
    
    // корректировка констрейнтов под разное расположение экрана
    private func updateConstraints() {
        let isLandscape = view.bounds.width > view.bounds.height
        
        if isLandscape {
            sliderBottomConstr.constant = 20
            butAlertButtom.constant = 20
            butAlertCenterX.constant = -view.bounds.width / 3
        } else {
            sliderBottomConstr.constant = 60
            butAlertButtom.constant = 200
            butAlertCenterX.constant = 0
        }
    }
}


