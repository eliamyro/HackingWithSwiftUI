//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct WrapViewControllerDemo: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePickerDemo(image: $inputImage)
        }
    }

    private func loadImage() {
        guard let inputImage = inputImage else {
            return
        }

        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaverDemo()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }
}

struct WrapViewControllerDemo_Previews: PreviewProvider {
    static var previews: some View {
        WrapViewControllerDemo()
    }
}
