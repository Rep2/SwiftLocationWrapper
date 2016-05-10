# SwiftLocationWrapper

Simple CLLocationWrapper that handles user interaction and location fetch.

Contributions appreciated!

## Setup

Add "LocationManager" class to your project.

Add "Privacy - Location Usage Description", "NSLocationAlwaysUsageDescription" and "NSLocationWhenInUseUsageDescription" to your plist file.


## Use

Before fetching location test if location is available:

```swift
  LocationManager.instance.isAvailable
```

If location is available, fetch is using:

```swift
  LocationManager.instance.getLocation(retFunc: (CLLocation) -> Void)
```

To fetch and subscribe use:

```swift
  LocationManager.instance.getLocationAndSubscribe(name:String, retFunc: (CLLocation) -> Void)
```

Subscribe returns value each time location is updated.

Be sure to UNSUBSCRIBE using:

```swift
  removeSubscription(name:String)
```

If location is not available you can still subscribe but will not get any data until user allows location service.


For more information and configuration look at "LocationManager" class.
