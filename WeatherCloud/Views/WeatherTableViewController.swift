import Foundation
import UIKit

class WeatherTableViewController: UITableViewController {
    
    private let cellIdentifier = "HourlyWeather"
    private var weatherForcast: WeatherForcast?
    
    var weatherService: WeatherService = CachedWeatherService(underlyingService: DarkSkyWeatherService())
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        fetchWeather()
    }
    
    func handleWeatherUpdated(forcast: WeatherForcast) {
        weatherForcast = forcast
        tableView.reloadData()
    }
    
    func handleWeatherUpdateFailed(error: Error) {
        let alert = UIAlertController(title: "Fetching weather failed",
                                      message: "There was an error fetching the latest weather information. Check your connection and try again",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            self.fetchWeather()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func fetchWeather() {
        return weatherService.getWeather(completion: handleWeatherUpdated, errorCompletion: handleWeatherUpdateFailed)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForcast?.hourly?.data?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! WeatherTableViewCell
        let item = weatherForcast?.hourly?.data?[indexPath.row]
        cell.model = item
        return cell
    }
}
