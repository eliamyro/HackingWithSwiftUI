//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import Foundation

class User: ObservableObject, Codable {
    @Published var name = "John Smith"

    enum CodingKeys: CodingKey {
        case name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
