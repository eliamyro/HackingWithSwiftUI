//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct ScrollViewDemo: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(0..<100) {
                    CustomText("Text \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomText: View {
    var text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText \(text)")
        self.text = text
    }
}

struct ScrollViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewDemo()
    }
}
