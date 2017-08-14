//
//  Created by Nikolay Lihogrud on 10.08.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

import UIKit
import SomeTarget
import SomeOtherTarget
import CoreLocation
import AVFoundation
import MapKit
import DynamicLib
import YandexMobileMetrica
import YandexMobileMetricaPush

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    var locationManager: CLLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        dump(SomeClass1())
        dump(SomeClass2())
        dump(SomeOtherClass2())
        dump(SomeOtherClass2())

        try? AVAudioSession.sharedInstance().setActive(true)

        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        locationManager?.requestWhenInUseAuthorization()

        defer {
            print(#function)
        }

        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(6.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: {

                YMMYandexMetrica.activate(withApiKey: "")

                let someDynamicClassObj = SomeDynamicClass()

                print(someDynamicClassObj.someVar)
                someDynamicClassObj.someVar = 50
                print(someDynamicClassObj.someVar)

                SomeDynamicClass.someClassFunc()
                someDynamicClassObj.someFunc()

                someGlobalFunc()

                print(someGlobalVar)
                someGlobalVar = 20
                print(someGlobalVar)
                
                print(someGlobalStringVar)

                exit(0)
            }
        )
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        YMPYandexMetricaPush.setDeviceTokenFrom(deviceToken)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print(MKDirectionsRequest(contentsOf: url))
        return true
    }
}

