import UIKit
import SwiftUI
import Program

public enum MasterViewStartingPoint {
    case warning
    case setup
}
protocol CustomView: UIView {
    func updateFrame()
}
protocol MasterDelegate {
    func loadSetupView()
    func loadWarningView()
    func loadRenderView(with options: UniverseOptions)
    func loadDisplayView(with image: UIImage)
}
public class MasterView: UIView, MasterDelegate, CustomView {
    
    var previousFrame: CGRect!
    var currentView: CustomView?
    
    var setupView: SetupView?
    
    public func start(with startingPoint: MasterViewStartingPoint) {
        backgroundColor = .black
        switch startingPoint {
        case .warning:
            loadWarningView()
        default:
            loadSetupView()
        }
        previousFrame = frame
        checkView()
    }
    
    
    func loadWarningView() {
        removeCurrentView()
        let warningView = WarningView(frame: frame)
        warningView.setup(self)
        addSubview(warningView)
        currentView = warningView
    }
    
    func loadSetupView() {
        removeCurrentView()
        if setupView != nil {
            setupView!.frame = frame
            setupView!.updateFrame()
            addSubview(setupView!)
            currentView = setupView!
        } else {
            setupView = SetupView(frame: frame)
            setupView!.setup(self)
            loadSetupView()
        }
    }
    func loadRenderView(with options: UniverseOptions) {
        removeCurrentView()
        let renderView = RenderView(frame: frame)
        renderView.setup(self, options: options)
        addSubview(renderView)
        currentView = renderView
    }
    func loadDisplayView(with image: UIImage) {
        removeCurrentView()
        let displayView = DisplayView(frame: frame)
        displayView.setup(self, image: image)
        addSubview(displayView)
        currentView = displayView
    }
    func removeCurrentView() {
        if let viewToRemove = currentView {
            viewToRemove.removeFromSuperview()
        }
    }
    func updateFrame() {
        currentView?.frame = frame
        currentView?.updateFrame()
    }
    func checkView () {
        // Set loop
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.checkView()
        }
        // Check if needed
        if frame != previousFrame {
            previousFrame = frame
            updateFrame()
        } else {
            return
        }
    }
}
