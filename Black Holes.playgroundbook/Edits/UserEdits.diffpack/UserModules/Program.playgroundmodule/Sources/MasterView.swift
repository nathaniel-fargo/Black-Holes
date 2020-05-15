import UIKit
import SwiftUI

protocol CustomView: UIView {
    func updateFrame()
}
protocol MasterDelegate {
    func loadSetupView()
    func loadREADME()
    func loadRenderView(with options: UniverseOptions)
    func loadDisplayView(with image: UIImage)
}
public class MasterView: UIView, MasterDelegate, CustomView {
    
    var previousFrame: CGRect?
    var currentView: CustomView?
    
    var setupView: SetupView?
    
    public func start() {
        setup()
        checkView()
    }
    
    func setup() {
        backgroundColor = .black
//        loadREADME()
        loadSetupView()
    }
    
    func loadREADME() {
        removeCurrentView()
        let readmeView = README(frame: frame)
        readmeView.setup(self)
        addSubview(readmeView)
        currentView = readmeView
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            self.checkView()
        }
        // Check if needed
        if let prev = previousFrame {
            if frame != prev {
                updateFrame()
            } else {
                return
            }
        }
        previousFrame = frame
    }
}
