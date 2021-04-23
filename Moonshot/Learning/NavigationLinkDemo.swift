//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct NavigationLinkDemo: View {
    var body: some View {
        NavigationView {
            List(0 ..< 100) { row in
                NavigationLink(
                    destination: Text("Detail \(row)"),
                    label: {
                        Text("Row \(row)")
                    })
            }

            .navigationBarTitle("SwiftUI")
        }
    }
}

struct NavigationLinkDemo_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkDemo()
    }
}
