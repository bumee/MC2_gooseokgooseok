//
//  AddQuestionView.swift
//  TestSumone
//
//  Created by kibum on 2023/05/02.
//

import Foundation
import SwiftUI
import UserNotifications

struct AddQuestionView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataBase : DataManager
    @State var customQuestion : String =  ""
    @State var userName : String
    
    var WaitingQuestionList : [String]
    
    var body: some View {
        NavigationView() {
            List {
                TextField("질문을 입력해주세요", text: $customQuestion, axis: .vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .autocorrectionDisabled()
            }
            .navigationTitle("새로운 질문")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    if customQuestion != "" {
                        Button(action: {
                            // Perform some action with the entered text
                            print("Entered text: \(self.customQuestion)")
                            dataBase.AddWaitingQuestions(Statement: customQuestion)

                            SendLocalNotification(Title: "성공적인 등록", Subtitle: "와우", body: "확인해보세요!")
                            // Dismiss the modal view
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("완료")
                        })
                    } else {
                        Button(action: {
                        }, label: {
                            Text("완료")
                        })
                        .disabled(true)
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("취소")
                    })
                    .foregroundColor(Color.red)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}
