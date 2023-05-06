//
//  MessageAnswerView.swift
//  TestSumone
//
//  Created by 조용현 on 2023/05/04.
//

import SwiftUI

struct MessageAnswerView: View {
    
    @StateObject var text: TextStruct
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    
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
            HStack {
                Text("👨사용자1")
                //                .padding()
                Spacer()
            }
            MessageBubbleView(message: "                            ", isFromCurrentUser: false)
                .overlay {
                    HStack {
                        Image("dot")
                            .padding(.leading, 50)
                        Spacer()
                    }
                }
            HStack {
                Text("👨사용자2")
                //                .padding()
                Spacer()
            }
            MessageBubbleView(message: "                            ", isFromCurrentUser: false)
                .overlay {
                    HStack {
                        Image("dot")
                            .padding(.leading, 50)
                        Spacer()
                    }
                }
                .padding(.bottom, 10)
        ScrollView {
            HStack(alignment:.top) {
//                    ScrollView {
                        TextField("Note", text: $text.note, axis: .vertical)
                            .focused($focus, equals: true)
//                    }

                    Spacer()
                    Button {
                        if text.updating {
                            
                        } else {
                            
                        }
                    } label: {
                        Text("Send")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(text.incomplete)
                }
//            .frame(height: 400)
            
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
            Spacer()
        }
}

struct MessageAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        MessageAnswerView(text: TextStruct())
    }
}
