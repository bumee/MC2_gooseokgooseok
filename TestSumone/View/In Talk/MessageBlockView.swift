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
    var Title: String
    @EnvironmentObject var PreviousQuestionList : PreviousQuestionData
    @EnvironmentObject var dataBase: DataManager
    @EnvironmentObject var TodayQuestionList: TodayQuestionData
    var userName: String
    @State var Q_idx = 0
    @State var isWritten = false
    var AnswerList: [String:String]
    
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
            
            ForEach(AnswerList.keys.sorted(), id: \.self) { key in
                VStack{
                    HStack {
                        Text(isWritten ? key : "의문의 사용자")
                            .font(.footnote)
                            .padding(.leading, 20)
                            .padding(.bottom, -4)
                        
                        Spacer()
                    }
                    MessageBubbleView(message: (!isWritten ? "답변을 작성했습니다." : AnswerList[key])!, isFromCurrentUser: false)
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                }
            }
            
            VStack {
                if isWritten {
                    HStack {
                        Spacer()
                        Text(userName)
                            .font(.footnote)
                            .padding(.leading, 20)
                            .padding(.bottom, -4)
                    }
                    MessageBubbleView(message: text.note, isFromCurrentUser: true)
                        .padding(.leading, 16)
                        .padding(.bottom, 16)
                }
                else {
                    Text("")
                }
            }
            
            Spacer()
            
            if !isWritten {
                HStack{
                    TextField("답변을 입력하면 다른 답변을 확인할 수 있습니다.", text: $text.note, axis: .vertical)
                        .padding()
                        .textFieldStyle(.roundedBorder)
                        .focused($focus, equals:  true)
                    Button {
                        if text.updating {
                            isWritten = true
                            TodayQuestionList.addAnswerTodayQuestion(TodayQuestion: Title, Statement: text.note, userName: userName)
                            TodayQuestionList.real_qeustions_bool[Title] = true
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
}
