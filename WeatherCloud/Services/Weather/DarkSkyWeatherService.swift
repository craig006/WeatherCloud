import Foundation

class DarkSkyWeatherService: WeatherService {
    
    var url = URL(string: "http://ec-weather-proxy.appspot.com/forecast/29e4a4ce0ec0068b03fe203fa81d457f/-33.9249,18.4241?delay=5&chaos=0")!
    
    func getWeather(completion: @escaping (WeatherForcast) -> Void, errorCompletion: ((Error) -> Void)? = nil) {
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { errorCompletion?(error) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { errorCompletion?(ServiceError(description: "No data received")) }
                return
            }
            
            let decoder = JSONDecoder()
            
            if let weatherForcast = try? decoder.decode(WeatherForcast.self, from: data) {
                DispatchQueue.main.async { completion(weatherForcast) }
            } else {
                DispatchQueue.main.async { errorCompletion?(ServiceError(description: "Could not decode data to WeatherForcast")) }
            }
        }
        
        session.resume()
    }
}


