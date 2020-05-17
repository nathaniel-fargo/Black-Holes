public func Map(value: Double, fromMin: Double, fromMax: Double, toMin: Double, toMax: Double) -> Double {
    return (value - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin
}
public func Map(value: Float, fromMin: Float, fromMax: Float, toMin: Float, toMax: Float) -> Float {
    return (value - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin
}
