//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var alertIsShowing = false

    static let types = ["Business", "Personal"]
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }

            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if validateAmount() {
                    if let actualAmmount = Double(amount) {
                        let expense = ExpenseItem(name: name, type: type, amount: actualAmmount)
                        expenses.items.append(expense)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            })
        }
        .alert(isPresented: $alertIsShowing, content: {
            Alert(title: Text("Error"), message: Text("Amount can be only integer"), dismissButton: .default(Text("OK")))
        })
    }

    func validateAmount() -> Bool {
        guard Int(amount) != nil else {
            self.alertIsShowing.toggle()
            return false
        }

        return true
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
