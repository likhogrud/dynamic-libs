import Foundation

@objc public class SomeDynamicClass: NSObject {

    @objc public var someVar: Int = 0

    @objc public class func someClassFunc() {
        print(#function)
    }

    public override init() {
        super.init()
        print(#function)
    }

    @objc public func someFunc() {
        print(#function)
    }
}
