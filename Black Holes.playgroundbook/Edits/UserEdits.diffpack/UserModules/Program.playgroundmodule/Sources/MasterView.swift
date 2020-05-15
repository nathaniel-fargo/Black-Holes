import UIKit
import SwiftUI


public class MasterView: UIView {
    
    
    public override var frame: CGRect {
        didSet {
            updateSubviews()
            loadSetupView()
            
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
    
    public func start() {
        // Loops until the frame exists
        if frame.size == CGSize.zero {
            DispatchQueue.main.async {
                self.start()
            }
            return
        }
        // Waits one extra second for things to get setup
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setup()
        }
    }
    
    func setup() {
        loadREADME()
//          loadSetupView()
        
    }
    
    func loadREADME() {
        removeCurrentView()
        var readmeView = README(frame: frame)
        readmeView.setup()
        addSubview(readmeView)
    }
    
    func loadSetupView() {
        removeCurrentView()
        let setupView = SetupView()
        let vc = UIHostingController(rootView: setupView)
        vc.view.frame = frame
        currentView = vc.view
        addSubview(currentView!)
    }
    func removeCurrentView() {
        if let viewToRemove = currentView {
            viewToRemove.removeFromSuperview()
        }
    }
    func updateSubviews() {
        currentView?.frame = frame
    }
    
}
