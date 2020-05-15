import UIKit

class README: UIView {
    
    override var frame: CGRect {
        didSet {
            subviews.forEach { (view) in
                view.removeFromSuperview()
            }
            setup()
        }
    }
    
    func setup() {
        var label = UILabel(frame: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height / 2))
        label.text = "Welcome to my little project, I hope you have turned off \"Enable results\" by now, once you have, just tap the screen!"
        addSubview(label)
        var helpfulImage = UIImageView(frame: CGRect(x: frame.minX, y: frame.minY + frame.height / 2, width: frame.width, height: frame.height / 2))
        helpfulImage.image = #imageLiteral(resourceName: "enable-results-off.jpg")
        helpfulImage.contentMode = .scaleAspectFit
        addSubview(helpfulImage)
    }

}
