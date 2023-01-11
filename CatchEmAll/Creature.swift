//
//  Creature.swift
//  CatchEmAll
//
//  Created by Dmitry Sharabin on 11.1.23..
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    
    var name: String
    var url: String // URL for detail on pokemon
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}
