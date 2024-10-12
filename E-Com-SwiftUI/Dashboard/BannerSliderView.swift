//
//  BannerSliderView.swift
//  E-Com-SwiftUI
//
//  Created by admin on 11/10/24.
//

import Foundation
import SwiftUI

struct BannerSliderView: View {
    let banner : [Content]
    @State private var currentPage = 0 // State variable to track the current page

    var body: some View {
        VStack {
            TabView(selection: $currentPage) { // Bind currentPage to TabView
                ForEach(banner.indices, id: \.self) { index in
                    if let imageUrl = banner[index].image_url {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            Image("banner-image-ph") // Placeholder from assets
                                .resizable()
                                .scaledToFit()
                        }
                        .tag(index) // Tag each view with its index
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Disable default page indicator
            .frame(height: 200)
            
            // Custom Page Control
            PageControl(currentPage: $currentPage, numberOfPages: banner.count)
                .frame(width: CGFloat(banner.count * 15)) // Adjust width based on number of pages
        }
    }
}
