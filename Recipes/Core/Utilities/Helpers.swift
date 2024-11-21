//
//  Helpers.swift
//  Recipes
//
//  Created by Daniella Arteaga on 19/11/24.
//
import SwiftUI

 func openWebsite(urlString: String) {
    guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else {
        print("Invalid URL: \(urlString)")
        return
    }
    UIApplication.shared.open(url)
}
