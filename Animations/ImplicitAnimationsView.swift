//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct ImplicitAnimationsView: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        Button("Tap me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmount)
        .blur(radius: (animationAmount - 1) * 3)
        .animation(.default)
    }
}

struct CImplicitAnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        ImplicitAnimationsView()
    }
}
