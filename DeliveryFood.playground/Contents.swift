import Cocoa

// клиент
// MARK: - Кажется тут можно сделать наследование? 
class Client {
    let name: String
    let address: String
    
    init(name: String, address: String) {
        self.name = name
        self.address = address
    }
    
    // формирование заказа
    func makeOrder(dishes: [Dish], restaurant: Restaurant) -> Order? {
        // MARK: - Пометка преподавателя
        // Использование guard было бы более подходящим
        if dishes.isEmpty {
            print("Невозможно создать заказ без блюд")
            return nil
        } else {
            
            // Проверяем, что все блюда есть в меню ресторана
            let missingDishes = dishes.filter { dish in
                !restaurant.menu.contains(where: { $0.name == dish.name })
            }
            
            if !missingDishes.isEmpty {
                print("Ошибка: Следующие блюда отсутствуют в меню ресторана \(restaurant.name):")
                for dish in missingDishes {
                    print("- \(dish.name)")
                }
                return nil
            }
            
            let order = Order(client: self, restaurant: restaurant, dishes: dishes)
            print("Клиент \(name) создал заказ \(order.id) в ресторане \(restaurant.name). Сумма заказа: \(order.totalPrice)")
            return order
        }
    }
    // оплата заказа
    func payOrder(order: Order) {
            order.isPaid = true
            print("Клиент \(name) оплатил заказ \(order.id). Сумма: \(order.totalPrice) руб.")
        }
}

// ресторан
class Restaurant {
    let name: String
    var menu: [Dish]
    weak var deliveryManager: DeliveryManager? // связь с деливери менеджером
    
    init(name: String, menu: [Dish]) {
        self.name = name
        self.menu = menu
    }
    
    // добавление блюд в меню
    func addDish(dish: Dish) {
        if menu.contains(where: { $0.name == dish.name }) {
            print("Блюдо \(dish.name) уже есть в меню ресторана \(name)")
        } else {
            menu.append(dish)
            print("Блюдо \(dish.name) добавлено в меню ресторана \(name)")
        }
    }
    
    // удаление блюда из меню
    func removeDish(name: String) {
        if menu.contains(where: { $0.name == name })  {
            menu.removeAll { $0.name == name }
            print("Блюдо \(name) удалено из меню ресторана \(name)")
        } else {
            print("Блюда с таким названием нет в меню ресторана \(name)")
        }
    }
    //меню ресторана
    func getMenu() -> [Dish] {
        return menu
    }
    
//    func orderIsReady(order: Order) {
//            order.isReady = true
//            print("Заказ \(order.id) готов в ресторане \(name).")
//        }
    
    func orderIsReady(order: Order) {
            order.isReady = true
            print("Заказ \(order.id) готов в ресторане \(name).")
            deliveryManager?.processReadyOrder(order: order) // сообщаем в деливери менеджер, что заказ готов в ресторане
        }
    
}

// блюдо
struct Dish {
    let name: String
    let price: Double
    let cookingTimeMin: Int
}

//курьер
// MARK: - Кажется тут можно сделать наследование?
class Courier {
    let name: String
    var isAvailable: Bool = true //свободен ли сейчас
    var currentOrder: Order? = nil
    
    init(name: String) {
        self.name = name
    }
    
    // завершение заказа
    func completeOrder(deliveryManager: DeliveryManager) {
        if !isAvailable && currentOrder != nil { // проверяем, что у курьера действительно есть заказ
            if let order = currentOrder {
                deliveryManager.completeOrder(order: order)
                self.currentOrder = nil
                self.isAvailable = true
            }
        } else {
            print("У курьера нет активных заказов")
        }
    }
}

// заказ
// MARK: - (Улучшение генерации ID) - Сейчас ID заказа создается через счетчик. Как можно сделать лучше?
// /*
// Можно использовать `UUID()` вместо `Int idCounter`, чтобы избежать возможных конфликтов при работе с базой данных.
//
// */
class Order {
    let id: Int
    let client: Client
    let restaurant: Restaurant
    let dishes: [Dish]
    var status: OrderStatus = .pending // статус заказа
    var isPaid: Bool = false
    var isReady: Bool = false
    var deliveryTimeMin = 30 // время доставки
    static var idCounter = 1 // пока не придумала как это исправить, но и так раблотает:))))
    
    
    //стоимость заказа
    var totalPrice: Double {
            return dishes.reduce(0) { $0 + $1.price }
        }
    
    init(client: Client, restaurant: Restaurant, dishes: [Dish]) {
        self.id = Order.idCounter
        Order.idCounter += 1
        self.client = client
        self.restaurant = restaurant
        self.dishes = dishes
    }
    
    func printStatus() {
            print("Статус заказа \(id): \(status.rawValue)")
        }
    func calculateDeliveryTime() -> Int {
        let cookingTime = dishes.map { $0.cookingTimeMin }.max() ?? 0
            return cookingTime + deliveryTimeMin
        }
    func provideOrderInfo() {
            let deliveryTime = calculateDeliveryTime()
            print("""
            Информация о заказе \(id):
            - Статус: \(status.rawValue)
            - Общее время ожидания: \(deliveryTime) минут
            - Оплачен: \(isPaid ? "Да" : "Нет")
            - Готовность: \(isReady ? "Готов" : "В процессе")
            """)
        }
}

enum OrderStatus: String {
    case pending = "Ожидает назначения курьера"
    case inProgress = "В процессе доставки"
    case delivered = "Доставлен"
}

// MARK: - (Улучшение логики доставки) - Сейчас доставка занимает фиксированное время. Как сделать его динамическим?
class DeliveryManager {
    var availableCouriers: [Courier] = [] //список курьеров сервиса доставки
    var pendingOrders: [Order] = [] // заказы ожидающие курьера
    var activeOrders: [Order] = [] // заказы в процессе выполнения
    
    // добавление курьера
    func addCourier(courier: Courier) {
        availableCouriers.append(courier)
        print("Курьер \(courier.name) добавлен в систему.")
    }
    
    // добавление заказа в систему
    func addOrder(order: Order) {
        if order.isPaid {
            pendingOrders.append(order)
            print("Заказ \(order.id) принят в обработку.")
            // назначение курьера заказу
//            giveOrderToCourier(order: order)
        } else {
            print("Заказ не оплачен. Невозможно принять в обработку.")
        }
    }
    
    // найти доступного курьера
    func findAvailableCourier() -> Courier? {
        return availableCouriers.first { $0.isAvailable }
    }
    
    // получаем инфу из рестика, что готов и отдаем его курьеру
    func processReadyOrder(order: Order) {
            giveOrderToCourier(order: order)
        }
    
    // назначить заказ курьеру
    func giveOrderToCourier(order: Order) {
        if order.isReady {
            if let courier = findAvailableCourier() {
                // у курьера появляется текущий заказ
                courier.currentOrder = order
                //курьер перестает быть свободным
                courier.isAvailable = false
                //статус заказа меняется на "В процессе доставки"
                order.status = .inProgress
                //из заказов, ожидающих курьера, в заказы в пооцессе исполнения
                activeOrders.append(order)
                pendingOrders.removeAll { $0.id == order.id }
                
                print("Заказ \(order.id) назначен курьеру \(courier.name)")
            } else {
                print("Пока нет доступных курьеров для доставки заказа, заказ \(order.id) поставлен в очередь")
            }
        } else {
            print("Заказ \(order.id) еще не готов в ресторане")
        }
    }
    
    // Завершить заказ
    func completeOrder(order: Order) {
        // меняем статус на завершенный
        order.status = .delivered
        // удаляем из активных заказов сервиса
        activeOrders.removeAll { $0.id == order.id }
        print("Заказ \(order.id) доставлен")
        
        // освобождаем курьера для дальнейших закзов
        if let courier = availableCouriers.first(where: { $0.currentOrder?.id == order.id }) {
                courier.currentOrder = nil
                courier.isAvailable = true
                print("Курьер \(courier.name) завершил заказ \(order.id).")
            }
        
        // если есть заказы ожидающие курьера - выдаем
        if let nextOrder = pendingOrders.first {
                    giveOrderToCourier(order: nextOrder)
                }
    }
}

// Проверяем как все это работает

let deliveryManager = DeliveryManager()

// создаем блюда
let sushi = Dish(name: "Суши", price: 500, cookingTimeMin: 15)
let pizza = Dish(name: "Пицца", price: 700, cookingTimeMin: 20)

// создаем клиентов
let client1 = Client(name: "Иван", address: "ул. Ленина, 10")
let client2 = Client(name: "Мария", address: "ул. Пушкина, 15")

// создаем курьера
let courier = Courier(name: "Алексей")
deliveryManager.addCourier(courier: courier)


// создаем ресторан и связываем с DeliveryManager
let restaurant = Restaurant(name: "Тануки", menu: [pizza])
restaurant.deliveryManager = deliveryManager // Устанавливаем связь
restaurant.addDish(dish: sushi)

// создаем заказы
let order1 = client1.makeOrder(dishes: [sushi, pizza], restaurant: restaurant)
let order2 = client2.makeOrder(dishes: [sushi], restaurant: restaurant)

if let order1 = order1 {
    // клиент оплачивает
    client1.payOrder(order: order1)
    // заказ принят в работу
    deliveryManager.addOrder(order: order1)
    // ресторан сообщил, что заказ готов
    restaurant.orderIsReady(order: order1)
    // выводим текщий статус
    order1.provideOrderInfo()
}

// Клиент 2 делает и оплачивает заказ
if let order2 = order2 {
    client2.payOrder(order: order2)
    deliveryManager.addOrder(order: order2)
    restaurant.orderIsReady(order: order2)
    order2.provideOrderInfo()
}

// курьер завершает первый заказ
courier.completeOrder(deliveryManager: deliveryManager)

// проверяем статусы заказов
order1?.provideOrderInfo()
order2?.provideOrderInfo()
