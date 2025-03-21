//
//  ArrayOperations.swift
//  Calculator
//
//  Created by Елизавета Каранкевич on 08.03.2025.
//

import Foundation

func arrayOperations() {
    let arraylength = inputArrayLength("Напишите количество элементов массива")
    var array: [Double] = []
    for i in 0..<arraylength {
        let element = input("Введите \(i + 1)-й элемент массива")
        array.append(element)
    }
    let sum = array.reduce(0, +).formatNumber()
    let avg = (array.reduce(0, +) / Double(arraylength)).rounded(toPlaces: 2).formatNumber()
    print("Массив: \(array.map { "\($0.formatNumber())" }.joined(separator: ", "))")
    print("Сумма всех элементов массива: \(sum)")
    print("Среднее арифметическое: \(avg)")
    print("Максимально чило: \((array.max() ?? 0).formatNumber())")
    print("Минимальное число: \((array.min() ?? 0).formatNumber())")
}


