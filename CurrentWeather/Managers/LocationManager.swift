import Foundation

 class LocationManager {
    static let shared = LocationManager()
    private init () { }
    
    var latitude: Double?
    var longitude: Double? 
}


