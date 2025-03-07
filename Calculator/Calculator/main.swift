//
//  main.swift
//  Calculator
//
//  Created by Елизавета Каранкевич on 07.03.2025.
//

import Foundation

func main() {
    print("Выберите режим:")
    print("1 - Калькулятор чисел")
    print("2 - Калькулятор массива")
    
    while true {
        if let userChoice = readLine(), let calc = Int(userChoice) {
            switch calc {
            case 1:
                calculator()
                return
            case 2:
                arrayOperations()
                return
            default:
                print("Некорректный выбор. Введите 1 или 2.")
            }
        } else {
            print("Некорректный ввод. Введите 1 или 2.")
        }
    }
}

main()
