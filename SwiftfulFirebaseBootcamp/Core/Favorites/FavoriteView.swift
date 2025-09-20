//
//  FavoriteView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 19/9/25.
//

import SwiftUI

struct FavoriteView: View {
    
    @StateObject private var viewModel = FavoriteViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.userFavoriteProducts, id: \.id.self) { item in
                ProductCellViewBuilder(productId: String(item.productId))
                    .contextMenu {
                        Button("Remove from favorites") {
                            viewModel.removeFromFavorites(favoriteProductId: item.id)
                        }
                    }
            }
        }
        .navigationTitle("Favorites")
        .OnFirstAppear {
            viewModel.addListenerForFavorites()
        }
    }
}

#Preview {
    FavoriteView()
}


