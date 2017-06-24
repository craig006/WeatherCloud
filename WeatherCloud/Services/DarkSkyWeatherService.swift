import Foundation

class DarkSkyWeatherService: WeatherService {
    
    var url = URL(string: "http://ec-weather-proxy.appspot.com/forecast/29e4a4ce0ec0068b03fe203fa81d457f/-33.9249,18.4241?delay=5&chaos=0")!
    
    func getWeather(completion: @escaping (WeatherForcast) -> Void, errorCompletion: ((Error) -> Void)? = nil) {
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                errorCompletion?(error)
            }
            
            guard let data = data else {
                errorCompletion?(ServiceError(description: "No data received"))
                return
            }
            
            let decoder = JSONDecoder()
            
            if let weatherForcast = try? decoder.decode(WeatherForcast.self, from: data) {
                completion(weatherForcast)
            } else {
                errorCompletion?(ServiceError(description: "Could not decode data to WeatherForcast"))
            }
        }
        
        session.resume()
    }
}


