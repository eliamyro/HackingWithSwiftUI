//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct CustomBidingDemo: View {
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        let blur = Binding<CGFloat> (
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}

struct CustomBidingDemo_Previews: PreviewProvider {
    static var previews: some View {
        CustomBidingDemo()
    }
}
