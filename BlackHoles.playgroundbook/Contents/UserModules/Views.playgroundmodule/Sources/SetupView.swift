import Program
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
struct ColorBox: Identifiable, Hashable {
    var id = UUID()
    var uiColor: UIColor
}
struct SwiftUISetupView: View {
    @State private var sliderResolution: Double = 7
    @State private var doBlackHoles: Bool = true
    @State private var showRing: Bool = true
    private var ringAngleValues = [0, 2, 3, 5, 10, 45, 87, 90, 135, 170, 176, 179]
    @State private var ringAngleIndex: Double = 2
    @State private var simulationSpeed: Float = 0.8
    private var ringColors: [ColorBox] = [
        ColorBox(uiColor: UIColor.red), 
        ColorBox(uiColor: UIColor.orange), 
        ColorBox(uiColor: UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)),
        ColorBox(uiColor: UIColor.green), 
        ColorBox(uiColor: UIColor.cyan),
        ColorBox(uiColor: UIColor.blue),
        ColorBox(uiColor: UIColor(red: 1, green: 0, blue: 1, alpha: 1)),
        ColorBox(uiColor: UIColor.systemPink),
        ColorBox(uiColor: UIColor.brown),
        ColorBox(uiColor: UIColor.white)
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
            Image(uiImage: #imageLiteral(resourceName: "BlackBlackHole.png"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .colorMultiply(.init(white: 0.8))
                .blur(radius: 8)
            VStack {
                VStack {
                    WhiteText(text: "Render a Black Hole")
                        .font(.largeTitle)
                    WhiteText(text: "Settings")
                        .font(.title)
                }
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
                            Picker("Color", selection: $ringColor) {
                                ForEach(ringColors) { (color) in
                                    Color(color.uiColor).tag(color.uiColor)
                                }
                            }
                                .pickerStyle(DefaultPickerStyle())
//                                .scaledToFill()
                                .foregroundColor(.white)
                        }
                    }.padding()
                }
                Button(action: {
                    self.loadRenderView()
                }) {
                    Text("Render!")
                        .fontWeight(.bold)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(3)
                }
                Button(action: {
                    self.delegate.loadAboutView()
                }) {
                    Text("About")
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


