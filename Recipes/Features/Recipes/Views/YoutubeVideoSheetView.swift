//
//  YoutubeVideoSheetView.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//
import SwiftUI
import WebKit

struct YouTubeWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
