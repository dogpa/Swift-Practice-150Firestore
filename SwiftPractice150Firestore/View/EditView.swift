//
//  EditView.swift
//  SwiftPractice150Firestore
//
//  Created by Dogpa's MBAir M1 on 2022/5/4.
//

import SwiftUI

struct EditView: View {
    
    //取用FirestoreViewModel內的update function
    @StateObject var firestoreVM = FirestoreViewModel()
    
    //透過AppStorage紀錄editState的值在EditView為true
    @AppStorage("editState") var editState = true
    
    //接收編輯的Mission ID
    @Binding var editId: String
    
    //接收準備編輯的Mission thing
    @Binding var editThing: String
    
    
    var body: some View {
        VStack{
            Text("修改Ｍission")
                .font(.system(size: 30))
            Spacer()
            TextField("修改Mission", text: $editThing)
                .padding(10)
                .textFieldStyle(.roundedBorder)
                .multilineTextAlignment(.center)
                .font(.system(size: 14, weight: .heavy, design: .rounded))
                .border(.yellow, width: 4)
                .background(.white)
                .foregroundColor(.purple)
                .padding()
            Spacer()
            
            //將editState bool 反轉，讓ContentView判斷是否顯示EditView
            Button(action: {
                editState.toggle()
            }, label: {
                Text("返回")
                    .frame(width: 200, height: 70)
                    .foregroundColor(.white)
                    .background(.brown)
                    .padding()
            })
            
            //執行update的function
            //順便將editState bool 反轉，讓ContentView判斷是否顯示EditView
            Button(action: {
                firestoreVM.updateMission(id: editId, thing: editThing)
                editState.toggle()
            }, label: {
                Text("修改")
                    .frame(width: 200, height: 70)
                    .foregroundColor(.white)
                    .background(.black)
                    .padding()
            })
        }
    }
}


