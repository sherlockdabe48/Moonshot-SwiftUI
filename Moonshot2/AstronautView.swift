//
//  AstronautView.swift
//  Moonshot
//
//  Created by Antarcticaman on 3/7/2564 BE.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var missions: [Mission] {
        let missionsList: [Mission] = Bundle.main.decode("missions.json")
        var matches = [Mission]()
        
        for mission in missionsList {
            if mission.crew.first(where: {$0.name == astronaut.id}) != nil {
                matches.append(mission)
            }
        }
        return matches
    }
    

    
    
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        Image(self.astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width)
                        
                        Text(self.astronaut.description)
                            .padding()
                            .layoutPriority(1)
                        
                        Text("Missions List")
                            .font(.headline)
                        ForEach(self.missions, id: \.displayName) { mission in
                            
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60)
                                    
                                VStack(alignment: .leading) {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.formattedLaunchDate)
                                        .foregroundColor(.secondary)
                                    
                                }.padding()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[7])
    }
}
