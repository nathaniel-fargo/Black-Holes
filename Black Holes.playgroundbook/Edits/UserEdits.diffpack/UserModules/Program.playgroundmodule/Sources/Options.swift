
public struct UniverseOptions {
    public var universeUpdateType: UniverseUpdateType
    // NOT RECOMMENDED FOR VALUE `true`
    public var showUniverseCreation: Bool
    public var universe: Universe
    public var imageResolution: Double
    public init (universeUpdateType updateType: UniverseUpdateType, universeRadius radius: Float, imageResolution resolution: Float, blackHolePosition: Vector3, cameraViewFieldAngle viewAngle: Float, ringAngleInDegrees: Double) {
        imageResolution = Double(resolution)
        universeUpdateType = updateType
        showUniverseCreation = false
        universe = Universe(radius: radius, blackHolePosition: blackHolePosition, resolution: resolution, rotateFactor: viewAngle, ringAngleInDegrees: ringAngleInDegrees)
    }
}
