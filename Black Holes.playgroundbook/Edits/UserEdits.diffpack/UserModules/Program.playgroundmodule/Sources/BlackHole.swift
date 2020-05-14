import CoreGraphics
// import PlaygroundSupport

// Because we are working in a simulated environment with simulated units, this does not need to match real world physics
public let GravitationalConstant: Float = 1

public class BlackHole {

    var position: Vector3
    var mass: Float = 200000
    
    var frame: CGRect {
        get {
            return CGRect(x: Double(position.xAxis - radius), y: Double(position.yAxis - radius), width: Double(radius * 2), height: Double(radius * 2))
        }
    }
    var radius: Float
    
    init(position: Vector3) {
        self.position = position
        radius = 2 * mass * GravitationalConstant / (SpeedOfLight * SpeedOfLight)
    }
    convenience init(position: Vector3, mass: Float) {
        self.init(position: position)
        self.mass = mass
        radius = 2 * mass * GravitationalConstant / (SpeedOfLight * SpeedOfLight)
    }
    convenience init() {
        self.init(position: Vector3.zero)
    }
    func interact(with particle: Particle) {
        let displacement = position - particle.position
        let distance = displacement.magnitude
        let gravitationalForce = GravitationalConstant * mass * particle.mass / (distance * distance)
        particle.applyForce(displacement.normalized * gravitationalForce)
        if ((position - particle.position).magnitude < radius) {
            particle.status = .blackHole
        }
    }
}
