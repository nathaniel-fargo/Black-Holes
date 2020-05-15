import UIKit
struct UniverseOptions {
    // This often breaks the program so I just set it to false
    let showUniverseCreation: Bool = false
    // How the universe updates, whether one particle at a time, all of them at a time, or just does it all in one frame
    var universeUpdateType: UniverseUpdateType
    // The width/height of the image
    var imageResolution: Double
    // The radius of the universe
    var radius: Float
    // How far away the black hole is
    var blackHoleDistance: Float
    // The camera viewing angle
    var viewAngle: Float
    // The angle of the ring
    var ringAngle: Double
    // Whether to actually do black holes or not
    var doBlackHoles: Bool
    // Shows the ring or not
    var showRing: Bool
    // How fast the simulation runs
    var simulationSpeed: Float
    // Color of the ring
    var ringColor: UIColor
    
    init (universeUpdateType updateType: UniverseUpdateType, universeRadius radius: Float, imageResolution resolution: Float, blackHoleDistance: Float, cameraViewFieldAngle viewAngle: Float, ringAngleInDegrees: Double, doBlackHoles: Bool, showRing: Bool, simulationSpeed: Float, ringColor: UIColor) {
        universeUpdateType = updateType
        self.radius = radius
        imageResolution = Double(resolution)
        self.blackHoleDistance = blackHoleDistance
        self.viewAngle = viewAngle
        ringAngle = ringAngleInDegrees
        self.doBlackHoles = doBlackHoles
        self.showRing = showRing
        self.simulationSpeed = simulationSpeed
        self.ringColor = ringColor
    }
    init() {
        self.init(universeUpdateType: .together, universeRadius: 2000, imageResolution: 256, blackHoleDistance: 1000, cameraViewFieldAngle: 1, ringAngleInDegrees: 357, doBlackHoles: true, showRing: true, simulationSpeed: 0.1, ringColor: .orange)
    }
    func getUniverse() -> Universe {
        return Universe(radius: radius, blackHolePosition: Vector3(0, 0, blackHoleDistance), resolution: Float(imageResolution), rotateFactor: viewAngle, ringAngleInDegrees: ringAngle, doBlackHoles: doBlackHoles, showRing: showRing, simulationSpeed: simulationSpeed)
    }
}
