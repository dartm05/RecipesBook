//
//  CachedAsyncImage.swift
//  Recipes
//
//  Created by Daniella Arteaga on 25/11/24.
//


import SwiftUI

struct CachedAsyncImage<Content: View, Placeholder: View>: View  {
    @State private var uiImage: UIImage?
    let url: URL?
    let content: (Image) -> Content
    let placeholder: () -> Placeholder
    
    var body: some View {
        if let uiImage = uiImage {
            content(Image(uiImage: uiImage).renderingMode(.original))
        } else {
            placeholder()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        guard let url = url else { return }
        
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            self.uiImage = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageCache.shared.setImage(image, forKey: url.absoluteString)
                    self.uiImage = image
                }
            }
        }
    }
}
