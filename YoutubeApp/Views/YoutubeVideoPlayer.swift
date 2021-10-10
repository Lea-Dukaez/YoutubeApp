//
//  YoutubeVideoPlayer.swift
//  YoutubeApp
//
//  Created by Léa Dukaez on 10/10/2021.
//

import SwiftUI
import WebKit

struct YoutubeVideoPlayer: UIViewRepresentable {
    var video: Video

    func makeUIView(context: Context) -> some UIView {
        // Create the web view
        let view = WKWebView()
        
        view.backgroundColor = UIColor(backgroundColor)
        // Create the url for the video
        let embedUrlString = K.YOUTUBE_EMBED_URL + video.videoId
        
        // Load the video into the webview
        let url = URL(string: embedUrlString)
        let request = URLRequest(url: url!)
        view.load(request)
        
        // Return the webview
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct YoutubeVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeVideoPlayer(video: Video())
    }
}
