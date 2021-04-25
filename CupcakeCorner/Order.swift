//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import Foundation

class OrderWrapper: ObservableObject {
    @Published var order: Order = Order()
}

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate"]

    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        return true
    }

    var cost: Double {
        // 2 euro per cake
        var cost = Double(quantity) * 2

        cost += (Double(type) / 2)

        if extraFrosting {
            cost += Double(quantity)
        }

        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
