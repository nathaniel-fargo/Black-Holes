import SwiftUI

class AboutView: UIView, CustomView {
    
    var myView: UIView?
    var swiftUIAboutView: SwiftUIAboutView?
    
    var alertView: UIView?
    
    func updateFrame() {
        myView?.frame = frame
    }
    func setup(_ delegate: MasterDelegate, image: UIImage) {
        swiftUIAboutView = SwiftUIAboutView(delegate)
        let hc = UIHostingController(rootView: swiftUIAboutView)
        myView = hc.view
        myView!.frame = frame
        addSubview(myView!)
    }
}
struct SwiftUIAboutView: View {
    
    var delegate: MasterDelegate
    
    init(_ delegate: MasterDelegate) {
        self.delegate = delegate
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                WhiteText(text: "Tada!")
                    .font(.largeTitle)
                WhiteText(text: "You just made a black hole!")
                    .font(.headline)
            }
        }
    }
    
}
