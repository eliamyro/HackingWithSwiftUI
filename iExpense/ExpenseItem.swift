//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}
