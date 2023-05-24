//
//  PreviousAnswerView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import SwiftUI


struct MessageBubbleView: View {
    let message: String
    let isFromCurrentUser: Bool
    @State var animate : Bool
    
    var body: some View {
        if isFromCurrentUser {
            HStack {
                Spacer()
                Text(message)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color.accentColor)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                .cornerRadius(12)}
        } else {
            HStack {
                Text(message)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(animate ? Color.accentColor : Color.init(uiColor: .secondarySystemBackground))
                    .multilineTextAlignment(.leading)
                    .cornerRadius(12)
                Spacer()
            }
            .animation(Animation.easeInOut.speed(1.0), value: animate)
        }
    }
}
