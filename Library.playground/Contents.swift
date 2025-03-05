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
            print("Пользователь \(name) берёт книгу \(book.title)")
        } else {
            print("Книга уже взята другим читателем")
        }
    }
    
    func returnBook(book: Book) {
        if !borrowedBooks.contains(where: { $0 === book }) {
            print("Книги \(book.title) у читателя \(name) нет")
        } else {
            
            book.isAvailable = true
            borrowedBooks.removeAll { $0 === book }
            print("Пользователь \(name) возвращает книгу \(book.title)")
        }
    }
    
    func checkBorrowedBooks() -> () {
        borrowedBooks.isEmpty ? print("У читателя \(name) нет книг") : borrowedBooks.forEach {book in print("Книги у \(name): \(book.getDescription())")}
    }
}

class Librarian {
    func findBook (byTitle title: String, in books: [Book]) -> Book? {
        for book in books {
            if book.title == title {
                return book
            }
        }
        return nil
    }
    
    func listAvailableBooks(books: [Book]) -> () {
        var availableBooks: String = "Доступные книги:\n"
        for book in books {
            if book.isAvailable {
                availableBooks += "- \(book.title)\n"
            }
        }
        print(availableBooks)
    }
}

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

// выводим все доступные книги
librarian.listAvailableBooks(books: books)

// пользователь берет книгу Властелин колец, а для этого библиотекарь ее находит
if let book = librarian.findBook(byTitle: bookName, in: books) {
    user1.borrowBook(book: book)
} else {
    print("Такой книги, к сожалению, нет")
}
// проверяем список доступных книг после того как пользователь взял одну из книг
librarian.listAvailableBooks(books: books)
//проверка что у пользователя есть книга
user1.checkBorrowedBooks()

// проверка если другой читатель захочет взять книгу, уже взятую другим читателем
if let book = librarian.findBook(byTitle: bookName, in: books) {
    user2.borrowBook(book: book)
} else {
    print("Такой книги, к сожалению, нет")
}
// проверка, что пользователь не получилось взять недоступную книгу
user2.checkBorrowedBooks()


if let book = librarian.findBook(byTitle: bookName3, in: books) {
    user2.borrowBook(book: book)
} else {
    print("Такой книги, к сожалению, нет")
}

// проверка на попытку вернуть книгу, которой у читателя нет
if let book = librarian.findBook(byTitle: bookName, in: books) {
    user2.returnBook(book: book)
} else {
    print("Такой книги, к сожалению, нет")
}

if let book = librarian.findBook(byTitle: bookName, in: books) {
    user1.returnBook(book: book)
} else {
    print("Такой книги, к сожалению, нет")
}

user1.checkBorrowedBooks()
librarian.listAvailableBooks(books: books)
