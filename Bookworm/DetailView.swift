//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false

    let book: Book

    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)

                    HStack {
                        Text(formatedDate())
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Capsule())

                        Spacer()

                        Text(book.genre?.uppercased() ?? "Fantasy".uppercased())
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.75))
                            .clipShape(Capsule())
                    }
                    .padding(5)
                }

                Text(book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(book.review ?? "No review")
                    .padding()

                RatingView(rating: .constant(Int(book.rating)))
                    .font(.largeTitle)

                Spacer()
            }
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book?"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                deleteBook()
            }, secondaryButton: .cancel())
        }

        .navigationBarItems(trailing: Button(action: {
            showingDeleteAlert = true
        }, label: {
            Image(systemName: "trash")
        }))
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
    }

    private func deleteBook() {
        moc.delete(book)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }

    private func formatedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: book.date ?? Date())
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationView {
            DetailView(book:PersistenceController.shared.book)
        }
    }
}
