//
//  GeoPositionManager.swift
//  LifestyleHUB
//
//  Created by Даниил Суханов on 19.03.2024.
//

import Foundation
import CoreLocation

final class GeoPositionManager: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var locationCallback: ((CLLocation?) -> Void)?
    var locationServicesEnabled = false
    var didFailWithError: Error?
    let lock = NSLock()
    
    func getCurrentLocation() async -> CLLocation? {
        await withCheckedContinuation { complition in
            lock.withLock {
                self.run { result in
                    complition.resume(returning: result)
                }
            }
        }
    }
    
    
    private func run(callback: @escaping (CLLocation?) -> Void) {
        locationCallback = callback
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        locationServicesEnabled = CLLocationManager.locationServicesEnabled()
        if locationServicesEnabled { manager.startUpdatingLocation() }
        else { 
            locationCallback?(nil)
            locationCallback = nil
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationCallback?(locations.last!)
        locationCallback = nil
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        didFailWithError = error
        print(error.localizedDescription)
        print(String(describing: error))
        locationCallback?(nil)
        locationCallback = nil
        manager.stopUpdatingLocation()
    }
    
    deinit {
        manager.stopUpdatingLocation()
    }
}
