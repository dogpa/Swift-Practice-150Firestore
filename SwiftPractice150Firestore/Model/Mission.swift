//
//  Mission.swift
//  SwiftPractice150Firestore
//
//  Created by Dogpa's MBAir M1 on 2022/5/3.
//

import Foundation

///id 為 firestore資料的id
///thing為輸入的任務
struct Mission : Identifiable {
    var id : String
    var thing : String
}
