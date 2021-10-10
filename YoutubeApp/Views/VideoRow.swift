//
//  VideoRow.swift
//  YoutubeApp
//
//  Created by Léa Dukaez on 10/10/2021.
//

import SwiftUI

struct VideoRow: View {
    @ObservedObject var videoPreview: VideoPreview
    @State private var isPresenting = false
    @State private var imageHeight: CGFloat = 0
    
    var body: some View {
        Button {
            // Present the detail sheet
            isPresenting = true
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                // Display the thumbnail image
                GeometryReader { geo in
                    // Create an image from the video preview's data
                    Image(uiImage: UIImage(data: videoPreview.thumbnailData) ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.width*9/16)
                        .clipped()
                        .onAppear {
                            // Update the height of the image so that we can set the frame of the geometry reader to be the frame of the image height
                            imageHeight = geo.size.width * 9 / 16
                        }
                }.frame(height: imageHeight)
                //we set the height explicitly so the geometry reader's proposed height is not collapsed
                
                // Display the video's title
                Text(videoPreview.title).bold()
                
                // Display the video's Date
                Text(videoPreview.date).foregroundColor(.gray)
            }.font(.system(size: 19))
            
        }.sheet(isPresented: $isPresenting, content: {
            VideoDetail(video: videoPreview.video)
        })


    }
}

struct VideoRow_Previews: PreviewProvider {
    static var previews: some View {
        VideoRow(videoPreview: VideoPreview(video: Video()))
    }
}
