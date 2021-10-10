//
//  Response.swift
//  YoutubeApp
//
//  Created by Léa Dukaez on 10/10/2021.
//

import Foundation

struct Response: Decodable {
    
    var items: [Video]
        
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = try container.decode([Video].self, forKey: .items)
    }
}
