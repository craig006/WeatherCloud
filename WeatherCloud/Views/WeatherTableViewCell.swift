import Foundation
import UIKit
import SnapKit

class WeatherTableViewCell: UITableViewCell {
    
    var temperatureLabel = UILabel()
    var timeLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: HourForcast? {
        didSet {
            
            if let temperature = model?.temperatureCelcius {
                temperatureLabel.text = "\(temperature)°C"
            } else {
                temperatureLabel.text = ""
            }
            
            if let time = model?.timeDescription {
                timeLabel.text = time
            } else {
                timeLabel.text = ""
            }
        }
    }
    
    func createSubviews() {
        addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.left.equalToSuperview().offset(30)
        }
    }
}
