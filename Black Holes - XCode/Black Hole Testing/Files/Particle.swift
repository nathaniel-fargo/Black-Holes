import CoreGraphics

var ParticleIDCounter: Int = 0

public enum ParticleStatus {
    case alive
    case blackHole
    case infinity
    case ring
}

// Generic Particle class
public class Particle {
    // The values of the light ray
    var position: Vector3
    var velocity: Vector3
    var acceleration = Vector3.zero
    var mass: Float = 1
    public var status: ParticleStatus = .alive
    public let id = { () -> Int in
        ParticleIDCounter += 1
        return ParticleIDCounter
    }()
    var radius: Float = 5
    public var frame: CGRect {
        get {
            return CGRect(x: Double(position.xAxis - radius), y: Double(position.yAxis - radius), width: Double(radius * 2), height: Double(radius * 2))
        }
    }
    
    // Initializers
    public init(position: Vector3, velocity: Vector3, mass: Float) {
        self.position = position
        self.velocity = velocity
        self.mass = mass
    }
    public init(position: Vector3, velocity: Vector3) {
        self.position = position
        self.velocity = velocity
    }
    public convenience init(position: Vector3, mass: Float) {
        self.init(position: position, velocity: Vector3.zero, mass: mass)
    }
    public convenience init(position: Vector3) {
        self.init(position: position, velocity: Vector3.zero)
    }
    public convenience init(velocity: Vector3) {
        self.init(position: Vector3.zero, velocity: velocity)
    }
    public convenience init() {
        self.init(position: Vector3.zero)
    }
    
    // Functions
    public func update(factor: Float) {
        velocity += acceleration * factor
        position += velocity
        acceleration = Vector3.zero
    }
    // Particle Requirement
    public func applyForce(_ force: Vector3) {
        acceleration += force / mass
    }
}
