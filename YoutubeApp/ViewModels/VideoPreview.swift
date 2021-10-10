//
//  VideoPreview.swift
//  YoutubeApp
//
//  Created by Léa Dukaez on 10/10/2021.
//

import Foundation
import Alamofire

class VideoPreview: ObservableObject {
    @Published var thumbnailData = Data()
    @Published var title: String
    @Published var date: String
    
    var video: Video
    
    init(video: Video) {
        
        // Set the video and title
        self.video = video
        self.title = video.title
        
        // set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.date = df.string(from: video.published)
        
        // download the image data
        guard video.thumbnail != "" else { return }
        
        // Check cache before downloading Data
        if let cacheData = CacheManager.getVideoCache(video.thumbnail) {
            // Set the thumbnail data
            thumbnailData = cacheData
            return
        }
        
        // Get a url from the thumbnail
        guard let url = URL(string: video.thumbnail) else { return }
        //  Create the request
        AF.request(url).validate().responseData { response in
            if let data = response.data {
                // Save the data in the cache
                CacheManager.setVideoCache(video.thumbnail, data)
                
                // Set the image
                self.thumbnailData = data
            }
        }
    }
}
