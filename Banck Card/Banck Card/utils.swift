//
//  utils.swift
//  Banck Card
//
//  Created by Елизавета Каранкевич on 06.04.2025.
//

import Foundation
import UIKit

func makeGradientLayer(with colors: [UIColor], frame: CGRect) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = frame

    guard colors.count == 2 else {
        print("Ошибка: массив должен содержать ровно два цвета.")
        return gradientLayer
    }

    gradientLayer.colors = colors.map { $0.cgColor }
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

    return gradientLayer
}

let greenGrad = UIColor(red: 0/255, green: 63/255, blue: 50/255, alpha: 1)
let violetGrad = UIColor(red: 69/255, green: 0/255, blue: 93/255, alpha: 1)
let orangeGrad = UIColor(red: 250/255, green: 198/255, blue: 166/255, alpha: 1)
let redGrad = UIColor(red: 138/255, green: 0/255, blue: 4/255, alpha: 1)
let blueGrad = UIColor(red: 39/255, green: 113/255, blue: 161/255, alpha: 1)
let lightOrangeGrad = UIColor(red: 147/255, green: 38/255, blue: 27/255, alpha: 1)

let red: [UIColor] = [.cardRed, redGrad]
let orange: [UIColor] = [.cardOrange, orangeGrad]
let lightorange: [UIColor] = [.cardLightOrange, lightOrangeGrad]
let green: [UIColor] = [.cardGreen, greenGrad]
let blue: [UIColor] = [.cardBlue, blueGrad]
let violet: [UIColor] = [.cardViolet, violetGrad]


let gradients = [red, orange, lightorange, green, blue, violet]
