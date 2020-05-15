import SwiftUI

class SetupView: UIView, CustomView {
    
    var myView: UIView?
    
    func updateFrame() {
        myView?.frame = frame
    }
    func setup(_ delegate: MasterDelegate) {
        let swiftUISetupView = SwiftUISetupView(delegate: delegate)
        let hc = UIHostingController(rootView: swiftUISetupView)
        myView = hc.view
        myView!.frame = frame
        addSubview(myView!)
    }
}
struct WhiteText: View {
    var text: String
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
    }
}
struct SwiftUISetupView: View {
    @State private var sliderResolution: Double = 7
    @State private var doBlackHoles: Bool = true
    @State private var showRing: Bool = true
    private var ringAngleValues = [0, 3, 10, 45, 60, 80, 90, 100, 120, 135, 170, 177]
    @State private var ringAngleIndex: Double = 1
    @State private var simulationSpeed: Float = 0.5
    @State private var ringColor: UIColor = .blue
    
    var delegate: MasterDelegate
    
    init(delegate: MasterDelegate) {
        self.delegate = delegate
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            Image(uiImage: #imageLiteral(resourceName: "black-hole-nasa.jpg"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: 0, y: -50)
                .colorMultiply(.init(white: 0.7))
                .blur(radius: 5)
            ScrollView {
                WhiteText(text: "Render a Black Hole")
                    .font(.largeTitle)
                WhiteText(text: "Settings")
                    .font(.headline).padding(.bottom, 20)
                Toggle(isOn: $doBlackHoles) {
                    WhiteText(text: "Black Holes")
                }
                Toggle(isOn: $showRing) {
                    WhiteText(text: "Show Accretion Disk")
                }
                HStack {
                    WhiteText(text: "Resolution: \(round(pow(2, sliderResolution)))")
                        .scaledToFit()
                    Slider(value: $sliderResolution, in: 6...10, step: 1)
                }
                WhiteText(text: "The higher the resolution, the better the image, but the longer it takes. 128-512 recommended")
                    .font(.footnote)
                HStack {
                    WhiteText(text: "Disk Angle: \(ringAngleValues[Int(ringAngleIndex)])")
                        .scaledToFit()
                    Slider(value: $ringAngleIndex, in: 0...Double(ringAngleValues.count - 1), step: 1)
                }
                HStack {
                    WhiteText(text: "Simulation Speed: \(simulationSpeed)")
                        .scaledToFit()
                    Slider(value: $simulationSpeed, in: 0.1...1, step: 0.1)
                }
                HStack {
                    Picker(selection: $ringColor, label: WhiteText(text: "Ring Color")) {
                        Color.red
                        Color.orange
                        Color.yellow
                        Color.green
                        Color.blue
                        Color.purple
                    }.scaledToFill()
                }
                Button(action: {
                    self.loadRenderView()
                }) {
                    Text("Render!")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(10)
                }
            }.padding()
        }
    }
    
    func loadRenderView() {
        var universeOptions = UniverseOptions()
        universeOptions.imageResolution = pow(2, sliderResolution)
        universeOptions.doBlackHoles = doBlackHoles
        universeOptions.showRing = showRing
        universeOptions.ringAngle = 180 - Double(ringAngleValues[Int(ringAngleIndex)])
        universeOptions.simulationSpeed = simulationSpeed
        universeOptions.ringColor = ringColor
        delegate.loadRenderView(with: universeOptions)
    }
    
}


