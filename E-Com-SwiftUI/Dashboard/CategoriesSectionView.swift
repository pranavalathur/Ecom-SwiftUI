//
//  CategoriesSectionView.swift
//  E-Com-SwiftUI
//
//  Created by admin on 11/10/24.
//

import Foundation
import SwiftUI

struct CategoriesSectionView: View {
    let categories: [Content]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Top Categories")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    // Use array index or unique property for id
                    ForEach(categories.indices, id: \.self) { index in
                        let category = categories[index]
                        VStack {
                            if let imageUrl = category.image_url {
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Image("product-ph") // Placeholder from assets
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(width: 50, height: 50)
                            }
                            Text(category.title ?? "")
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}


