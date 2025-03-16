//
//  utils.swift
//  Calculator
//
//  Created by Елизавета Каранкевич on 08.03.2025.
//

import Foundation

// расширение, чтобы преобразующее дабл в инт
extension Double {
    func formatNumber() -> Any {
        if self == Double(Int(self)) {
            return Int(self) // Если число целое, возвращаем как Int
        } else {
            return self // Иначе возвращаем как Double
        }
    }
    // округление
    func rounded(toPlaces places: Int) -> Double {
            let divisor = pow(10.0, Double(places))
            return (self * divisor).rounded() / divisor
        }
}

// MARK: - Проверка преподавателя
/*
 Использование enum вместо struct в данном случае может быть более подходящим, потому что:
     1.    Нам не нужно создавать экземпляры MathOperations
     struct предназначен для хранения состояний и создания экземпляров.
     В вашем случае все методы являются статическими, и MathOperations не хранит никаких данных.
     enum с case не нужен, но enum без case отлично подходит для объединения связанных функций.
     2.    Более логичная организация кода
     enum лучше передает смысл “группы функций”, не требуя экземпляров.
      Swift активно использует enum для подобных случаев (JSONDecoder.KeyDecodingStrategy, DispatchQueue.GlobalQueuePriority и т. д.).
     3.    Защита от ненужного наследования
     struct можно случайно расширить или создать его экземпляр, enum — нет.

 */

struct MathOperations {
    static func sum(_ a: Double, _ b: Double) -> Any {
        return (a + b).formatNumber()
    }
    
    static func subtract(_ a: Double, _ b: Double) -> Any {
        return (a - b).formatNumber()
    }
    
    static func multiply(_ a: Double, _ b: Double) -> Any {
        return (a * b).formatNumber()
    }
    
    static func divide(_ a: Double, _ b: Double) -> Any {
        return (a / b).formatNumber()
    }
    
    static func power(_ a: Double, _ b: Double) -> Any {
        return pow(a, b).formatNumber()
    }
    
    static func getRestDevided(_ a: Int, _ b: Int) -> Any {
        return a % b
    }
}

//обработка ввода мат операции
func inputOperator(_ text: String) -> String {
    print(text)
    while true {
        if let operation = readLine(), ["+", "-", "*", "/", "^", "%"].contains(operation) {
            return operation
        } else {
            print("Вы ввели некорректный оператор, попробуйте снова.")
        }
    }
}

// обработка ввода пользователем чисел
func input(_ text: String) -> Double {
    print(text)
    while true {
        //раскрываем String?
        if let userInput = readLine() {
            // проверяем можно ли введенное преобразовать в дабл ( то есть число ли это)
            if let number = Double(userInput) {
                return number
            } else {
                print("Вы ввели не число, попробйте снова.")
            }
        } else {
            print("Ошибка ввода.")
        }
    }
}

func inputArrayLength(_ text: String) -> Int {
    while true {
            let length = input(text) // здесь дабл
            
            // Переводим в инт, для сравнения обратно в дабл
            if Double(Int(length)) == length && length > 0 {
                return Int(length)
            } else {
                print("Длина массива должна быть положительным целым числом. Попробуйте снова.")
            }
        }
    
}
