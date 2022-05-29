//
//  ContentView.swift
//  SwiftUI-List-Starter
//
//  Created by Sean Allen on 4/23/21.
//

import SwiftUI

struct ViewListView2 : View {
    
    let data = Array(1...100).map({"Item \($0)"})
    
    let layout = [
//        GridItem(.adaptive(minimum: 60, maximum: 100))
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    
    var body: some View {
//        ScrollView{
//            LazyVGrid(columns: layout, spacing: 20, content: {
//                ForEach(data, id: \.self) { item in
//                    VStack{
//                        Capsule()
//                            .fill(Color.blue)
//                            .frame(height:50)
//                        Text(item)
//                    }
//                }
//            })
//            .padding(.horizontal)
//        }
        
        ScrollView(.horizontal){
            LazyHGrid(rows: layout, spacing: 20, content: {
                ForEach(data, id: \.self) { item in
                    VStack{
                        Capsule()
                            .fill(Color.blue)
                            .frame(height:50)
                        Text(item)
                    }
                }
            })
            .padding(.horizontal)
        }
        
        
    }
    
}

struct ViewListView: View {
    
    var videos : [Video] = VideoList.topTen
    
    var body: some View {
        
        NavigationView{
            
            List(videos){ video in
                NavigationLink(destination: VideoDetailView(video: video), label: {
                    if video.id % 2 == 0 {
                        VideoCell(video: video)
                    }
                    else{
                        VideoCell2(video: video)
                    }
                })
            }
            .navigationTitle("Sean's Top 10")
            
        }
        
    }
}

struct VideoCell : View {
    
    var video : Video
    
    var body: some View{
        HStack{
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .cornerRadius(4)
                .padding(.vertical, 5)
            
            VStack(alignment: .leading, spacing: 5){
                Text(video.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct VideoCell2 : View {
    
    var video : Video
    
    var body: some View{
        VStack{
            Image(video.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(4)
                .padding(.vertical, 5)
            
            HStack(alignment: .center, spacing: 5, content: {
                Text(video.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text(video.uploadDate)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ViewListView()
        if #available(iOS 15.0, *) {
            ViewListView2()
        } else {
            // Fallback on earlier versions
        }
    }
}
