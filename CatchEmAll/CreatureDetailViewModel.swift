//
//  CreatureDetailViewModel.swift
//  CatchEmAll
//
//  Created by Dmitry Sharabin on 11.1.23..
//

import Foundation

@MainActor
class CreatureDetailViewModel: ObservableObject {
    private struct Returned: Codable {
        var height: Double?
        var weight: Double?
        var sprites: Sprite
    }
    
    struct Sprite: Codable {
        var front_default: String?
        var other: Other
    }
    
    struct Other: Codable {
        var officialArtwork: OfficialArtwork
        
        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }
    
    struct OfficialArtwork: Codable {
        var front_default: String?
    }
    
    var urlString = ""
    @Published var height = 0.0
    @Published var weight = 0.0
    @Published var imageURL = ""
    
    func getData() async {
        print("πΈοΈ We are accessing the URL  \(urlString)")
        
        // Convert urlString to a special URL type
        guard let url = URL(string: urlString) else {
            print("π‘ ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Try to decode JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("π‘ JSON ERROR: Could not decode returned JSON data")
                return
            }
            
            self.height = returned.height ?? 0
            self.weight = returned.weight ?? 0
            self.imageURL = returned.sprites.other.officialArtwork.front_default ?? "n/a" // Don't use empty string β it converts to a valid URL and won't create an error
        } catch {
            print("π‘ ERROR: Could not use URL at \(urlString) to get data and response")
        }
    }
}
