//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImageDemo: View {
    @State private var image: Image?
    @State private var amount: Float = 1

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Slider(value: $amount, in: 1 ... 200, step: 1) {_ in
                loadImage()
            }
        }
        .onAppear(perform: loadImage)
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "example") else { return }
        let beginImage = CIImage(image: inputImage)
        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        currentFilter.radius = amount

        guard let outputImage = currentFilter.outputImage else { return }

        if let ciImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: ciImg)
            image = Image(uiImage: uiImage)
        }

    }

}

struct CoreImageDemo_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageDemo()
    }
}
