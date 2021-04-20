//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpenseView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)

                            Text(item.type)
                        }

                        Spacer()
                        Text("$\(item.amount, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: removeItems)
            }

            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        showingAddExpenseView.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
        }
        .sheet(isPresented: $showingAddExpenseView) {
            AddView(expenses: self.expenses)
        }
    }


    func removeItems(at offssets: IndexSet) {
        expenses.items.remove(atOffsets: offssets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
