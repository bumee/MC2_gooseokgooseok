//
//  PreviousAnswerView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//
import SwiftUI

struct SendMessageView: View {
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            TextField("메시지 입력", text: $messageText)
                .padding()
            Button(action: {
                // 메시지를 보내는 로직 구현
                sendMessage()
            }) {
                Text("보내기")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle("메시지 보내기")
    }
    
    private func sendMessage() {
        // 메시지를 보내는 로직 구현
        print("보낸 메시지: \(messageText)")
        messageText = ""
    }
}

