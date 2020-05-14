import CoreGraphics

/// Just like mass these values don't have to match in this simulated environment, as long as the work well together
public let SpeedOfLight: Float = 60

public class Ray: Particle /*, CustomPlaygroundDisplayConvertible */ {
    /*
    public var playgroundDescription: Any {
        get {
            return "Pos: \(position.x.rounded()), \(position.y.rounded()), \(position.z.rounded()), Vel: \(velocity.x.rounded()), \(velocity.y.rounded()), \(velocity.z.rounded())"
        }
    }*/
    
    /// While light rays don't have a "rest mass" they still have a mass by the equation "E = mc^2" While I could calculate that, the factors that go into calculation have no real effect on the simulation, so creating a result that works well in the simulation is more important to me than behind the scenes accuracy
    // var mass: Float = 1
    
    // This is for rendering the image when we finish the simulation, nothing with actual particle movement
    var drawPosition: CGPoint
    
    // Stores how far the ray can go
    var universeRadius: Float
    
    // Initializers
    public init(position: Vector3, drawPosition: CGPoint, direction: Vector3, universeRadius: Float) {
        self.drawPosition = drawPosition
        self.universeRadius = universeRadius
        super.init(position: position, velocity: direction * SpeedOfLight)
        mass = 1 / SpeedOfLight
    }
    public convenience init(drawPosition: CGPoint, direction: Vector3, universeRadius: Float) {
        self.init(position: Vector3.zero, drawPosition: drawPosition, direction: direction, universeRadius: universeRadius)
    }
    public convenience init(drawPosition: CGPoint, universeRadius: Float) {
        self.init(drawPosition: drawPosition, direction: Vector3.zero, universeRadius: universeRadius)
    }
    public convenience init(universeRadius: Float) {
        self.init(drawPosition: CGPoint.zero, universeRadius: universeRadius)
    }
    public convenience init() {
        self.init(universeRadius: 1)
    }
    
    override public func update() {
        velocity += acceleration
        velocity = velocity.normalized * SpeedOfLight
        acceleration = Vector3.zero
        position += velocity
        if (position.magnitude > universeRadius) {
            status = .infinity
        }
    }
}

