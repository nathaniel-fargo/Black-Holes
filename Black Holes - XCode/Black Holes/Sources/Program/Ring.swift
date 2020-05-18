//import Math
import CoreGraphics
public enum RingStatus {
    case greater
    case less
}
public class Ring {
    var innerRadius: Float
    var outerRadius: Float
    var angle: Double
    var angleRad: Double
    var particlesInfo: [Int: RingStatus] = [:]
    var rotation: Vector3 {
        get {
            return Vector3(Float(angle), 0, 0)
        }
    }
    var position: Vector3
    var innerFrame: CGRect {
        get {
            return CGRect(x: CGFloat(-innerRadius + position.xAxis * cos(rotation.xAxis)), y: CGFloat(-innerRadius + position.yAxis * cos(rotation.yAxis)), width: CGFloat(innerRadius * 2), height: CGFloat(innerRadius * 2))
        }
    }
    var frame: CGRect {
        get {
            return CGRect(x: CGFloat(-outerRadius + position.xAxis), y: CGFloat(-outerRadius + position.yAxis), width: CGFloat(outerRadius * 2), height: CGFloat(outerRadius * 2))
        }
    }
    
    public init (from blackHole: BlackHole, angle: Double) {
        position = blackHole.position
        innerRadius = blackHole.radius * 1
        outerRadius = blackHole.radius * 6
        self.angle = Double(Int(angle + 360) % 360)
        angleRad = self.angle * Double.pi / 180
    }
    public func check (particle: Particle) {
        let distance = (particle.position - position).magnitude
        let speed = particle.velocity.magnitude
        if distance > innerRadius - speed && distance < outerRadius + speed {
            let particleStatus = checkStatus(of: particle)
            if distance > innerRadius && distance < outerRadius {
                if let currentStatus = particleStatus, let previousStatus = particlesInfo[particle.id] {
                    if currentStatus != previousStatus {
                        particle.status = .ring
                    }
                }
            }
            particlesInfo[particle.id] = particleStatus
        }
    }
    func checkStatus(of particle: Particle) -> RingStatus? {
        switch (angle) {
        case 0...45, 135...225, 315...360:
            let yMark = Float(tan(angleRad)) * (particle.position.z - position.z) + position.y
            return particle.position.y > yMark ? .greater : .less
        case 45...135, 225...315:
            let zMark = 1 / Float(tan(angleRad)) * (particle.position.y - position.y) + position.z
            return particle.position.z > zMark ? .greater : .less
        default:
            return nil
        }
    }
}
