//
//  Video.swift
//  YoutubeApp
//
//  Created by Léa Dukaez on 10/10/2021.
//

import Foundation

struct Video: Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        
        case videoId = "id"
        case snippet
        case thumbnails
        case high
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        // Parse Title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        
        // Parse Description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        
        // Parse published Date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
        // Parse thumbnails
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy:  CodingKeys.self, forKey: .thumbnails)
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy:  CodingKeys.self, forKey: .high)
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        // Parse Video ID
        self.videoId = try container.decode(String.self, forKey: .videoId)

    }

}
