import Program
import UIKit

class RenderView: UIView, CustomView {
    
    var delegate: MasterDelegate!
    // Create the universe
    var universe: Universe!
    var renderer: UniverseRenderer!
    var options: UniverseOptions!
    // Shows loading
    var loaderLabel: UILabel!
    var cancelButton: UIButton!
    var raysToLoad: Int!
    var iterations: Int = 0
    var runTimer: Timer?
    
    func setup (_ delegate: MasterDelegate, options: UniverseOptions) {
        self.delegate = delegate
        self.options = options
        backgroundColor = .black
        loaderLabel = UILabel(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height / 2))
        loaderLabel.textColor = UIColor.white
        loaderLabel.numberOfLines = 3
        loaderLabel.textAlignment = .center
        loaderLabel.text = "Creating Universe..."
        loaderLabel.font = .monospacedSystemFont(ofSize: 30, weight: .bold)
        addSubview(loaderLabel)
        let width: CGFloat = 100
        let height: CGFloat = 50
        cancelButton = UIButton(frame: CGRect(x: frame.origin.x + frame.width / 2 - width / 2, y: frame.origin.y + frame.height * 3 / 4 - height / 2, width: width, height: height))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        cancelButton.setTitleColor(UIColor(red: 0.01, green: 0.5, blue: 0.9, alpha: 1), for: .normal)
        cancelButton.backgroundColor = UIColor.white
        cancelButton.layer.cornerRadius = height / 2
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        addSubview(cancelButton)
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
            loaderLabel.text = "Creating Final Image..."
        } else {
            loaderLabel.text = "Frame: \(iterations)\n\(universe.deadRays.count)/\(raysToLoad!) rays loaded"
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
    @objc func cancel() {
        runTimer?.invalidate()
        delegate.loadSetupView()
    }
    func runLoop () {
        runTimer = Timer(timeInterval: 0.01, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        RunLoop.current.add(runTimer!, forMode: .default)
    }
    func updateFrame() {
        loaderLabel.frame = frame
    }
}
