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
    @State private var text = ""
    @EnvironmentObject var WaitingQuestionList : WaitingQuestionData


    var body: some View {
        NavigationView {
            VStack {
                TextField("여기에 등록하시고 싶은 질문을 입력해주세요!", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("등록하기") {
                    // Perform some action with the entered text
                    print("Entered text: \(self.text)")
                    WaitingQuestionList.questions.append(self.text)
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
                }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .navigationBarTitle("질문 등록")
                .navigationBarItems(trailing: Button("취소") {
                    self.presentationMode.wrappedValue.dismiss()
                })
        }
    }
}
