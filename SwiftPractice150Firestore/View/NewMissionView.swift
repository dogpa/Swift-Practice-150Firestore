//
//  NewMissionView.swift
//  SwiftPractice150Firestore
//
//  Created by Dogpa's MBAir M1 on 2022/5/3.
//

import SwiftUI

struct NewMissionView: View {
    
    //透過AppStorage紀錄addState的值在NewMissionView為true
    @AppStorage("addState") var addState = true
    
    //儲存新任務上傳Firestore
    @State var newMission = ""
    
    //取用Firestore上傳的Function
    @StateObject var firestoreVM = FirestoreViewModel()
    
    
    var body: some View {
        VStack{
            Text("建立新Ｍission")
                .font(.system(size: 30))
            Spacer()
            TextField("新Mission", text: $newMission)
                .padding(10)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .font(.system(size: 14, weight: .heavy, design: .rounded))
                .border(.green, width: 4)
                .background(.white)
                .foregroundColor(.blue)
                .padding()
                Spacer()
            
            //將addState bool 反轉，讓ContentView判斷是否顯示NewMissionView
            Button(action: {
                addState.toggle()
            }, label: {
                Text("返回")
                    .frame(width: 200, height: 70)
                    .foregroundColor(.white)
                    .background(.brown)
                    .padding()
            })
            
            //執行上傳的function
            //順便將addState bool 反轉，讓ContentView判斷是否顯示NewMissionView
            Button(action: {
                firestoreVM.addMission(mission: newMission)
                addState.toggle()
                newMission = ""
            }, label: {
                Text("送出")
                    .frame(width: 200, height: 70)
                    .foregroundColor(.white)
                    .background(.black)
                    .padding()
            })
        }
    }
}


