public class DynamicLibrary {
    public static var counter: Int = 0

    public init() {}

    public func hello() -> String {
        DynamicLibrary.counter += 1
        return "Hello From Dynamic Library: \(DynamicLibrary.counter)"
    }
}