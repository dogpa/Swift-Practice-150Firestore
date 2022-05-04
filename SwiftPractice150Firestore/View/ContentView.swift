//
//  ContentView.swift
//  SwiftPractice150Firestore
//
//  Created by Dogpa's MBAir M1 on 2022/5/3.
//

import SwiftUI

struct ContentView: View {
    
    //判斷是否跳到EditView
    @AppStorage("editState") var editState = false
    
    //判斷是否跳到NewMissionView
    @AppStorage("addState") var addState = false
    
    //取用FirestoreViewModel刪除與讀取資料的function
    @StateObject var firestoreVM = FirestoreViewModel()
    
    //儲存選擇編輯的Mission id 與 thing透過Binding傳給編輯的EditView
    @State var editID = ""
    @State var editThing = ""
    
    
    var body: some View {
        //addState 與 editState如果都false顯示mission的list
        
        if !addState, !editState {
            VStack{
                NavigationView{
                    List(firestoreVM.missionList) {thing in
                        Text(thing.thing)
                        
                             //左滑刪除
                            .swipeActions(content: {
                                Button(action: {
                                    firestoreVM.deleteMission(delete: thing)
                                }, label: {
                                    Text("刪除")
                                }).tint(.red)
                            })
                        
                            //左滑編輯指派editID與editThing並將editState的值反轉顯示EditView
                            .swipeActions(content: {
                                Button(action: {
                                    editID = thing.id
                                    editThing = thing.thing
                                    editState.toggle()
                                }, label: {
                                    Text("修改")
                                }).tint(.blue)
                            })

                    }
                    
                    //顯示時讀取資料
                    .onAppear{
                        firestoreVM.fetchData()
                    }
                    .navigationTitle("Mission")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        
                        //按下時addState反轉顯示NewMissionView
                        Button(action: {
                            addState.toggle()

                        }, label: {
                            Text("+")
                                .font(.system(size: 45))
                                .bold()
                        })
                    }
                }
            }
        //addState為true顯示NewMissionView()
        }else if addState {
            NewMissionView()
            
        //editState為true將$editID與$editThing透過Binding傳給EditView
        }else if editState {
            EditView(editId: $editID, editThing: $editThing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
