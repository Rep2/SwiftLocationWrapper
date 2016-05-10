# SwiftLocationWrapper

Simple CLLocationWrapper that handles user interaction and location fetch.

Contributions appreciated!

## Use

Add "LocationManager" class to your project.

To get location call 

  getLocation(retFunc: (CLLocation) -> Void)

or to subscribe

  getLocationAndSubscribe(name:String, retFunc: (CLLocation) -> Void)


For more information and configuration look at "LocationManager" class.
