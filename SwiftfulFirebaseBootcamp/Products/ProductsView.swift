//
//  ProductsView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 15/9/25.
//

import SwiftUI
import FirebaseFirestore


struct ProductsView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.products) { product in
                ProductCellView(product: product)
                    .contextMenu {
                        Button("Add to favorites") {
                            viewModel.addUserFavoriteProduct(productId: product.id)
                        }
                    }
                
                if product == viewModel.products.last {
                    ProgressView()
                        .onAppear {
                            viewModel.getProducts()
                        }
                }
            }
            
        }
        .navigationTitle("Products")
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Menu("Filter: \(viewModel.selectedFilter?.rawValue ?? "NONE")") {
                    ForEach(ProductsViewModel.FilterOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await viewModel.filterSelected(option: option)
                            }
                        }
                    }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Filter: \(viewModel.selectedCategory?.rawValue ?? "NONE")") {
                    ForEach(ProductsViewModel.CategoryOption.allCases, id: \.self) { option in
                        Button(option.rawValue) {
                            Task {
                                try? await viewModel.categorySelected(option: option)
                            }
                        }
                    }
                }
            }
        })
        .onAppear {
            viewModel.getProducts()
        }
    }
}

#Preview {
    NavigationStack {
        ProductsView()
    }
}
