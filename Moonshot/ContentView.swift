//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var isSpooky = false

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(getSubView(mission: mission))
                    }
                }
            }

            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Spooky") {
                self.isSpooky.toggle()
            })
        }
    }

    func getSubView(mission: Mission) -> String {
        if isSpooky {
            let ids = mission.crew.map { $0.name }
            var names = [String]()

            for name in ids {
                let astronaut = astronauts.first(where: {$0.id == name})
                names.append(astronaut?.name ?? "")
            }

            return names.joined(separator: ", ")
        } else {
            return mission.formattedLaunchDate
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
