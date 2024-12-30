import SwiftUI

public struct ColorWheelView: View {
    @Binding private var color: RGB
    @Binding private var brightness: CGFloat
    
    public init(
        color: Binding<RGB>,
        brightness: Binding<CGFloat>
    ) {
        self._color = color
        self._brightness = brightness
    }
    
    public var body: some View {
        GeometryReader { geometry in
            let radius = min(geometry.size.width, geometry.size.height)
            
            ZStack {
                ColorGradientView(
                    radius: radius,
                    brightness: $brightness
                )
                .blur(radius: 12)
                .clipShape(.circle)
                
                // Color Selection Indicator
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .offset(
                        x: (radius / 2 - 10) * color.hsv.s,
                        y: 0
                    )
                    .rotationEffect(.degrees(-Double(color.hsv.h)))
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        updateColor(with: value, in: geometry)
                    }
            )
        }
        .aspectRatio(1, contentMode: .fit) // Ensures square aspect ratio
    }
    
    private func updateColor(with value: DragGesture.Value, in geometry: GeometryProxy) {
        let radius = min(geometry.size.width, geometry.size.height)
        let center = CGPoint(
            x: geometry.frame(in: .local).midX,
            y: geometry.frame(in: .local).midY
        )
        
        let location = value.location
        let y = center.y - location.y
        let x = location.x - center.x
        
        let hue = GeometryUtils.angleToHue(atan2(y, x))
        let saturation = min(
            GeometryUtils.distance(from: center, to: location) / (radius / 2),
            1
        )
        
        let newColor = HSV(h: hue, s: saturation, v: brightness).rgb
        color = newColor
    }
}

// MARK: - Preview Wrapper

// TODO: switch to @previewable
struct PreviewWrapper: View {
    @State private var color = RGB(color: .red)
    @State private var brightness: CGFloat = 1.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack {
                Text("Brightness: \(String(format: "%.2f", brightness))")
                    .bold()
                Slider(value: $brightness, in: 0 ... 1)
            }
            
            Spacer()
            
            ColorWheelView(
                color: $color,
                brightness: $brightness
            )
            .padding()
            
            Spacer()
            HStack {
                VStack {
                    Text("RGB Values")
                        .bold()
                        .foregroundStyle(.secondary)

                    Text("R: \(String(format: "%.2f", color.r))")
                    Text("G: \(String(format: "%.2f", color.g))")
                    Text("B: \(String(format: "%.2f", color.b))")
                }
                Spacer()
                
                VStack {
                    Text("HSV Values")
                        .bold()
                        .foregroundStyle(.secondary)
                    
                    Text("H: \(String(format: "%.1f", color.hsv.h))°")
                    Text("S: \(String(format: "%.2f", color.hsv.s))")
                    Text("V: \(String(format: "%.2f", color.hsv.v))")
                }
            }
        }
        .padding()
        .background(color.color.opacity(0.02))
    }
}

#Preview("Color Wheel") {
    PreviewWrapper()
        .preferredColorScheme(.light)
}

#Preview("Color Wheel Dark") {
    PreviewWrapper()
        .preferredColorScheme(.dark)
}
