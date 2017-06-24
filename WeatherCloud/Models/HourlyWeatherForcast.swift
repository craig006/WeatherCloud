import Foundation

class HourlyWeatherForcast: Codable {
    var summary: String?
    var data: [HourForcast]?
}
