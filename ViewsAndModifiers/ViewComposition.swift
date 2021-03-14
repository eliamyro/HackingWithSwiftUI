//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct ViewComposition: View {

    var body: some View {
        ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 10) {
                CapsuleTextView(title: "First button")
                    .foregroundColor(Color.red)
                CapsuleTextView(title: "Second button")
                    .foregroundColor(Color.white)
            }
        }
    }
}

struct CapsuleTextView: View {

    var title: String

    var body: some View {
        Text(title)
            .font(.largeTitle)
            .padding()
            .frame(width: 320)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ViewComposition_Previews: PreviewProvider {
    static var previews: some View {
        ViewComposition()
    }
}
