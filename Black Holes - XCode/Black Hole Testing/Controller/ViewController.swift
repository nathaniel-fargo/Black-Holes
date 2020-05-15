import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myView: MasterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myView.start(with: .setup)
    }

}

