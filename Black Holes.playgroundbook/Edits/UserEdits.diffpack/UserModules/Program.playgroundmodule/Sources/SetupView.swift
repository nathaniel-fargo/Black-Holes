import SwiftUI

struct WhiteText: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
    }
}

struct SetupView: View {
    
    @State private var n: Double = 0
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            Image(uiImage: #imageLiteral(resourceName: "black-hole-nasa.jpg"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .offset(x: 0, y: -50)
                .colorMultiply(.init(white: 0.7))
            VStack {
                WhiteText(text: "Render a Black Hole")
                    .font(.system(size: 50))
                WhiteText(text: "Here you can customize how you would like to create your black hole")
                    .font(.system(size: 50))
                Slider(value: $n, in: -10...10, step: 1)
                Text("\(n) is a number")
                    .foregroundColor(.white)
            }
        }
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
