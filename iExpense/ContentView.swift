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
                            .foregroundColor(getStyle(for: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }

            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
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

    func getStyle(for amount: Double) -> Color {
        if amount < 10 {
            return .yellow
        } else if amount < 100 {
            return .green
        } else {
            return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
