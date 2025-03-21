//
//  main.swift
//  Calculator
//
//  Created by Елизавета Каранкевич on 07.03.2025.
//

import Foundation

/*
Отличная работа! Вы грамотно структурировали код, разделив его на файлы, что делает программу более удобной в поддержке. Использование `switch`, `reduce`, `.formatNumber()` и проверки ввода делают решение надежным и читабельным. Молодцы!

Теперь несколько рекомендаций для улучшения:
*/

// MARK: - (Оптимизация кода) - Стоит ли использовать `Any`?
//
/*
В некоторых местах, например, в `MathOperations`, методы возвращают `Any`, что может усложнить работу с типами. Почему не оставить `Double` или `Int` и преобразовывать при выводе?
*/

// MARK: - (Расширение проверок) - Можно ли улучшить обработку ввода?
//
/*
Функция `readLine()` в `main.swift` обрабатывает только корректный ввод, но если ввести пробелы или неожиданные символы, программа может вести себя непредсказуемо. Как можно добавить более строгие проверки?
*/

// MARK: - (Повторяющийся код) - Можно ли объединить вычисления?
//
/*
В `arrayOperations()` несколько раз вызывается `reduce(0, +)`, а затем используется `.max()` и `.min()`. Можно ли сократить количество повторяющихся вычислений?
*/

/*
Рекомендации:
- Глубже изучите работу с `Any` и альтернативы, чтобы код был более предсказуемым.
- Подумайте над улучшением валидации пользовательского ввода.
- Возможно, стоит добавить обработку пустого массива перед вычислениями.

Оценка: 9.5/10. Код отличный, но есть небольшие моменты для улучшения. Продолжайте в том же духе! 🚀
*/

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
