//
//  Calculator.swift
//  Calculator
//
//  Created by Елизавета Каранкевич on 08.03.2025.
//

import Foundation






func calculator() {
    let num1 = input("Введите первое число")
    let operation = inputOperator("Введите оператор: +, -, *, /, ^, %")
    let num2 = input("Введите второе число")



    switch operation {
    case "+":
        print("\(num1.formatNumber()) + \(num2.formatNumber()) = \(MathOperations.sum(num1, num2))")
    case "-":
        print("\(num1.formatNumber()) - \(num2.formatNumber()) = \(MathOperations.subtract(num1, num2))")
    case "*":
        print("\(num1.formatNumber()) * \(num2.formatNumber())  = \(MathOperations.multiply(num1, num2))")
    case "/":
        if num2 == 0 {
            print("Деление на ноль невозможно")
        } else {
            print("\(num1.formatNumber()) / \(num2.formatNumber()) = \(MathOperations.divide(num1, num2))")
        }
    case "^":
        print("\(num1.formatNumber()) ^ \(num2.formatNumber())  = \(MathOperations.power(num1, num2))")
    case "%":
        if num2 == 0 {
            print("Деление на ноль невозможно")
        } else {
            print("\(num1.formatNumber()) % \(num2.formatNumber()) =\(MathOperations.getRestDevided(Int(num1), Int(num2)))")
        }
    default:
        print("Такой операции нет")
    }
}
