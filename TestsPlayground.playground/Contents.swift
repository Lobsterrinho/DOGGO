import UIKit

//let date = Date()
//
//var time = DateComponents()
//time.hour = 20
//time.minute = 47
//
//let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
//
//var realDateComponents = DateComponents()
//realDateComponents.year = dateComponents.year
//realDateComponents.month = dateComponents.month
//realDateComponents.day = dateComponents.day
//realDateComponents.hour = time.hour
//realDateComponents.minute = time.minute
//
//let realDate = Calendar.current.date(from: realDateComponents)
//
//let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: dateNow)
////let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
//var neededDate = DateComponents()
//neededDate.year = dateComponents.year
//neededDate.month = dateComponents.month
//neededDate.day = dateComponents.day
//neededDate.hour = timeComponents.hour
//neededDate.minute = timeComponents.minute

let date = Calendar.current.date(byAdding: .second, value: 10, to: Date())

let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date ?? Date())

let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
