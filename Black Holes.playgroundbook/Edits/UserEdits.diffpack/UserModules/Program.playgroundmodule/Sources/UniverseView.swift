import UIKit
public class UniverseView: UIView {
    // Create the universe
    var universe: Universe!
    var universeDisplay: UniverseDisplay!
    var options: UniverseOptions!
    // Has an image view
    var imageView: UIImageView!
    // Shows loading
    var loaderView: UILabel!
    var raysToLoad: Int!
    var iterations: Int = 0
    public func setup (options: UniverseOptions) {
        self.options = options
        universe = options.universe
        universeDisplay = UniverseDisplay(noiseMapResolution: options.imageResolution * 8)
        setup()
    }
    private func setup () {
        if (frame.size == CGSize.zero) {
            // Delays setup a bit
            DispatchQueue.main.async {
                self.setup()
            }
            return
        }
        runLoop()
        loaderView = UILabel(frame: frame)
        raysToLoad = universe.viewRays.count
        loaderView.textColor = #colorLiteral(red: 0.5568627450980392, green: 0.35294117647058826, blue: 0.9686274509803922, alpha: 1.0)
        loaderView.textAlignment = .center
        addSubview(loaderView)
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }
    func loadWithOptions(options: UniverseOptions) {
        self.options = options
        universe = options.universe
    }
    func displayImage(image: UIImage?) {
        imageView.frame = frame
        imageView.image = image
        imageView.layer.magnificationFilter = CALayerContentsFilter.nearest
    }
    func saveImage() {
        if let img = imageView.image {
            UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
        }
    }
    func runLoop () {
        DispatchQueue.main.async {
            self.update()
        }
    }
    func update() {
        universe.update(updateType: options.universeUpdateType)
        iterations += 1
        loaderView.text = "Frame: \(iterations), \(universe.deadRays.count)/\(raysToLoad!) rays loaded"
        if (universe.status == .finished || options.showUniverseCreation) {
            
            let universeImage = universeDisplay.createImage(universe: universe)
            displayImage(image: universeImage)
        }
        if (universe.status != .finished) {
            runLoop()
        }
    }
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        saveImage()
        
    }
}
