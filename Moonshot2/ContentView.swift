//
//  ContentView.swift
//  Moonshot
//
//  Created by Antarcticaman on 30/6/2564 BE.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingCrews = false
    var showCrewsButtonTitle: String {
        return showingCrews ? "Show Launch Date" : "Show Crews"
    }
    var body: some View {
        
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if !showingCrews {
                            Text(mission.formattedLaunchDate)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        } else {
                            HStack {
                                ForEach(mission.crew, id: \.name) { member in
                                    Text(member.name)
                                        .font(.subheadline)
                                        .textCase(.uppercase)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing : Button("\(showCrewsButtonTitle)"){
                self.showingCrews.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
