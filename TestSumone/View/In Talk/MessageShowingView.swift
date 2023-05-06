//
//  MessageView.swift
//  TestSumone
//
//  Created by kibum on 2023/05/03.
//

import Foundation
import SwiftUI

struct MessageShowingView: View {
    
    var body: some View {
        Text("4월 22일(토)")
            .font(.footnote)
            .bold()
        HStack() {
            Spacer()
            Text("한 주동안 당신에게 가장 의미있었던 일은 무엇인가요?")
                .padding()
                .background(Color.gray)
                .multilineTextAlignment(.center)
                .clipShape(MessageBubble(isFromCurrentUser: false))
            Spacer()
        }
        ScrollView {
            HStack {
                Text("👨사용자1")
                    .padding()
                Spacer()
            }
            MessageBubbleView(message: "됐나?", isFromCurrentUser: false)
            HStack {
                Spacer()
                Text("👨사용자2")
                    .padding()
            }
            MessageBubbleView(message: "해치웠나?", isFromCurrentUser: true)
            Spacer()
        }
    }
}

struct MessageShowingView_Previews: PreviewProvider {
    static var previews: some View {
        MessageShowingView()
    }
}
