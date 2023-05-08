//
//  MessageBlockView.swift
//  TestSumone
//
//  Created by g eun on 2023/05/04.
//

import SwiftUI

struct MessageBlockView: View {
    
    @StateObject var text: AnswerTextData
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    
    var body: some View {
        VStack{
            HStack {
                
                VStack {
                    Text("05/25")
                        .font(.footnote)
                        .foregroundColor(Color(uiColor: .systemGray))
                    
                    HStack{
                        
                        Text("오늘 한 주 동안 당신의 삶에서 일어난 긍정적인 일은 무엇인가요?")
                            .padding(EdgeInsets(top: -1, leading: 16, bottom: 10, trailing: 16))
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .bold()

                    }
                }
            }
            Divider()
            
            VStack{
                HStack {
                    Text("사용자1")
                        .font(.footnote)
                        .padding(.leading, 20)
                        .padding(.bottom, -4)
                    Spacer()
                }
                MessageBubbleView(message: "답변을 작성했습니다.", isFromCurrentUser: false)
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
                MessageBubbleView(message: "답변을 작성했습니다.", isFromCurrentUser: false)
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
                MessageBubbleView(message: "답변을 작성했습니다.", isFromCurrentUser: false)
                    .padding(.leading, 16)
                    .padding(.bottom, 16)
            }
            
            Spacer()
            
            HStack{
                TextField("답변을 입력하면 다른 답변을 확인할 수 있습니다.", text: $text.note, axis: .vertical)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .focused($focus, equals:  true)
                Button {
                    if text.updating {
                        
                    } else {
                        
                    }
                } label: {
                    Image(systemName: "arrow.up")
                }
                .buttonStyle(.borderedProminent)
                .disabled(text.incomplete)
                .padding(.trailing, 10)
            }
        }
    }
}

struct MessageBlockView_Previews: PreviewProvider {
    static var previews: some View {
        MessageBlockView(text: AnswerTextData())
    }
}
