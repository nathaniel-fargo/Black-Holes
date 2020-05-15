import CoreGraphics

public enum UniverseStatus {
    case awake
    case finished
}
public indirect enum UniverseUpdateType {
    case single
    case together
    case allAtOnce(by: UniverseUpdateType)
}
public class Universe {
    public var viewRays: [Ray] = []
    public var deadRays: [Ray] = []
    var blackHole: BlackHole
    var ring: Ring
    public var status: UniverseStatus = .awake
    var bounds: Vector3
    var radius: Float
    var frame: CGRect
    var finalFrame: CGRect
    var doBlackHoles: Bool
    var showRing: Bool
    var simulationSpeed: Float
    
    public init(radius: Float, blackHolePosition: Vector3, resolution: Float, rotateFactor: Float, ringAngleInDegrees: Double, doBlackHoles: Bool, showRing: Bool, simulationSpeed: Float) {
        // The limits of the world space
        self.radius = radius
        bounds = Vector3(radius, radius, radius)
        // Make the world frame
        frame = CGRect(x: CGFloat(-bounds.xAxis), y: CGFloat(-bounds.yAxis), width: CGFloat(bounds.x * 2), height: CGFloat(bounds.z * 2))
        // Create the final frame
        let cgResolution = CGFloat(resolution)
        finalFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: cgResolution, height: cgResolution))
        // Create the black hole
        blackHole = BlackHole(position: blackHolePosition)
        // Create the ring
        ring = Ring(from: blackHole, angle: ringAngleInDegrees)
        self.doBlackHoles = doBlackHoles
        self.showRing = showRing
        self.simulationSpeed = simulationSpeed
        // Create light rays
        createLightRays(resolution: resolution, rotateFactor: rotateFactor)
    }
    
    // Creates a bunch of light rays
    func createLightRays(resolution: Float, rotateFactor: Float) {
        let middle = resolution / 2
        for i in 0...Int(resolution - 1) {
            for j in 0...Int(resolution - 1) {
                // Turns i, j into floats
                let x = Float(i)
                let y = Float(j)
                
                // The below is calculating the velocity of the light ray
                /// <#xRotate#> is what determines how much the <#velocity.x#> gets shifted with <#velocity.z#>,not how much the vector is rotated around the x-axis
                let xRotate = (x - middle) / middle * rotateFactor
                /// Same as <#xRotate#> but switch <#x#> values with <#y#>-values
                let yRotate = (y - middle) / middle * rotateFactor
                let directionX = sin(xRotate)
                let directionY = sin(yRotate)
                let directionZ = cos(xRotate) * cos(yRotate)
                let lightDirection = Vector3(directionX, directionY, directionZ)
                
                // Get the render position
                let drawPosition = CGPoint(x: i, y: j)
                viewRays.append(Ray(position: Vector3(0, 0, 0), drawPosition: drawPosition, direction: lightDirection, universeRadius: radius))
            }
        }
    }
    
    public func update(updateType: UniverseUpdateType) {
        if (viewRays.count == 0) {
            status = .finished
            return
        }
        switch updateType {
        case .single:
            if let firstRay = viewRays.first {
                while firstRay.status == .alive {
                    updateRay(ray: firstRay)
                }
                deadRays.append(firstRay)
                viewRays.remove(at: 0)
            }
        break
        case .together:
            // Used as a loop and remover
            viewRays.removeAll { (ray) -> Bool in
                updateRay(ray: ray)
                if (ray.status != .alive) {
                    deadRays.append(ray)
                    return true
                }
                return false
            }
        break
        case .allAtOnce(let recursionType):
            self.update(updateType: recursionType)
            self.update(updateType: .allAtOnce(by: recursionType))
        }
    }
    public func updateRay(ray: Ray) {
        if doBlackHoles {
            blackHole.interact(with: ray)
        }
        ray.update(factor: simulationSpeed)
        if showRing {
            ring.check(particle: ray)
        }
    }
}
