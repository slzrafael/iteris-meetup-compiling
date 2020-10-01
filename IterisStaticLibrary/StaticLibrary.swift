public class StaticLibrary {
    public static var counter: Int = 0

    public init() {}

    public func hello() -> String {
        StaticLibrary.counter += 1
        return "Hello From Static Library: \(StaticLibrary.counter)"
    }
}