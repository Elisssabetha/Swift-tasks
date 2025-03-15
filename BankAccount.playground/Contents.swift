import Cocoa

//Проеĸт: «Банĸовсĸий счёт»
//Что нужно сделать:
//1. Создать перечисление TransactionType ( deposit , withdrawal ).
//2. Создать струĸтуру Transaction со свойствами:
//type : тип операции
//amount : сумма
//date : дата операции
//3. Создать ĸласс BankAccount :
//Свойства:
//accountNumber : номер счёта
//balance : баланс (по умолчанию 0)
//transactions : массив транзаĸций
//Методы:
//deposit(amount: Double) – пополнение баланса
//withdraw(amount: Double) – снятие денег (если хватает средств)
//printStatement() – вывод истории операций
//4. Создать ĸласс Bank :
//Свойство: массив счетов ( accounts )
//Методы:
//createAccount() – создаёт новый счёт и добавляет в массив
//findAccount(byNumber: String) – ищет счёт по номеру

//5. Смоделировать сценарий:
//Создать банĸ
//Отĸрыть счёт для Дмитрия
//Пополнить счёт на 1000
//Снять 200
//Вывести историю операций

//Пример результата в ĸонсоли:
//Счёт открыт: 12345678
//Пополнение: 1000.0 ₽ (12.02.2025)
//Снятие: 200.0 ₽ (13.02.2025)
//История операций:
//1. Пополнение: 1000 ₽
//2. Снятие: 200 ₽
//Баланс: 800 ₽


/*
 Отличная работа!

 Вы проделали большую работу над реализацией банковской системы, охватив все ключевые аспекты: учет транзакций, работу с пользователями, операции пополнения и снятия средств. Отлично использовали enum, struct, class и extension. Видно, что продумана логика и использованы слабые ссылки (weak) для предотвращения утечек памяти. Код читаемый, логично структурирован и сопровожден комментариями — это большой плюс!
 */

import Cocoa

enum TransactionType: String {
    case deposit = "Пополнение"
    case withdrawal = "Снятие"
}

// замыкание для для даты в нужном виде
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter
}()

struct Transaction {
    let type: TransactionType
    let amount: Double
    let date: Date
    
    func printInfo() {
        print("\(type.rawValue): \(amount) ₽ (\(dateFormatter.string(from: date)))")
    }
}

class BankAccount {
    let accountNumber: Int
    private var balance: Double = 0
    var transactions: [Transaction] = []
    weak var user: User?
    
    init(accountNumber: Int, user: User) {
        self.accountNumber = accountNumber
        self.user = user
        user.accounts.append(self)
    }
    
    // MARK: - Здесь можно добавить guard, чтобы упростить проверку
    func deposit(amount: Double, date: Date? = nil) {
        if amount <= 0 {
            print("Неверно указана сумма для пополнения счета")
            return
        } else {
            balance += amount
            //вывод инфо что за счет пополняется и кто владелец
            print("Счет №\(accountNumber) (\(user?.name ?? "Неизвестно") \(user?.surname ?? "Неизвестно")) - операция: ", terminator: "")
            let transaction = Transaction(type: .deposit, amount: amount, date: date ?? Date())
            transactions.append(transaction)
            transaction.printInfo()
        }
    }
    
    // MARK: - Что будет, если средств недостаточно? Возможно, стоит добавить проверку перед снятием?
    // MARK: - Здесь можно добавить guard, чтобы упростить проверку
    func withdraw(amount: Double, date: Date? = nil) {
        if amount <= 0 {
            print("Неверно указана сумма для снятия со счета")
            return
        } else {
            balance -= amount
            //вывод инфо с какого счета снимается и кто владелец
            print("Счет №\(accountNumber) (\(user?.name ?? "Неизвестно") \(user?.surname ?? "Неизвестно")) - операция: ", terminator: "")
            let transaction = Transaction(type: .withdrawal, amount: amount, date: date ?? Date())
            transactions.append(transaction)
            transaction.printInfo()
        }
    }
    
    func printBalance() {
        print("Сумма на счету № \(accountNumber) у \(user?.name ?? "Неизвестно") \(user?.surname ?? "Неизвестно"): \(balance) ₽")
    }
    
    func printStatement() {
        print("История операций по счету №\(accountNumber) (\(user?.name ?? "Неизвестно") \(user?.surname ?? "Неизвестно")):")
        for (index, transaction) in transactions.enumerated() {
            print("\(index + 1). ", terminator: "") // terminator - предотвращает перенос на новую строку
            transaction.printInfo()
        }
    }
}

class Bank {
    var accounts: [BankAccount] = []
    
    // MARK: - Почему номер счета зависит от количества счетов? Возможно, стоит генерировать случайный ID?
    func createAccount(for user: User) {
        // авторский произвол, что счет может открыть только совершеннолетний
        if user.isAdult {
            let newAccount = BankAccount(accountNumber: accounts.count + 1, user: user)
            accounts.append(newAccount)
            print("Открыт счет № \(newAccount.accountNumber), владелец счета: \(newAccount.user?.name ?? "Неизвестно") \(newAccount.user?.surname ?? "Неизвестно")")
        } else {
            print("Не удалось открыть счет для \(user.name) \(user.surname), так как открыть счет можно только совершеннолетним пользователям")
        }
    }
    
    func findAccount(byNumber: Int) -> BankAccount? {
        return accounts.first { $0.accountNumber == byNumber }
    }
}

class User {
    let name: String
    let surname: String
    var age: Int
    var isAdult: Bool {
        return age >= 18
    }
    var accounts: [BankAccount] = []
    
    init(name: String, surname: String, age: Int) {
        self.name = name
        self.surname = surname
        self.age = age
    }
    
}

extension User {
//    для вывода информации по тому, какие счета открыты у юзера
    var accountsInfo: String {
        if accounts.isEmpty {
            return "У пользователя \(name) \(surname) нет открытых счетов."
        } else {
            let accountNumbers = accounts.map { "\($0.accountNumber)" }
            let accountsString = accountNumbers.joined(separator: ", ")
            return "У пользователя \(name) \(surname) открыты счета № \(accountsString)"
        }
    }
}

// Создание банка и пользователей
let bank = Bank()
let user1 = User(name: "Дмитрий", surname: "Поляков", age: 19)
let user2 = User(name: "Алексей", surname: "Петров", age: 17)
let user3 = User(name: "Анна", surname: "Николаева", age: 25)

// Открытие счетов
bank.createAccount(for: user1)
bank.createAccount(for: user2)
bank.createAccount(for: user3)
bank.createAccount(for: user3)

let accountNumber = 1
let dateForm = dateFormatter
dateForm.dateFormat = "dd.MM.yyyy"

// Проверка работы счета
if let account1 = bank.findAccount(byNumber: accountNumber) {
    account1.deposit(amount: 100000)
    account1.printBalance()
    account1.withdraw(amount: 5000, date: dateForm.date(from: "18.03.2025"))
    account1.printStatement()
    account1.printBalance()
} else {
    print("Счет №\(accountNumber) не найден")
}

// Вывод информации о счетах пользователя
print(user3.accountsInfo)
    
/*
 Что можно улучшить:
     1.    Проверка остатка перед снятием – сейчас баланс уходит в минус, стоит добавить guard или if balance >= amount, чтобы избежать этого.
     2.    Генерация номеров счетов – сейчас зависит от длины массива, но что будет, если удалится счет? Лучше использовать UUID или случайный ID.
     3.    Разделение логики вывода и логики операций – возможно, стоит вынести форматирование и печать в отдельный класс, чтобы BankAccount отвечал только за работу со счетами.
     4.    Добавить struct вместо класса User – если User не предполагает сложных изменяемых состояний, его можно сделать struct.

 Итог:
     •    Читаемость: 9/10
     •    Рабочая логика: 9/10
     •    Потенциал улучшений: 8/10
     •    Оценка: 9/10 – отличная работа! Немного доработок, и будет супер!

 Вы молодец, продолжайте в том же духе! 🚀
 */
