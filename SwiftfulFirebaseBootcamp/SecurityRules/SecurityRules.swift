//
//  SecurityRules.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 21/9/25.
//

import Foundation


// https://firebase.google.com/docs/rules/rules-language
// https://firebase.google.com/docs/firestore/security/rules-structure

/*
 
 rules_version = '2';

 service cloud.firestore {
   match /databases/{database}/documents {

     // This rule allows anyone with your Firestore database reference to view, edit,
     // and delete all data in your Firestore database. It is useful for getting
     // started, but it is configured to expire after 30 days because it
     // leaves your app open to attackers. At that time, all client
     // requests to your Firestore database will be denied.
     //
     // Make sure to write security rules for your app before that time, or else
     // all client requests to your Firestore database will be denied until you Update
     // your rules
     match /users/{userId} {
       allow read: if request.auth != null;
       allow write: if request.auth != null && request.auth.uid == userId;
       // allow write: if resource.data.user_isPremium == false;
       // allow write: if request.resource.data.custom_key == "1234";
       // allow write: if isPublic()
     }
     
     match /users/{userId}/favorite_products/{userFavoriteProductID} {
       allow read: if request.auth != null;
       allow write: if request.auth != null && request.auth.uid == userId;
     }
     
     match /products/{productId} {
         // allow read, write: if request.auth != null;
       // allow create: if request.auth != null
       // allow read: if request.auth != null && isAdmin(request.auth.uid);
       allow read: if request.auth != null;
       allow create: if request.auth != null && isAdmin(request.auth.uid);
       allow update: if request.auth != null && isAdmin(request.auth.uid);
       allow delete: if false;
     }
     
     //function isPublic() {
     //    return resource.data.visibility == "public";
     //}
     
     function isAdmin(userId) {
         // let adminIds = ["gGCqN9CsXNPq2aXS07fMAbqpfas2", "abc"];
         // return userId in adminIds;
       return exists(/databases/$(database)/documents/admins/$(userId));
     }
   }
 }


 // read
 // get - single document reads
 // list - queries and collection read requests
 //
 // write
 // create - add document
 // update - edit document
 // delete - delete document

 
 */
