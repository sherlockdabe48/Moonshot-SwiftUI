//
//  MissionView.swift
//  Moonshot
//
//  Created by Antarcticaman on 2/7/2564 BE.
//

import SwiftUI

struct MissionView: View {
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
      
    }
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text("Launch Date \(self.mission.formattedLaunchDate)")
                        .font(.title)
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 164, height: 120)
                                    .clipShape(Circle())
                                    .scaledToFill()
                                    .overlay(Circle().stroke(crewMember.role == "Commander" ? Color.blue : Color.clear, lineWidth: 2))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                    }
                    Spacer(minLength: 25)
                    
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[4], astronauts: astronauts)
    }
}
