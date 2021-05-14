//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct ActionSheetDemo: View {
    @State private var showingActionSheet: Bool = false
    @State private var backgroundColor: Color = .white
    
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet, content: {
                ActionSheet(title: Text("Change background color"),
                            message: Text("Select a new color"),
                            buttons: [
                                .default(Text("Red")) { self.backgroundColor = .red },
                                .default(Text("Yellow")) { self.backgroundColor = .yellow },
                                .default(Text("Blue")) { self.backgroundColor = .blue },
                                .cancel()
                            ])
            })
    }
}

struct ActionSheetDemo_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetDemo()
    }
}
