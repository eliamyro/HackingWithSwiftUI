//
// Copyright © 2021 Elias Myronidis
// All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]

    init(astronaut: Astronaut) {
        let missions: [Mission] = Bundle.main.decode("missions.json")
        self.astronaut = astronaut
        var matches = [Mission]()
        for mission in missions {
            if let _ = mission.crew.first(where: { $0.name == astronaut.id }) {
                matches.append(mission)
            }
        }

        self.missions = matches
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Text(astronaut.description)
                        .padding()
                        .layoutPriority(1)

                    VStack(alignment: .leading) {
                        HStack {
                            Text("Missions")
                                .font(.headline)

                            Spacer()
                        }
                        .padding([.top, .bottom])

                        ForEach(missions, id: \.id) {
                            Text("Apollo \($0.id)")
                                .padding(.bottom, 0.2)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }

        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
