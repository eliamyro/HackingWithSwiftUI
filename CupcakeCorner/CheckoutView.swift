//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orderWrapper: OrderWrapper
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is \(orderWrapper.order.cost, specifier: "%.2f") €")
                        .font(.title)

                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }

        .navigationBarTitle(Text("Check out"), displayMode: .inline)
    }

    private func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(orderWrapper.order) else {
            print("Failed to encode order")
            return
        }

        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            print("Invalid url")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                self.confirmationMessage = "Something went wrong!"
                self.showingConfirmation = true
                return
            }

            guard let data = data else {
                print("Invalid data")
                return
            }

            let decoder = JSONDecoder()
            if let order = try? decoder.decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(order.quantity)x \(Order.types[order.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderWrapper: OrderWrapper())
    }
}
