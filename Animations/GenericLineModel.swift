//
// Copyright © 2021 Eurobank Ergasias EFG
// All rights reserved.
//

import Foundation

class GenericLineModel {
    var top: CGFloat
    var leading: CGFloat
    var trailing: CGFloat

    init(top: CGFloat = 20, leading: CGFloat = 16, trailing: CGFloat = 0) {
        self.top = top
        self.leading = leading
        self.trailing = trailing
    }
}
