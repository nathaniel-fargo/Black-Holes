//import Program
import UIKit

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
    var runTimer: Timer?
    
    func setup (_ delegate: MasterDelegate, options: UniverseOptions) {
        self.delegate = delegate
        self.options = options
        backgroundColor = .black
        loaderView = UILabel(frame: frame)
        loaderView.textColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
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
    func updateUI() {
        if (universe.status == .finished) {
            loaderView.text = "Creating Final Image..."
        } else {
            loaderView.text = "Frame: \(iterations)\n\(universe.deadRays.count)/\(raysToLoad!) rays loaded"
        }
    }
    @objc func update() {
        universe.update(updateType: options.universeUpdateType)
        iterations += 1
        if (universe.status == .finished) {
            let universeImage = renderer.createImage(from: universe, with: options)
            runTimer?.invalidate()
            delegate.loadDisplayView(with: universeImage)
        }
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    func runLoop () {
        runTimer = Timer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        RunLoop.current.add(runTimer!, forMode: .default)
    }
    func updateFrame() {
        loaderView.frame = frame
    }
}
