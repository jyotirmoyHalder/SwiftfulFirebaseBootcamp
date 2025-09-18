//
//  ProductCellView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 16/9/25.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            .shadow(color: Color.black.opacity(0.3) ,radius: 4, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title ?? "n/a")
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                Text("Price: $" + String(product.price ?? 0))
                Text("Rating: " + String(format: "%.2f", product.averageRating ?? 0))
                Text("Category: " + (product.category ?? "n/a"))
                Text("Brand: " + (product.brand ?? "n/a"))
            }
            .font(.callout)
            .foregroundStyle(Color.secondary)
        }
    }
}

//#Preview {
//    ProductCellView(product: Product(id: 1, title: "Text", category: "test", description: "some description", price: 2.22, discountPercentage: 0.32, reviews: [], stock: 5, brand: "demo brand", thumbnail: "some thumbnail", images: []))
//}
