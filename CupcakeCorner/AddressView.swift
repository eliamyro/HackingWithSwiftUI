//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderWrapper: OrderWrapper

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderWrapper.order.name)
                TextField("Street Address", text: $orderWrapper.order.streetAddress)
                TextField("City", text: $orderWrapper.order.city)
                TextField("ZIP", text: $orderWrapper.order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(orderWrapper: orderWrapper)) {
                    Text("Check out")
                }
            }
            .disabled(orderWrapper.order.hasValidAddress == false)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderWrapper: OrderWrapper())
    }
}
