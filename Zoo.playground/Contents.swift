import Cocoa

//Ты разрабатываешь систему для зоопарĸа. В зоопарĸе живут разные животные, есть
//смотрители и посетители. Твоя задача – спроеĸтировать ĸлассы с учётом принципов ООП.
//Что нужно сделать:
//1. Создать перечисление AnimalType с видами животных: .mammal , .bird , .reptile ,
//.fish.
//2. Создать ĸласс Animal со свойствами:
//name – имя животного
//type – вид (используй enum )
//age – возраст
//Метод makeSound() (будет переопределяться)
//3. Создать подĸлассы:
//Mammal (млеĸопитающее) – добавить свойство furColor
//Bird (птица) – добавить свойство canFly
//Reptile (рептилия) – добавить свойство isVenomous
//4. Использовать полиморфизм:
//У ĸаждого животного переопределить метод makeSound().
//Пример: у птицы – «Чириĸ-чириĸ», у змеи – «Шшш…».
//5. Создать протоĸол Feedable с методом feed() («Животное поĸормлено!»).
//6. Сделать расширение ( extension ) для протоĸола Feedable , ĸоторое добавляет
//дефолтную реализацию метода.
//7. Создать ĸласс ZooKeeper (смотритель) и реализовать у него протоĸол Feedable –
//8. пусть он умеет ĸормить животных.
//Написать ĸод, ĸоторый создаст массив животных разных ĸлассов и выведет их
//звуĸи через циĸл:
//for animal in animals {
//animal.makeSound()
//}
//Пример результата в ĸонсоли:
//Лев говорит: Ррррр!
//Попугай говорит: Чирик-чирик!
//Питон говорит: Шшш...
//Смотритель покормил всех животных.

enum AnimalType {
    case mammal
    case bird
    case reptile
    case fish
}

class Animal {
    var name: String
    var type: AnimalType
    var age: Int
    
    init(name: String, type: AnimalType, age: Int) {
        self.name = name
        self.type = type
        self.age = age
    }
    
    func makeSound() {
        print(self.name + " издает звук")
    }
}


class Mammal: Animal {
    var furColor: String //цвет шерсти
    
    init(name: String, type: AnimalType, age: Int, furColor: String) {
        self.furColor = furColor
        super.init(name: name, type: type, age: age)
    }
    override func makeSound() {
        print(self.name + " говорит: Ррррр!")
    }
}

class Bird: Animal {
    var canFly: Bool
    
    init(name: String, type: AnimalType, age: Int, canFly: Bool) {
        self.canFly = canFly
        super.init(name: name, type: type, age: age)
    }
    override func makeSound() {
        print(self.name + " говорит: Чирик!")
    }
}

class Reptile: Animal {
    var isVenomous: Bool
    
    init(name: String, type: AnimalType, age: Int, isVenomous: Bool) {
        self.isVenomous = isVenomous
        super.init(name: name, type: type, age: age)
    }
    
    override func makeSound() {
        print(self.name + " говорит: Шшш...")
    }
}

protocol Feedable {
    func feed()
}

extension Feedable {
    func feed() {
        print("Животное покормлено")
    }
}

class ZooKeeper: Feedable {
}

let lion = Mammal(name: "Лев", type: .mammal, age: 5, furColor: "желтый")
let parrot = Bird(name: "Попугай", type: .bird, age: 2, canFly: true)
let python = Reptile(name: "Питон", type: .reptile, age: 10, isVenomous: false)

var animals: [Animal] = [lion, parrot, python]
let zooKeeper = ZooKeeper()
zooKeeper.feed()

for animal in animals {
    animal.makeSound()
}
