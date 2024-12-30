import SwiftUI

struct ColorGradientView: UIViewRepresentable {
    var radius: CGFloat

    @Binding var brightness: CGFloat

    let imageView = UIImageView()

    func makeUIView(context: Context) -> UIImageView {
        imageView.image = renderFilter()
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.image = renderFilter()
    }

    /// Generate the CIHueSaturationValueGradient and output it as a UIImage.
    func renderFilter() -> UIImage {
        let filter = CIFilter(name: "CIHueSaturationValueGradient", parameters: [
            "inputColorSpace": CGColorSpaceCreateDeviceRGB(),
            "inputDither": 0,
            "inputRadius": radius * 0.4,
            "inputSoftness": 0,
            "inputValue": brightness
        ])!

        /// Output as UIImageView
        let image = UIImage(ciImage: filter.outputImage!)
        return image
    }
}

#Preview {
    ColorGradientView(
        radius: 350,
        brightness: .constant(
            0.5
        )
    )
    .frame(width: 350, height: 350)
    .preferredColorScheme(.dark)
}

#Preview {
    ColorGradientView(
        radius: 350,
        brightness: .constant(
            0.5
        )
    )
    .frame(width: 350, height: 350)
    .preferredColorScheme(.dark)
}
