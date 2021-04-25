

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct URLSessionDemo: View {
    @State private var results = [Result]()
    @State private var isProgress = false

    var body: some View {
        ZStack {
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)

                    Text(item.collectionName)
                }
            }

            if !isProgress {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
        }
        .onAppear(perform: loadData)
    }

    private func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Fetch failed: \(error.localizedDescription)")
                return
            }

            guard let data = data else { return }
            let decoder = JSONDecoder()
            if let decodedResponse = try? decoder.decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.isProgress.toggle()
                    self.results = decodedResponse.results
                }
            }
        }.resume()

    }
}

struct URLSessionDemo_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionDemo()
    }
}
