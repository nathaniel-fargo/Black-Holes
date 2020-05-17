import SwiftUI

class DisplayView: UIView, CustomView {
    
    var myView: UIView?
    var swiftUIDisplayView: SwiftUIDisplayView?
    var delegate: MasterDelegate!
    
    func updateFrame() {
        myView?.frame = frame
    }
    func setup(_ delegate: MasterDelegate, image: UIImage) {
        self.delegate = delegate
        swiftUIDisplayView = SwiftUIDisplayView(self, image: image)
        let hc = UIHostingController(rootView: swiftUIDisplayView)
        myView = hc.view
        myView!.frame = frame
        addSubview(myView!)
    }
}
struct SwiftUIDisplayView: View {
    
    var superview: DisplayView
    var blackHoleImage: UIImage
    
    @State var openShareSheet: Bool = false
    
    init(_ superview: DisplayView, image: UIImage) {
        self.superview = superview
        blackHoleImage = image
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                WhiteText(text: "Tada!")
                    .font(.largeTitle)
                WhiteText(text: "You just made a black hole")
                    .font(.headline)
                Image(uiImage: blackHoleImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Button(action: {
                    self.openShareSheet = true
                }) {
                    Text("Share!")
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                }
                Button(action: {
                    self.superview.delegate.loadSetupView()
                }) {
                    Text("Make another one")
                        .padding()
                        .foregroundColor(.blue)
                }
            }
            .sheet(isPresented: $openShareSheet) {
                ShareSheet(activityItems: [self.blackHoleImage])
            }
        }
    }
    
}

// This is the part where I thank the Apple Developer Forums instead of Stack Overflow for once lol
struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void
      
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil
      
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }
      
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}
