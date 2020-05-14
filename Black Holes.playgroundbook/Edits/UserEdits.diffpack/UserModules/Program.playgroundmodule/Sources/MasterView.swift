import UIKit
import SwiftUI


public class MasterView: UIView {
    
    
    public override var frame: CGRect {
        didSet {
            updateSubviews()
        }
    }
    
    var currentView: UIView?
    
    /*
    var options = UniverseOptions(
    universeUpdateType: .together,
    universeRadius: 2000,
    imageResolution: 512,
    blackHolePosition: Vector3(0, 0, 1000),
    cameraViewFieldAngle: 1,
    ringAngleInDegrees: -3)
     */
    
    var setupView: SetupView!
    
    public func start() {
        // Loops until the frame exists
        if frame.size == CGSize.zero {
            DispatchQueue.main.async {
                self.start()
            }
            return
        }
        // Waits one extra second for things to get setup
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setup()
        }
    }
    
    func setup() {
        setupView = SetupView()
        let vc = UIHostingController(rootView: setupView)
        vc.view.frame = frame
        currentView = vc.view
        addSubview(currentView!)
    }
    
    func updateSubviews() {
        currentView?.frame = frame
    }
    
}