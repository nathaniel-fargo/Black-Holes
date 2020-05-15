import UIKit

class WarningView: UIView, CustomView {
    
    var delegate: MasterDelegate!
    
    func setup(_ delegate: MasterDelegate) {
        self.delegate = delegate
        setup()
    }
    private func setup() {
        let label = UILabel(frame: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height / 2))
        label.text = "Welcome to my little project, once you have turned off \"Enable results\" (shown below), just tap the screen to get started!"
        label.textAlignment = .center
        label.numberOfLines = 10
        label.textColor = .white
        addSubview(label)
        
        let helpfulImage = UIImageView(frame: CGRect(x: frame.minX, y: frame.minY + frame.height / 2, width: frame.width, height: frame.height / 2))
        helpfulImage.image = #imageLiteral(resourceName: "enable-results-off.jpg")
        helpfulImage.contentMode = .scaleAspectFit
        addSubview(helpfulImage)
    }
    func updateFrame() {
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        setup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate.loadSetupView()
    }
}
