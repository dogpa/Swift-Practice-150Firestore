//
//  FirestoreViewModel.swift
//  SwiftPractice150Firestore
//
//  Created by Dogpa's MBAir M1 on 2022/5/3.
//

import Foundation
import Firebase

final class FirestoreViewModel : ObservableObject {
    
    //儲存讀取後的任務
    @Published var missionList = [Mission]()
    
    //建立Firestore
    let firestore = Firestore.firestore()
    
    ///取得資料後透過Main Thread更新畫面，並存入missionList
    func fetchData () {
        firestore.collection("Mission").getDocuments { data, error in
            if error == nil {
                if let data = data {
                    DispatchQueue.main.async {
                        self.missionList = data.documents.map { thing in
                            return Mission(id: thing.documentID,
                                           thing: thing["thing"] as? String ?? "")
                            
                        }
                    }
                }
            }else{
                print(error!)
            }
        }
    }
    
    /// 新增任務
    ///
    /// - Parameters:
    ///     - mission: 任務名稱
    func addMission(mission:String) {
        firestore.collection("Mission").addDocument(data: ["thing":mission]) { error in
            if error == nil {
                self.fetchData()
            }else{
             print(error!)
            }
        }
    }
    
    /// 刪除任務
    /// - Parameters:
    ///     - delete: 準備刪除的任務 type : Mission
    func deleteMission (delete: Mission) {
        firestore.collection("Mission").document(delete.id).delete { erroe in
            if erroe == nil {
                DispatchQueue.main.async {
                    self.missionList.removeAll() { mission in
                        return mission.id == delete.id
                    }
                }
                self.fetchData()
            }else{
                print(erroe!)
            }
        }
    }
    
    /// 更新任務
    ///
    /// - Parameters:
    ///     - id: 準備刪除的任務的id
    ///     - thing: 準備刪除的任務任務內容
    func updateMission(id:String, thing: String) {
        firestore.collection("Mission").document(id).setData(["thing" : "\(thing)"], merge: true) { error in
            if error != nil {
                print(error!)
            }
            
        }
    }
}
