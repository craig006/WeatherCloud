import Foundation

class WeatherForcast: Codable {
    var latitude: Double?
    var longitude: Double?
    var currently: HourForcast?
    var hourly: HourlyWeatherForcast?
}

