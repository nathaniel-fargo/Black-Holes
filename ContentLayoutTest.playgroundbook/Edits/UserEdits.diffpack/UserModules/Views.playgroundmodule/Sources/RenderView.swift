import UIKit
import Program

class RenderView: UIView, CustomView {
    
    var delegate: MasterDelegate!
    // Create the universe
    var universe: Universe!
    var renderer: UniverseRenderer!
    var options: UniverseOptions!
    // Shows loading
    var loaderView: UILabel!
    var raysToLoad: Int!
    var iterations: Int = 0
    func setup (_ delegate: MasterDelegate, options: UniverseOptions) {
        self.delegate = delegate
        self.options = options
        backgroundColor = .black
        loaderView = UILabel(frame: frame)
        loaderView.textColor = .blue
        loaderView.numberOfLines = 3
        loaderView.textAlignment = .center
        loaderView.text = "Creating Universe..."
        loaderView.font = .monospacedSystemFont(ofSize: 30, weight: .bold)
        addSubview(loaderView)
        DispatchQueue.main.async {
            self.createUniverse()
        }
    }
    func createUniverse() {
        universe = options.getUniverse()
        raysToLoad = universe.viewRays.count
        renderer = UniverseRenderer(noiseMapResolution: options.imageResolution * 4)
        runLoop()
    }
    func runLoop () {
        DispatchQueue.main.async {
            self.update()
        }
    }
    func update() {
        universe.update(updateType: options.universeUpdateType)
        iterations += 1
        if (universe.deadRays.count == raysToLoad) {
            loaderView.text = "Creating Final Image..."
        }
        if (universe.status == .finished) {
            let universeImage = renderer.createImage(from: universe, with: options)
            delegate.loadDisplayView(with: universeImage)
        } else {
            loaderView.text = "Frame: \(iterations)\n\(universe.deadRays.count)/\(raysToLoad!) rays loaded"
            runLoop()
        }
    }
    func updateFrame() {
        loaderView.frame = frame
    }
}
