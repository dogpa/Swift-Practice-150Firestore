//
//  SwiftPractice150FirestoreApp.swift
//  SwiftPractice150Firestore
//
//  Created by Dogpa's MBAir M1 on 2022/5/3.
//

import SwiftUI
import Firebase

@main
struct SwiftPractice150FirestoreApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
