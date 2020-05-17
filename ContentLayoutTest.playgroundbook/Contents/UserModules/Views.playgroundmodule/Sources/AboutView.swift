import SwiftUI

class AboutView: UIView, CustomView {
    
    var myView: UIView?
    var swiftUIAboutView: SwiftUIAboutView?
    
    func updateFrame() {
        myView?.frame = frame
    }
    func setup(_ delegate: MasterDelegate) {
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
            Image(uiImage: #imageLiteral(resourceName: "BlackBlackHole.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorMultiply(.init(white: 0.8))
                .blur(radius: 8)
            ScrollView {
                WhiteText(text: "Black Holes")
                    .font(.largeTitle)
                WhiteText(text: "About")
                    .font(.headline)
                WhiteText(text: "This is what Black Holes might actually look like if gravity didn't bend light")
                Image(!!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                WhiteText(text: "As the light comes off of the back of the accretion disk, it bends around the black hole, making the illusion that the disk is bent upwards. The same happens for the bottom, as the light goes downwards it bends underneath the black hole towards the viewer. That's why you get the idea that the disk is actually split apart")
                Image(!!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                WhiteText(text: "In order to simulate that, this program implements ray-casting made entirely from stratch. The camera sends out thousands of rays all around the black hole. The ones nearest to the black hole bend, either hitting the disk, or creating a warped image of space that you have today")
                Image(!!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                WhiteText("Hope you've enjoyed!")
                Button(action: {
                    self.delegate.loadSetupView()
                }) {
                    Text("Back")
                        .padding()
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
}
