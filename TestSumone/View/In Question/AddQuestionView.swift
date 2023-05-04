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
    @State private var customQuestion = ""
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
                            WaitingQuestionList.questions.append(self.customQuestion)
                            print(WaitingQuestionList.questions)

                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                                if granted {
                                    // Step 2: Create a notification content object
                                    let content = UNMutableNotificationContent()
                                    content.title = "질문 등록 완료!"
                                    content.subtitle = "작성하신 질문이 성공적으로 등록되었습니다!"
                                    content.body = "알림을 눌러 작성하신 질문을 확인해보세요!"
                                    content.sound = UNNotificationSound.default

                                    // Step 3: Create a notification trigger object
                                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                                    // Step 4: Create a notification request object
                                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                                    // Step 5: Add the notification request to the notification center
                                    UNUserNotificationCenter.current().add(request)
                                    print("알림 성공인데?")
                                } else {
                                    print("Notification permission denied")
                                }
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
