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
    @EnvironmentObject var HistoryQuestion: HistoryQuestionData
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
                                    HistoryQuestion.HistoryQuestions[userName]?.append(customQuestion)
                                    
                                    if TodayQuestion.real_questions.keys.count == 1 {
                                        TodayQuestion.MoveToPreviousQuestionData(DocumentId: TodayQuestion.real_questions.keys.sorted()[0])
                                        WaitingQuestionList.MoveToHistoryQuestionData(DocumentId: customQuestion)
                                        SendLocalNotification(Title: "오늘의 질문은 무엇일까요?", Subtitle: "오늘의 질문이 도착했습니다!", body: "다른 사람들은 무엇이라고 적었을지 확인해보세요!")
                                        print("질문 도착 알림 보냄")
                                    }
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
