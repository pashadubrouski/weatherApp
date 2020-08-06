import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    let locationManager = CLLocationManager()
    
    let weatherIcon : UIImageView  = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "01d")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cityName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Город"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 45)
        label.textColor = .white
        return label
    }()
    
    let shortDescription : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "описание"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let temperatureLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "0℃"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    let spiner : UIActivityIndicatorView = {
        let spiner  = UIActivityIndicatorView()
        spiner.translatesAutoresizingMaskIntoConstraints = false
        spiner.style = .large
        spiner.color = .white
        spiner.startAnimating()
        return spiner
    }()
    
    let blur : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    let maxTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10 )
        label.text = "максимальная температура 0℃"
        label.textColor = .white
        return label
    }()
    
    let minTempLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "минимальная температура 0℃"
        label.textColor = .white
        return label
    }()
    
    let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
         label.font = UIFont.systemFont(ofSize: 10)
         label.text = "скорость ветра 0 м/с"
         label.textColor = .white
        return label
    }()
    
    let airHumidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textAlignment = .center
         label.font = UIFont.systemFont(ofSize: 10)
         label.text = "влажность  0 %"
         label.textColor = .white
        return label
    }()
    
    let line : UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.layer.backgroundColor = UIColor(red: 1 , green: 1, blue: 1, alpha: 1).cgColor
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLocation()
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupViews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    private func setupViews() {
        view.backgroundColor = .init(red: 0.257, green: 0.610, blue: 1.0, alpha: 1)
        view.addSubview(cityName)
        view.addSubview(shortDescription)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherIcon)
        view.addSubview(line)
        view.addSubview(maxTempLabel)
        view.addSubview(minTempLabel)
        view.addSubview(windSpeedLabel)
        view.addSubview(airHumidityLabel)
        view.addSubview(blur)
        blur.contentView.addSubview(spiner)
        setupImages()
        setupLabels()
    }
    
    
    
    private func setupLabels(){
        NSLayoutConstraint(item: cityName, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 42).isActive = true
        NSLayoutConstraint(item: shortDescription, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 21).isActive = true
        NSLayoutConstraint(item: temperatureLabel, attribute: .height, relatedBy: .equal, toItem: weatherIcon, attribute: .height, multiplier: 1/2, constant: 0).isActive = true
        NSLayoutConstraint(item: maxTempLabel, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 21).isActive = true
        NSLayoutConstraint(item: maxTempLabel, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.width/2 - 15).isActive = true
        NSLayoutConstraint(item: minTempLabel, attribute: .height, relatedBy: .equal, toItem: maxTempLabel, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: minTempLabel, attribute: .width, relatedBy: .equal, toItem: maxTempLabel, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: windSpeedLabel, attribute: .height, relatedBy: .equal, toItem: maxTempLabel, attribute: .height, multiplier: 1, constant: 0   ).isActive = true
          NSLayoutConstraint(item: windSpeedLabel, attribute: .width, relatedBy: .equal, toItem: maxTempLabel, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: airHumidityLabel, attribute: .height, relatedBy: .equal, toItem: maxTempLabel, attribute: .height, multiplier: 1, constant: 0   ).isActive = true
        NSLayoutConstraint(item: airHumidityLabel, attribute: .width, relatedBy: .equal, toItem: maxTempLabel, attribute: .width, multiplier: 1, constant: 0).isActive = true
        cityName.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cityName.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cityName.bottomAnchor.constraint(equalTo: weatherIcon.topAnchor, constant: -15).isActive = true
        shortDescription.widthAnchor.constraint(equalTo: cityName.widthAnchor).isActive = true
        shortDescription.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 0).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: shortDescription.bottomAnchor, constant: 15).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        temperatureLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        temperatureLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        spiner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       spiner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: 1).isActive = true
        line.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: -5).isActive = true
        line.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        line.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        maxTempLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 50).isActive = true
        maxTempLabel.leftAnchor.constraint(equalTo: line.leftAnchor).isActive = true
        minTempLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        minTempLabel.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 50).isActive = true
        windSpeedLabel.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 50).isActive = true
        windSpeedLabel.leftAnchor.constraint(equalTo: maxTempLabel.leftAnchor).isActive = true
        airHumidityLabel.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 50).isActive = true
        airHumidityLabel.leftAnchor.constraint(equalTo: minTempLabel.leftAnchor).isActive = true
        blur.frame = view.bounds
    }
    
    private func setupImages(){
        NSLayoutConstraint(item: weatherIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: view.frame.height / 4).isActive = true
        NSLayoutConstraint(item: weatherIcon, attribute: .width, relatedBy: .equal, toItem: weatherIcon, attribute: .height, multiplier: 1, constant: 0).isActive = true
        weatherIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height/8).isActive = true
        weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func startLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func updateInformation(){
        cityName.text = WeatherManager.shared.weatherInfo.name
        weatherIcon.image = UIImage(named:  WeatherManager.shared.weatherInfo.weather.last?.icon ?? "")
        shortDescription.text = WeatherManager.shared.weatherInfo.weather.last?.description ?? ""
        temperatureLabel.text = "\(Int(WeatherManager.shared.weatherInfo.main.temp))℃"
        maxTempLabel.text = "максимальная температура \(Int(WeatherManager.shared.weatherInfo.main.temp_max))℃"
        minTempLabel.text = "минимальная температура \(Int(WeatherManager.shared.weatherInfo.main.temp_min))℃"
        windSpeedLabel.text = "скорость ветра \(WeatherManager.shared.weatherInfo.wind.speed) м/с"
        airHumidityLabel.text = "влажность \(WeatherManager.shared.weatherInfo.main.humidity) %"
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        LocationManager.shared.latitude = lastLocation?.coordinate.latitude
        LocationManager.shared.longitude = lastLocation?.coordinate.longitude
        WeatherManager.shared.currentLocationWeather(lat: LocationManager.shared.latitude ?? 0, lon: LocationManager.shared.longitude ?? 0) { (weatherData, error) in
            DispatchQueue.main.async {
                guard let weatherInfo = weatherData else {
                    let alert = UIAlertController(title: "Ошибка", message: "Повторите попытку позже", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Окей", style: .default, handler: nil)
                    alert.addAction(okayAction)
                    self.present(alert, animated:true, completion: nil)
                    return
                }
                WeatherManager.shared.weatherInfo = weatherInfo
                self.updateInformation()
             self.spiner.stopAnimating()
                self.blur.isHidden = true
            }
        }
        locationManager.stopUpdatingLocation()
    }
}

