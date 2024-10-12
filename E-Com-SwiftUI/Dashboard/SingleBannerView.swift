//
//  SingleBannerView.swift
//  E-Com-SwiftUI
//
//  Created by admin on 11/10/24.
//

import Foundation
import SwiftUI

struct SingleBannerView: View {
    let imageUrl: String

    var body: some View {
        VStack {
            if let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image("single-banner-ph") // Your placeholder image
                        .resizable()
                        .scaledToFit()
                }
            } else {
                Image("single-banner-ph")
                    .resizable()
                    .scaledToFit()
                    .padding(8)
            }
        }
        .frame(height: 200) // Adjust the frame as per your design
    }
}

