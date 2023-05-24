//
//  QuestionView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/27.
//

import Foundation
import SwiftUI
import Popovers

struct QuestionView: View {
    let items = [1,2,3]
    @State private var isModalShown = false
    @State private var isHelpPopupShown = false
    @EnvironmentObject var WaitingQuestionList: WaitingQuestionData
    @EnvironmentObject var HistoryQuestionList: HistoryQuestionData
    var userName : String
    @EnvironmentObject var dataBase: DataManager

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("대기중")){
                    ForEach(WaitingQuestionList.WaitingQuestions[userName]?.reversed() ?? [String](), id:\.self) { Question in
                        NavigationLink(
                            destination:  QuestionEditingView(PreviousQuestion: Question, userName: userName, WillChangeQuestion: Question)
                        ){
                            WaitingQuestionNameView(text: "\(Question)")
                        }
                    }
                }
                
                Section(header: Text("과거의 질문")){
                    ForEach(HistoryQuestionList.HistoryQuestions[userName]?.reversed() ?? [String](), id:\.self) { Question in
                        WaitingQuestionNameView(text: "\(Question)")
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationTitle("나의 질문")
            .navigationBarItems(
                trailing: HStack(spacing: 12){
                    Button(action: {
                        if !isHelpPopupShown {
                            isHelpPopupShown = true
                        }
                    }){
                        Text("?")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .frame(width:24, height:24)
                            .overlay(
                                  RoundedRectangle(cornerRadius: 12)
                                      .stroke(Color.gray, lineWidth: 2)
                                  )
                            .popover(
                                present: $isHelpPopupShown,
                                attributes: {
                                    $0.presentation.animation = .spring(response: 0.6, dampingFraction: 0.4, blendDuration: 1)
                                    $0.presentation.transition = .offset(x: 0, y: -20).combined(with: .opacity)
                                    $0.dismissal.transition = .offset(x: 0, y: 0).combined(with: .opacity)
                                    $0.rubberBandingMode = .yAxis
                                }
                            ) {
                                VStack{
                                    Spacer().frame(height:4)
                                    HelpPopupView()
                                }
                            }
                    }
                    Button(action: {
                        self.isModalShown = true
                    }){
                        Image(systemName: "plus").bold()
                            .font(.footnote)
                        Text("추가")
                            .font(.footnote)
                            .fontWeight(.black)
                    }
                    .frame(height:32)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(16)
                    .sheet(isPresented: $isModalShown) {
                        AddQuestionView(userName: userName)
                    }
                }
            )
        }
        .onAppear {
            // 서버에 fetching하는 코드 필요
            WaitingQuestionList.fetchWaitingQuestions()
            HistoryQuestionList.fetchHistoryQuestions()
            print(WaitingQuestionList.WaitingQuestions)
        }
    }
}

