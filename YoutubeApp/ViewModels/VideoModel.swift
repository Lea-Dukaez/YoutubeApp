//
//  VideoModel.swift
//  YoutubeApp
//
//  Created by Léa Dukaez on 10/10/2021.
//

import Foundation
import Alamofire

class VideoModel: ObservableObject {
    
    @Published var videos = [Video]()
    
    init() {
        getVideos()
    }
    
    
    func getVideos() {
        // Create URL Object
        guard let url = URL(string: "\(K.API_URL)/videos") else { return }
        
        // Get a decoder
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        //Create a URL Request
        AF.request(
            url,
            parameters: ["part": "snippet", "chart": "mostPopular", "maxResults": "10", "regionCode": "FR", "key": Secret.API_KEY]
        )
        .validate()
        .responseDecodable(of: Response.self, decoder: decoder) { response in
            
            // Check that the call was successful
            switch response.result {
            case .success:
                break
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
            
            // Update the UI with the video
            if let items = response.value?.items {
                DispatchQueue.main.async {
                    self.videos = items
                }
            }
        }
    }
}
