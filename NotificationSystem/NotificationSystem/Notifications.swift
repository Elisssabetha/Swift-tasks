//
//  main.swift
//  NotificationSystem
//
//  Created by Елизавета Каранкевич on 08.03.2025.
//

import Foundation


protocol Notifiable: AnyObject { //AnyObject - протокол может быть реализоваг только классами
    func send(message: String)
}

class EmailNotification: Notifiable {
    
    func send(message: String) {
        print("Email: \(message)")
    }
}
class PushNotification: Notifiable {
    
    func send(message: String) {
        print("Push: \(message)")
    }
}

class SMSNotification: Notifiable {
    
    func send(message: String) {
        print("SMS: \(message)")
    }
}

class NotificationManager {
    private var services: [Notifiable] = []
    
    func addService(_ service: Notifiable) {
        services.append(service)
    }
    
    func logNotification(message: String, service: Notifiable) {
        // форматирование даты в нужный вид
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: Date())
        
        //получаем имя сервиса (название класса)
        let serviceName = String(describing: type(of: service))
        
        let logMessage = "[\(serviceName)] Уведомление отправлено: \(message) в \(formattedDate)"
        print(logMessage)
    }
    
    func sendNotification(_ message: String) {
        for service in services {
            service.send(message: message)
            logNotification(message: message, service: service)
        }
    }
    
    func removeService(_ service: Notifiable) {
        services.removeAll { $0 === service }
    }
}

// MARK: - пометка преподавателя
// 10 из 10
