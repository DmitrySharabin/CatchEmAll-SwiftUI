//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Dmitry Sharabin on 11.1.23..
//

import SwiftUI

struct CreaturesListView: View {
    let creatures = ["Pikachu", "Squirtle", "Charzard", "Snorlax"]
    
    var body: some View {
        NavigationStack {
            List(creatures, id: \.self) { creature in
                Text(creature)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
        }
    }
}

struct CreaturesListView_Previews: PreviewProvider {
    static var previews: some View {
        CreaturesListView()
    }
}
