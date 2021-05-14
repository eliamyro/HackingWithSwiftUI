//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity: Double = 0.5
    @State private var showingImagePicker = false
    @State private var uiImage: UIImage?
    @State private var currentFilter:CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    @State private var showingErrorAlert = false

    let context = CIContext()

    var body: some View {

        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )

        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)

                    // display the image
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding(.vertical)

                HStack {
                    Button("Change Filter") {
                        self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = processedImage else {
                            self.showingErrorAlert = true
                            return
                        }

                        let imageSaver = ImageSaver()
                        imageSaver.writeToPhotoAlbum(image: processedImage)

                        imageSaver.successHandler = {
                            print("Success")
                        }

                        imageSaver.errorHandler = { error in
                            print("Failed to save \(error.localizedDescription)")
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $uiImage)
        }
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Error"), message: Text("Something happened"), dismissButton: .default(Text("OK")))
        }
        .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Select a filter"), buttons: [
                            .default(Text("Crystalize")) {
                                self.setFilter(CIFilter.crystallize())
                            },
                            .default(Text("Edges")) {
                                self.setFilter(CIFilter.edges())
                            },
                            .default(Text("Gausian Blur")) {
                                self.setFilter(CIFilter.gaussianBlur())
                            },
                            .default(Text("Pixellate")) {
                                self.setFilter(CIFilter.pixellate())
                            },
                            .default(Text("Sepia Tone")) {
                                self.setFilter(CIFilter.sepiaTone())
                            },
                            .default(Text("Unsharp Mask")) {
                                self.setFilter(CIFilter.unsharpMask())
                            },
                            .default(Text("Vignette")) {
                                self.setFilter(CIFilter.vignette())
                            },
                .cancel()
            ])
        }
    }

    private func loadImage() {
        guard let uiImage = uiImage else { return }
        let beginImage = CIImage(image: uiImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }

        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }

        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
