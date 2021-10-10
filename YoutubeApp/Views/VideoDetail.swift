//
//  VideoDetail.swift
//  YoutubeApp
//
//  Created by Léa Dukaez on 10/10/2021.
//

import SwiftUI

struct VideoDetail: View {
    var video: Video
    
    var date: String {
        // Create a formatted date from the video's date
        let df = DateFormatter()
        df.dateFormat = "EEEe, MMM d, yyyy"
        return df.string(from: video.published)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(video.title).bold()
            
            Text(date).foregroundColor(.gray)
            
            YoutubeVideoPlayer(video: video).aspectRatio(CGSize(width: 1280, height: 720), contentMode: .fit)
            
            ScrollView {
                Text(video.description)
            }
        }
        .font(.system(size: 19))
        .padding()
        .padding(.top, 40)
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

struct VideoDetail_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetail(video: Video())
    }
}
