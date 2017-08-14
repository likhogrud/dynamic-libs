//
//  Created by Nikolay Lihogrud on 10.08.17.
//  Copyright © 2017 Yandex LLC. All rights reserved.
//

import UIKit
import SomeTarget
import SomeOtherTarget

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLWLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLWLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        dump(SomeClass1())
        dump(SomeClass2())
        dump(SomeOtherClass2())
        dump(SomeOtherClass2())

        try? AVWAudioSession.sharedInstance().setActive(true)

        locationManager = CLWLocationManager()
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        locationManager?.requestWhenInUseAuthorization()

        defer {
            checkLoadedLibs()
            print(#function)
        }

        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(2.0 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: {

                LazyYandexMetrica.activate(withApiKey: "")

                let someDynamicClassObj = LazySomeDynamicClass()

                print(someDynamicClassObj.someVar)
                someDynamicClassObj.someVar = 50
                print(someDynamicClassObj.someVar)

                LazySomeDynamicClass.someClassFunc()
                someDynamicClassObj.someFunc()

                lazySomeGlobalFunc()

                print(getLazySomeGlobalVar())
                setLazySomeGlobalVar(20);
                print(getLazySomeGlobalVar())
                
                print(getLazySomeGlobalStringVar())

                exit(0)
            }
        )

        return true
    }

    func checkLoadedLibs() {

        let expectedImages: Set<String> = ["libswiftCore.dylib", "libswiftCoreImage.dylib", "libswiftDispatch.dylib", "libswiftObjectiveC.dylib", "libswiftUIKit.dylib", "libswiftCoreGraphics.dylib", "libswiftDarwin.dylib", "libswiftFoundation.dylib", "libswiftQuartzCore.dylib", "libswiftSwiftOnoneSupport.dylib"]

        let frameworksPath = Bundle.main.privateFrameworksPath ?? ""

        var count: UInt32 = 0

        let imagesPathsPointer: UnsafeMutablePointer<UnsafePointer<Int8>?>! =
            objc_copyImageNames(&count)

        for i in 0..<count {
            let pathPointer = imagesPathsPointer.advanced(by: Int(i)).pointee
            let path = pathPointer.flatMap { String(cString: $0) } ?? ""

            guard path.contains(frameworksPath) else { continue }
            let name = (path as NSString).lastPathComponent
            assert(expectedImages.contains(name))
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        LazyYandexMetricaPush.setDeviceTokenFrom(deviceToken)
    }

    func locationManager(_ manager: CLWLocationManager, didUpdateLocations locations: [CLWLocation]) {
        print(locations)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        print(MKWDirectionsRequest(contentsOf: url))
        return true
    }
}

