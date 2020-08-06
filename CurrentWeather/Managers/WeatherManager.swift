import Foundation

struct Weather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Decodable {
    var temp: Double = 0.0
    var feels_like: Double = 0.0
    var temp_min: Double = 0.0
    var temp_max: Double = 0.0
    var humidity: Int = 0
}

struct Wind: Decodable {
    var speed: Double = 0.0
    var deg: Int = 0
}

struct WeatherData: Decodable {
    var weather: [Weather] = []
    var main: Main = Main()
    var wind: Wind = Wind()
    var name: String = ""
}

class WeatherManager {
    var weatherInfo = WeatherData()
    static let shared = WeatherManager()
    private init () {}
    
    func currentLocationWeather (lat: Double, lon: Double, handler : @escaping( _ weatherInfo: WeatherData?, _ error: Error? )->()) {
        guard let url  = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=6e3fab275130706ff12ad3cd575913c8&lang=ru") else { return}
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                self.weatherInfo = try JSONDecoder().decode(WeatherData.self, from: data)
                handler(self.weatherInfo , nil)
            } catch let error{
                handler(nil,error)
            }
        }.resume()
    }
}
