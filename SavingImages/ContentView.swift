//
//  ContentView.swift
//  SavingImages
//
//  Created by Mohammad Azam on 12/21/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var photoVM = PhotoViewModel()
    
    var body: some View {
        VStack {
            
            if let image = photoVM.image {
                Image(uiImage: image)
            }
            
            Button("Download Image") {
                photoVM.downloadImage()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
