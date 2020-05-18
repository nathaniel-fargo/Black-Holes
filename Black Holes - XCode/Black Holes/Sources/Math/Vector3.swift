public class Vector3 {
    
    public var x: Float
    public var y: Float
    public var z: Float
    
    public var xAxis: Float {
        get {
            return x
        }
    }
    public var yAxis: Float {
        get {
            return z
        }
    }
    public var zAxis: Float {
        get {
            return y
        }
    }
    
    public var magnitude: Float {
        get {
            let xyMag = (x * x + y * y).squareRoot()
            let xyzMag = (xyMag * xyMag + z * z).squareRoot()
            return xyzMag
        }
    }
    
    public var normalized: Vector3 {
        get {
            let mag = magnitude
            return Vector3(x / mag, y / mag, z / mag)
        }
    }
    
    public static var zero = Vector3(0, 0, 0)
    
    public init(_ x: Float, _ y: Float, _ z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }
    public convenience init() {
        self.init(0, 0, 0)
    }
    
    public static func + (_ v1: Vector3, _ v2: Vector3) -> Vector3 {
        return Vector3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)
    }
    public static func += (_ v1: inout Vector3, _ v2: Vector3) {
        v1 = v1 + v2
    }
    public static func - (_ v1: Vector3, _ v2: Vector3) -> Vector3 {
        return Vector3(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)
    }
    public static func -= (_ v1: inout Vector3, _ v2: Vector3) {
        v1 = v1 - v2
    }
    public static func * (_ vector: Vector3, _ multiplyer: Float) -> Vector3 {
        return Vector3(vector.x * multiplyer, vector.y * multiplyer, vector.z * multiplyer)
    }
    public static func *= (_ vector: inout Vector3, _ multiplyer: Float) {
        vector = vector * multiplyer
    }
    public static func * (_ v1: Vector3, _ v2: Vector3) -> Vector3 {
        return Vector3(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z)
    }
    public static func *= (_ v1: inout Vector3, _ v2: Vector3) {
        v1 = v1 * v2
    }
    public static func / (_ vector: Vector3, _ divisor: Float) -> Vector3 {
        return Vector3(vector.x / divisor, vector.y / divisor, vector.z / divisor)
    }
    public static func /= (_ vector: inout Vector3, _ divisor: Float) {
        vector = vector / divisor
    }
    public static func / (_ v1: Vector3, _ v2: Vector3) -> Vector3 {
        return Vector3(v1.x / v2.x, v1.y / v2.y, v1.z / v2.z)
    }
    public static func /= (_ v1: inout Vector3, _ v2: Vector3) {
        v1 = v1 / v2
    }
    
    public func add(_ vector: Vector3) {
        self.x += vector.x
        self.y += vector.y
        self.z += vector.z
    }
    public func subtract(_ vector: Vector3) {
        self.x -= vector.x
        self.y -= vector.y
        self.z -= vector.z
    }
    public func multiply(by multiplyer: Float) {
        self.x *= multiplyer
        self.y *= multiplyer
        self.z *= multiplyer
    }
    public func divide(by divisor: Float) {
        self.x /= divisor
        self.y /= divisor
        self.z /= divisor
    }
    public func normalize() {
        let mag = magnitude
        self.x /= mag
        self.y /= mag
        self.z /= mag
    }
}
