import Foundation

protocol WeatherService {
    func getWeather(completion: @escaping (WeatherForcast) -> Void, errorCompletion: ((Error) -> Void)?)
}
