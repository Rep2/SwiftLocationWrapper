//
//  LocationManager.swift
//
//  Created by Rep on 1/21/16.
//  Copyright © 2016 Rep. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate{
    
    static let instance = LocationManager()
    
    var isAvailable = false
    
    private var lastLocation: CLLocation?
    private var locationManager:CLLocationManager?
    
    private var updateSubscriptions: [String : CLLocation -> Void] = [:]
    private var temporarySubscriptions: [CLLocation -> Void] = []
    
    override init(){
        super.init()
        
        let status = CLLocationManager.authorizationStatus()
        
        // Detect if user disabled location services for this app
        if status == .Restricted || status == .Denied{
            // ALert user 
            // Location services are disabled for this app
            // Enable the service from the Settings application and try again
        }else{
            // Detect if user disabled location services for the whole phone
            // If so, still create location manager and start listening as data will come in if user enables service
            if (CLLocationManager.locationServicesEnabled() == false){
                // Alert user
                // Location services are disabled
                // Enable the service from Location Services switch in General
            }
            
            initLocationManger()
            
            // If status is not determined ask user to allow it
            if status == .NotDetermined{
                // Or set to requestWhenInUseAuthorization
                locationManager!.requestAlwaysAuthorization()
            }else{
                // Location is available and working
                isAvailable = true
                locationManager!.startUpdatingLocation()
            }
        }
    }
    
    func initLocationManger(){
        // Init and store location manager
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        
        // Set accuracy as wanted
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status{
        case .Denied, .Restricted:
            locationManager = nil
            
            isAvailable = false
        case .NotDetermined:
            locationManager!.requestAlwaysAuthorization()
            
            isAvailable = false
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            if locationManager == nil{
                initLocationManger()
            }
            
            isAvailable = true
            locationManager!.startUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations[0]
        
        for (_, function) in updateSubscriptions{
            function(lastLocation!)
        }
        
        for function in temporarySubscriptions{
            function(lastLocation!)
        }
        temporarySubscriptions.removeAll()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    // Subscription
    func addSubscription(name:String, function: (CLLocation -> Void)){
        updateSubscriptions[name] = function
    }
    
    func removeSubscription(name:String){
        updateSubscriptions[name] = nil
    }
    
    /// Initializes get location request
    /// Location is returned using provided retFunc
    func getLocation(retFunc: (CLLocation) -> Void){
        
        if let location = lastLocation{
            retFunc(location)
        }else{
            temporarySubscriptions.append(retFunc)
        }
        
    }
    
    /// Initializes get location request and creates new subscription
    /// Location is returned using provided retFunc
    func getLocationAndSubscribe(name:String, retFunc: (CLLocation) -> Void){
        
        if let location = lastLocation{
            retFunc(location)
        }
        
        updateSubscriptions[name] = retFunc
    }
    
}