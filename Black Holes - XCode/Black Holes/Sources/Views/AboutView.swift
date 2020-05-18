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
struct DescriptiveText: View {
    var text: String
    init (_ text: String) {
        self.text = text
    }
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding()
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
            VStack {
                ScrollView {
                    WhiteText(text: "Black Holes")
                        .font(.largeTitle)
                    WhiteText(text: "About")
                        .font(.title)
                    DescriptiveText("This is what Black Holes would actually look like if gravity didn't bend light. The orange ring around the black hole is called the \"Accretion Disk\", it's a cloud of hot gas that surrounds the black hole, slowly feeding it")
                    Image(uiImage: #imageLiteral(resourceName: "ModelBlackHole.png"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    DescriptiveText("As the light comes off of the back of the accretion disk, it bends around the black hole, making the illusion that the disk is bent upwards. The same happens for the bottom, as the light goes downwards it bends underneath the black hole towards the viewer. This distortion is why you get the idea that the disk is actually split apart")
                    Image(uiImage: #imageLiteral(resourceName: "BendingBlackHole.png"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    DescriptiveText("In order to simulate that, this program implements ray-casting made entirely from stratch. The camera sends out thousands of rays all around the black hole. The ones nearest to the black hole bend, either hitting the disk, or creating a warped image of space that you have today")
                    Image(uiImage: #imageLiteral(resourceName: "RaycastingBlackHole.png"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    DescriptiveText("Hope you've enjoyed!")
                }
                Button(action: {
                    self.delegate.loadSetupView()
                }) {
                    Text("Back")
                        .fontWeight(.bold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .background(Color.white)
                        .cornerRadius(17)
                        .foregroundColor(.blue)
                        .padding(3)
                }
            }
        }
    }
    
}

