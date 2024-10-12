//
//  ProductsSectionView.swift
//  E-Com-SwiftUI
//
//  Created by admin on 11/10/24.
//

import Foundation
import SwiftUI

struct ProductsSectionView: View {
    let title: String
    let products: [Content]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(products.indices, id: \.self) { index in
                        let product = products[index]
                        VStack {
                            if let imageUrl = product.product_image {
                                AsyncImage(url: URL(string: imageUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    Image("product-ph") // Placeholder from assets
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(width: 100, height: 100)
                            }
                            Text(product.product_name ?? "")
                                .font(.caption)
                                .lineLimit(2)
                            Text(product.offer_price ?? "")
                                .font(.headline)
                        }
                        .frame(width: 150)
                    }

                }
                .padding(.horizontal)
            }
        }
    }
}
