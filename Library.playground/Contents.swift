import Cocoa

//Ты создаёшь систему учёта ĸниг в библиотеĸе. В системе есть пользователи, ĸниги и
//библиотеĸарь.
//Что нужно сделать:
//1. Создать ĸласс Book :
//Свойства: title , author , year , isAvailable (по умолчанию true )
//Метод getDescription() – выводит ĸратĸую информацию о ĸниге
//2. Создать ĸласс User (читатель):
//Свойства: name , borrowedBooks (массив ĸниг)
//Метод borrowBook(book: Book) – взять ĸнигу (если доступна)
//Метод returnBook(book: Book) – вернуть ĸнигу
//3. Создать ĸласс Librarian (библиотеĸарь):
//Метод findBook(byTitle title: String, in books: [Book]) -> Book? – найти
//ĸнигу по названию
//4. Метод listAvailableBooks() – вывести все доступные ĸниги
//Создать массив ĸниг и пользователей.
//5. Смоделировать следующий сценарий:
//Библиотеĸарь поĸазывает списоĸ доступных ĸниг .
//Пользователь берёт ĸнигу.
//Пользователь возвращает ĸнигу.
//Библиотеĸарь снова поĸазывает списоĸ доступных ĸниг .
//Пример результата в ĸонсоли:
//Доступные книги:
//- Гарри Поттер
//- Властелин Колец
//Пользователь Дмитрий берёт книгу «Гарри Поттер»
//Доступные книги:
//- Властелин Колец
//Пользователь Дмитрий возвращает книгу «Гарри Поттер»
//Доступные книги:
//- Гарри Поттер
//- Властелин Колец

// MARK: - Пометка преподавателя
/*
Отличная работа! Вы грамотно использовали принципы ООП, создали классы с нужными свойствами и методами, а также реализовали сценарий работы библиотеки. Код структурирован и хорошо читаем. Теперь разберем, что можно улучшить.
*/

class Book {
    var title: String
    var author: String
    var year: Int
    var isAvailable: Bool = true
    
    init(title: String, author: String, year: Int) {
        self.title = title
        self.author = author
        self.year = year
    }
    
    func getDescription() -> String {
        return "\(title) - \(author), \(year)"
    }
}

class User {
    var name: String
    var borrowedBooks: [Book] = []
    
    init(name: String) {
        self.name = name
    }
    
    func borrowBook(book: Book) {
        if book.isAvailable {
            borrowedBooks.append(book)
            book.isAvailable = false
            print("Пользователь \(name) берёт книгу «\(book.title)»")
        } else {
            print("Книга уже взята другим пользователем.")
        }
    }
    
    func returnBook(book: Book) {
        if let index = borrowedBooks.firstIndex(where: { $0.title == book.title }) {
            borrowedBooks.remove(at: index)
            book.isAvailable = true
            print("Пользователь \(name) возвращает книгу «\(book.title)»")
        } else {
            print("У пользователя \(name) нет этой книги.")
        }
    }
    
    func checkBorrowedBooks() {
        if borrowedBooks.isEmpty {
            print("Пользователь \(name) не взял ни одной книги.")
        } else {
            print("Пользователь \(name) взял книги:")
            for book in borrowedBooks {
                print("- \(book.title)")
            }
        }
    }
}

// MARK: - Пометка преподавателя
// MARK: - (Добавьте хранение списка книг в библиотеке)
//
/*
Вместо того чтобы передавать массив книг в метод, можно хранить книги внутри класса Librarian. Это упростит работу с библиотекой.
*/

class Librarian {
    func findBook(byTitle title: String, in books: [Book]) -> Book? {
        return books.first { $0.title == title && $0.isAvailable }
    }
    
    func listAvailableBooks(books: [Book]) {
        let availableBooks = books.filter { $0.isAvailable }
        if availableBooks.isEmpty {
            print("Нет доступных книг.")
        } else {
            print("Доступные книги:")
            for book in availableBooks {
                print("- \(book.title)")
            }
        }
    }
}

// MARK: - Пометка преподавателя
// MARK: - (Создайте библиотеку как отдельный объект)
//
/*
Можно вынести книги в отдельный класс Library, где будут методы добавления, удаления книг и управления доступностью.
*/

var books: [Book] = []
books.append(Book(title: "Гарри Поттер", author: "Дж. Роулинг", year: 1997))
books.append(Book(title: "Властелин колец", author: "Дж. Толкин", year: 1954))
books.append(Book(title: "Песнь льда и Пламени", author: "Дж. Мартин", year: 1996))

let user1 = User(name: "Алекс")
let user2 = User(name: "Елена")

let librarian = Librarian()

let bookName = "Властелин колец"
let bookName2 = "Гарри Поттер"
let bookName3 = "Harry Potter"

// Выводим список доступных книг
librarian.listAvailableBooks(books: books)

// Пользователь берет книгу "Властелин колец"
if let book = librarian.findBook(byTitle: bookName, in: books) {
    user1.borrowBook(book: book)
} else {
    print("Такой книги, к сожалению, нет.")
}

// Проверяем список доступных книг после того, как пользователь взял одну из книг
librarian.listAvailableBooks(books: books)

// Проверка, что у пользователя есть книга
user1.checkBorrowedBooks()

// Проверка, если другой читатель хочет взять уже взятую книгу
if let book = librarian.findBook(byTitle: bookName, in: books) {
    user2.borrowBook(book: book)
} else {
    print("Такой книги, к сожалению, нет.")
}

// Проверка, что пользователь не смог взять недоступную книгу
user2.checkBorrowedBooks()

// Проверка на попытку вернуть книгу, которой у читателя нет
if let book = librarian.findBook(byTitle: bookName, in: books) {
    user2.returnBook(book: book)
} else {
    print("Такой книги, к сожалению, нет.")
}

// Возвращение книги пользователем
if let book = librarian.findBook(byTitle: bookName, in: books) {
    user1.returnBook(book: book)
} else {
    print("Такой книги, к сожалению, нет.")
}

// Проверяем список книг у пользователя после возврата
user1.checkBorrowedBooks()

// Выводим обновленный список доступных книг
librarian.listAvailableBooks(books: books)

/*
Рекомендации:
- Подумайте о создании отдельного класса `Library` для хранения книг и управления ими.
- Можно хранить список книг внутри `Librarian`, чтобы не передавать его в методы.
- В методах `findBook` сейчас книги ищутся только среди доступных, но можно добавить возможность поиска всех книг.
- Отлично реализована проверка на доступность книги, но можно добавить механизм бронирования книг.

Оценка: 9/10. Хорошая структура, но есть куда развивать функциональность. Продолжайте в том же духе!
*/
