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
    @State var isHidden = true
    var userName: String
    @State var Q_idx = 0
    @State var isWritten = false
    var AnswerList: [String:String]
    var date: String
    @State var animation = false
    
    var body: some View {
        VStack{
            HStack {
                
                VStack {
                    Text(date)
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
                .navigationBarTitleDisplayMode(.inline)
            }
            Divider()
                .padding(.bottom, 8)
            
            ScrollView {
                ForEach(AnswerList.keys.sorted(), id: \.self) { key in
                    VStack{
                        HStack {
                            Text(isWritten ? key : "의문의 사용자")
                                .font(.footnote)
                                .padding(.leading, 20)
                                .padding(.bottom, -4)
                            
                            Spacer()
                        }
                        MessageBubbleView(message: (!isWritten ? "답변을 작성했습니다." : AnswerList[key])!, isFromCurrentUser: false, animate: animation)
                            .padding(.leading, 16)
                            .padding(.bottom, 16)
                            .animation(Animation.easeInOut.speed(2.0), value: animation)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            VStack {
                if isWritten {
                    HStack {
                        Spacer()
                        Text(userName)
                            .font(.footnote)
                            .padding(.leading, 20)
                            .padding(.trailing, 16)
                            .padding(.bottom, -4)
                    }
                    MessageBubbleView(message: text.note, isFromCurrentUser: true, animate: false)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.bottom, 16)
                }
                else {
                    Text("")
                }
            }
            
            Spacer()
            
            if !isWritten {
                HStack{
                    TextField("답변을 입력해주세요!", text: $text.note, axis: .vertical)
                        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 4))
                        .textFieldStyle(.roundedBorder)
                        .focused($focus, equals:  true)
                        .submitLabel(.return)
                    Button {
                        if text.updating {
                            isWritten = true
                            animation.toggle()
                            TodayQuestionList.addAnswerTodayQuestion(TodayQuestion: Title, Statement: text.note, userName: userName)
                            TodayQuestionList.real_qeustions_bool[Title] = true
                        } else {
                            
                        }
                    } label: {
                        Image(systemName: "arrow.up").bold()
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(20)
                    .disabled(text.incomplete)
                    .padding(.trailing, 10)
                }
            }
            
            
        }
        .onDisappear {
            isHidden = false
        }
        .toolbar(isHidden ? .hidden : .visible, for: .tabBar)
    }
}

