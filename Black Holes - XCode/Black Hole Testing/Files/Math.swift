import CoreGraphics
extension CGPoint {
    public static func randomPoint(xRange: Range<CGFloat>, yRange: Range<CGFloat>) -> CGPoint {
        return CGPoint(x: CGFloat.random(in: xRange), y: CGFloat.random(in: yRange))
    }
    public static func randomPoint(xRange: Range<Double>, yRange: Range<Double>) -> CGPoint {
        return CGPoint(x: Double.random(in: xRange), y: Double.random(in: yRange))
    }
    public static func randomPoint(xRange: Range<Int>, yRange: Range<Int>) -> CGPoint {
        return CGPoint(x: Int.random(in: xRange), y: Int.random(in: yRange))
    }
}
extension CGRect {
    public static func * (_ rect: CGRect, multiplyer: CGFloat) -> CGRect {
        return CGRect(x: rect.origin.x * multiplyer, y: rect.origin.y * multiplyer, width: rect.width * multiplyer, height: rect.height * multiplyer)
    }
}
public func Map(value: Double, fromMin: Double, fromMax: Double, toMin: Double, toMax: Double) -> Double {
    return (value - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin
}
public func Map(value: Float, fromMin: Float, fromMax: Float, toMin: Float, toMax: Float) -> Float {
    return (value - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin
}
