//
//  MessageView.swift
//  TestSumone
//
//  Created by kibum on 2023/05/03.
//

import Foundation
import SwiftUI

struct MessageShowingView: View {
    var Title: String
    
    var body: some View {
        VStack{
            HStack {
                
                VStack {
                    Text("05/25")
                        .font(.footnote)
                        .foregroundColor(Color(uiColor: .systemGray))
                    
                    HStack{
                        
                        Text(Title)
                            .padding(EdgeInsets(top: -1, leading: 16, bottom: 10, trailing: 16))
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .bold()

                    }
                }
            }
            Divider()

            ScrollView {
                VStack{
                    HStack {
                        Text("사용자1")
                            .font(.footnote)
                            .padding(.leading, 20)
                            .padding(.bottom, -4)
                        Spacer()
                    }
                    MessageBubbleView(message: "답변1", isFromCurrentUser: false)
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                }
                .padding(.top, 16)
                
                VStack{
                    HStack {
                        Text("사용자2")
                            .font(.footnote)
                            .padding(.leading, 20)
                            .padding(.bottom, -4)
                        Spacer()
                    }
                    MessageBubbleView(message: "답변2", isFromCurrentUser: false)
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                }
                
                VStack{
                    HStack {
                        Text("사용자3")
                            .font(.footnote)
                            .padding(.leading, 20)
                            .padding(.bottom, -4)
                        Spacer()
                    }
                    MessageBubbleView(message: "답변3", isFromCurrentUser: false)
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                }
                
                VStack{
                    HStack {
                        Spacer()
                        Text("사용자4")
                            .font(.footnote)
                            .padding(.trailing, 20)
                            .padding(.bottom, -4)
                    }
                    MessageBubbleView(message: "내가 작성한 답변입니다.", isFromCurrentUser: true)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                }
            }
            
            Spacer()
            
        }
    }
}

//SF Pro Display
