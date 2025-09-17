//
//  FirestoreMigration.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 17/9/25.
//

import Foundation
import FirebaseFirestore

struct FirestoreMigration {
    
    static func addAverageRatingToAllProducts() async throws {
        let db = Firestore.firestore()
        let productsCollection = db.collection("products")
        
        let snapshot = try await productsCollection.getDocuments()
        
        for doc in snapshot.documents {
            // Decode to Product
            let product = try? doc.data(as: Product.self)
            
            // Calculate average
            if let reviews = product?.reviews, !reviews.isEmpty {
                let total = reviews.compactMap { $0.rating }.reduce(0, +)
                let avg = Double(total) / Double(reviews.count)
                
                // Update Firestore
                try await doc.reference.updateData([
                    "averageRating": avg
                ])
            } else {
                // No reviews → set to 0
                try await doc.reference.updateData([
                    "averageRating": 0
                ])
            }
        }
        
        print("✅ Migration complete: averageRating added to all products")
    }
}
