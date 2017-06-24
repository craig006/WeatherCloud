import Foundation
import AwesomeCache

class CachedWeatherService: WeatherService {
    
    private let cacheKey = "forcast"
    private let cacheExpirySeconds: TimeInterval = 900
    var underlyingService: WeatherService
    
    init(underlyingService: WeatherService) {
        self.underlyingService = underlyingService
    }
    
    var cache: Cache<JsonCacheWrapper<WeatherForcast>>? {
        let cache = try? Cache<JsonCacheWrapper<WeatherForcast>>(name: "serviceCache")
        return cache
    }
    
    func getWeather(completion: @escaping (WeatherForcast) -> Void, errorCompletion: ((Error) -> Void)? = nil) {
        cache?.removeExpiredObjects()
        
        if let cachedData = cache?.object(forKey: cacheKey) {
            completion(cachedData.item)
            return
        }
    
        underlyingService.getWeather(completion: { forcast in
            self.cache?.setObject(JsonCacheWrapper<WeatherForcast>(item: forcast), forKey: self.cacheKey, expires: .seconds(self.cacheExpirySeconds))
            completion(forcast)
        }, errorCompletion: errorCompletion)
    }
}
