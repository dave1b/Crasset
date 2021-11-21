//
//  CircleProfile.swift
//  Crasset
//
//  Created by daniele Muheim on 20.11.21.
//

import SwiftUI

struct CircleProfile: View {
    @State private var isShowingImagePicker = false
    @State private var avatarImage = UIImage(named: "default-avatar")!
    
    var body: some View {
        VStack{
            Image(uiImage: avatarImage)
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(CGSize(width: 50, height: 50), contentMode: .fill)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .onTapGesture {
                    isShowingImagePicker = true
                }
            
        }
        .sheet(isPresented: $isShowingImagePicker, content: {
            ImagePicker(avatarImage: $avatarImage)
        })
        
    }
}

struct CircleProfile_Previews: PreviewProvider {
    static var previews: some View {
        CircleProfile()
    }
}
