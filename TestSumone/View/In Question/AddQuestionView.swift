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
    @EnvironmentObject var TodayQuestion: TodayQuestionData
    @State var customQuestion : String =  ""
    @State var userName : String
    
    @EnvironmentObject var WaitingQuestionList : WaitingQuestionData
    
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
                            if !WaitingQuestionList.WaitingQuestions.keys.contains(userName) {
                                WaitingQuestionList.WaitingQuestions[userName] = [String]()
                            }
                            WaitingQuestionList.WaitingQuestions[userName]!.append(customQuestion)
                            print(WaitingQuestionList.WaitingQuestions)
                            WaitingQuestionList.addWaitingQuestions(WaitingQuestion: customQuestion, userName: userName)
                            if !TodayQuestion.isSimulated{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    if let idx = WaitingQuestionList.WaitingQuestions[userName]!.firstIndex(of: customQuestion) {
                                        WaitingQuestionList.WaitingQuestions[userName]?.remove(at: idx)
                                    }
                                    WaitingQuestionList.deleteWaitingQuestions(WaitingQuestion: customQuestion)
                                    TodayQuestion.saveTodayQuestions(TodayQuestion: customQuestion)
                                    TodayQuestion.real_qeustions_bool[customQuestion] = false
                                    TodayQuestion.isSimulated = true
                                }
                            }
                            else {
                                SendLocalNotification(Title: "성공적인 등록", Subtitle: "와우", body: "확인해보세요!")
                            }
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
