//: [Previous](@previous)

class VeryExspensiveObject {

    static let shared = VeryExspensiveObject()

    private init() { }

    func execute() {

    }
}


VeryExspensiveObject.shared.execute()
//: [Next](@next)
