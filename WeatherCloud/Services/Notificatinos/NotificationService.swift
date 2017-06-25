import Foundation

protocol NotificationService {
    func authorize()
    func showNotification(title: String, body: String)
}
