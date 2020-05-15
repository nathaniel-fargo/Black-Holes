import UIKit
class RenderView: UIView, CustomView {
    
    var delegate: MasterDelegate!
    // Create the universe
    var universe: Universe!
    var universeDisplay: UniverseRenderer!
    var options: UniverseOptions!
    // Shows loading
    var loaderView: UILabel!
    var raysToLoad: Int!
    var iterations: Int = 0
    func setup (_ delegate: MasterDelegate, options: UniverseOptions) {
        self.delegate = delegate
        self.options = options
        universe = options.getUniverse()
        universeDisplay = UniverseRenderer(noiseMapResolution: options.imageResolution * 8)
        raysToLoad = universe.viewRays.count
        loaderView = UILabel(frame: frame)
        loaderView.textColor = #colorLiteral(red: 0.5568627450980392, green: 0.35294117647058826, blue: 0.9686274509803922, alpha: 1.0)
        loaderView.numberOfLines = 3
        loaderView.textAlignment = .center
        addSubview(loaderView)
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
        if (universe.status == .finished) {
            loaderView.text = "Creating Final Image..."
            
            let universeImage = universeDisplay.createImage(universe: universe)
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
