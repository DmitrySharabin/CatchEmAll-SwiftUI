//
//  CreaturesViewModel.swift
//  CatchEmAll
//
//  Created by Dmitry Sharabin on 11.1.23..
//

import Foundation

class CreaturesViewModel: ObservableObject {
    private struct Returned: Codable {
        var count: Int
        var next: String // TODO: Make it optional
        var results: [Result]
    }
    
    struct Result: Codable, Hashable {
        var name: String
        var url: String // URL for detail on pokemon
    }
    
    @Published var creaturesArray: [Result] = []
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon"
    @Published var count = 0
    
    func getData() async {
        print("🕸️ We are accessing the URL  \(urlString)")
        
        // Convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                return
            }
            
            self.count = returned.count
            self.urlString = returned.next
            self.creaturesArray = returned.results
        } catch {
            print("😡 ERROR: Could not use URL at \(urlString) to get data and response")
        }
    }
}
