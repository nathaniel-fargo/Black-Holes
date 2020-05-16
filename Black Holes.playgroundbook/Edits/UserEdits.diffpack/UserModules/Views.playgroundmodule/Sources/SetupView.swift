import SwiftUI
import Program

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
struct ColorBox: Identifiable, Hashable {
    var id = UUID()
    var uiColor: UIColor
}
struct SwiftUISetupView: View {
    @State private var sliderResolution: Double = 7
    @State private var doBlackHoles: Bool = true
    @State private var showRing: Bool = true
    private var ringAngleValues = [0, 3, 10, 45, 60, 80, 90, 100, 120, 135, 170, 177]
    @State private var ringAngleIndex: Double = 1
    @State private var simulationSpeed: Float = 0.7
    private var ringColors: [ColorBox] = [
        ColorBox(uiColor: UIColor.red), 
        ColorBox(uiColor: UIColor.orange), 
        ColorBox(uiColor: UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)),
        ColorBox(uiColor: UIColor.green), 
        ColorBox(uiColor: UIColor.cyan),
        ColorBox(uiColor: UIColor.blue),
        ColorBox(uiColor: UIColor.purple),
        ColorBox(uiColor: UIColor.systemPink),
        ColorBox(uiColor: UIColor.brown)
    ]
    @State private var ringColor: UIColor = .orange
    
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
//                  .offset(x: 0, y: 0)
                .colorMultiply(.init(white: 0.8))
                .blur(radius: 8)
            VStack {
                WhiteText(text: "Render a Black Hole")
                    .font(.largeTitle)
                WhiteText(text: "Settings")
                    .font(.headline).padding(.bottom, 20)
                ScrollView {
                    VStack {
                        Toggle(isOn: $doBlackHoles) {
                            WhiteText(text: "Black Holes")
                        }
                        Toggle(isOn: $showRing) {
                            WhiteText(text: "Show Accretion Disk")
                        }
                        HStack {
                            WhiteText(text: "Resolution: \(Int(pow(2, sliderResolution)))")
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
                            WhiteText(text: "Simulation Speed: \(Int(simulationSpeed * 5 - 1))")
                                .scaledToFit()
                            Slider(value: $simulationSpeed, in: 0.4...1.8, step: 0.2)
                        }
                        WhiteText(text: "Lower values take longer but make the image smoother and more realistic")
                            .font(.footnote)
                        HStack {
                            Picker(selection: $ringColor, label: WhiteText(text: "Ring Color")) {
                                ForEach(ringColors) { (color) in
                                    Color(color.uiColor).tag(color.uiColor)
                                }
                            }.scaledToFill()
                        }
                    }.padding()
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
            }
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


