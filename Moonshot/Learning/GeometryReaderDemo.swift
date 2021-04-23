//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct GeometryReaderDemo: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                Image("turk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width / 3)
            }
            .frame(width: geo.size.width, alignment: .center)
        }
    }
}

struct GeometryReaderDemo_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderDemo()
    }
}
