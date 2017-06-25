import Foundation

class HourForcast: Codable {
    var time: Int?
    var summary: String?
    var icon: String?
    var temperature: Double?
    
    var timeDate: Date? {
        if let time = time {
            return Date(timeIntervalSince1970: TimeInterval(time))
        } else {
            return nil
        }
    }
    
    var timeDescription: String {
        if let date = timeDate {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(abbreviation: "SAST")
            formatter.dateFormat = "E, dd MMM, HH:mm"
            return formatter.string(from: date)
        }
        
        return ""
    }
    
    var temperatureCelcius: Int {
        if let temperature = temperature {
            return Int((temperature - 32) * 0.5556)
        }
        return 0
    }
}
