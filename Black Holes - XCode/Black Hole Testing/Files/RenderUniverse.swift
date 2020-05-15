import UIKit
import GameKit // for noise

public class UniverseRenderer {
    
    var noiseSource: GKNoiseSource
    var noiseMap: GKNoiseMap
    var noiseResolution: Double
    
    public init (noiseMapResolution res: Double) {
        noiseSource = GKPerlinNoiseSource(frequency: 0.25, octaveCount: 6, persistence: 0.5, lacunarity: 2, seed: Int32.random(in: 0...256))
        let noise = GKNoise(noiseSource)
        noise.clamp(lowerBound: -1, upperBound: 1)
        noiseResolution = res
        noiseMap = GKNoiseMap(noise, size: vector_double2(x: res, y: res), origin: vector_double2(x: 0, y: 0), sampleCount: vector_int2(x: Int32(res), y: Int32(res)), seamless: true)
    }
    func getNoise(at x: Float, and y: Float) -> CGFloat {
        let divisor: Float = 1
        let rawNoise = noiseMap.value(at: vector_int2(x: Int32(x / divisor), y: Int32(y / divisor)))
        return CGFloat(rawNoise)
    }
    
    func createImage(from universe: Universe, with options: UniverseOptions) -> UIImage {
        let frame = universe.status == .finished ? universe.finalFrame : universe.frame
        let renderer = UIGraphicsImageRenderer(bounds: frame)
        let image: UIImage = renderer.image { (ctx) in
            // Here is where all the drawing takes place
            let context = ctx.cgContext
            
            switch universe.status {
            case .awake:
                return drawUniverse(on: context, with: universe)
            case .finished:
                return drawFinalImage(on: context, with: universe, and: options)
            }
        }
        return image
    }
    
    func drawUniverse(on context: CGContext, with universe: Universe) {
        
        context.setFillColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        context.fill(universe.frame)
        
        context.setFillColor(#colorLiteral(red: 0.803921568627451, green: 0.803921568627451, blue: 0.803921568627451, alpha: 1.0))
        context.fillEllipse(in: universe.ring.frame)
        context.setFillColor(#colorLiteral(red: 0.2549019607843137, green: 0.27450980392156865, blue: 0.30196078431372547, alpha: 1.0))
        context.fillEllipse(in: universe.ring.innerFrame)
        context.setFillColor(#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
        context.fillEllipse(in: universe.blackHole.frame)
        
        context.setFillColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
        universe.viewRays.forEach { (ray) in
            context.addEllipse(in: ray.frame)
        }
        context.fillPath()
    }
    func drawFinalImage(on context: CGContext, with universe: Universe, and options: UniverseOptions) {
        let sizeOne = CGSize(width: 1, height: 1)
        
        universe.deadRays.forEach { (ray) in
            let pos = ray.position
            switch ray.status {
            case .blackHole:
                context.setFillColor(#colorLiteral(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            case .infinity:
                let brightness = getNoise(
                    at: Float(Map(value: Double(atan2(pos.y, pos.z)), fromMin: -Double.pi, fromMax: Double.pi, toMin: 0, toMax: noiseResolution)),
                    and: Float(Map(value: Double(atan2(pos.x, pos.z)), fromMin: -Double.pi, fromMax: Double.pi, toMin: 0, toMax: noiseResolution))
                ) * 2 - 1
                context.setFillColor(gray: brightness, alpha: 1)
            case .ring:
                let distFactor = Map(value: (universe.ring.position - pos).magnitude, fromMin: universe.ring.innerRadius, fromMax: universe.ring.outerRadius, toMin: 0, toMax: 1)
                let noise = getNoise(
                    at: distFactor * Float(noiseResolution), and: 0) * 2 + 0.5
                let brightness = (noise / 4 + 0.75) * CGFloat(1.5 - distFactor)
                let rgb = options.ringColor.rgb()!
                print(rgb)
//                let rgb = options.ringColor.cgColor.components!
                
                context.setFillColor(red: rgb.red * brightness, green: rgb.green * brightness, blue: rgb.blue * brightness, alpha: 1)
            default:
                context.setFillColor(#colorLiteral(red: 0.3411764705882353, green: 0.6235294117647059, blue: 0.16862745098039217, alpha: 1.0))
            }
            context.fill(CGRect(origin: ray.drawPosition, size: sizeOne))
        }
    }
}
