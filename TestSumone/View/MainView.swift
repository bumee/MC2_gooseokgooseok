//
//  ContentView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/27.
//

//import SwiftUI
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

import SwiftUI

struct MainView: View {
    @State private var selection = 0
    @EnvironmentObject var questions: QuestionData
    @EnvironmentObject var waitingQuestions: WaitingQuestionData
    @State private var nickname = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            if isLoggedIn {
                TabView {
                    TalkView(QuestionList: _questions)
                        .tabItem {
                            Text("Talk")
                                .font(.largeTitle)
                        }
                        .tag(0)
                    QuestionView(WaitingQuestionList: _waitingQuestions)
                        .tabItem {
                            Text("Question")
                                .font(.largeTitle)
                        }
                        .tag(1)
                    Text("Third View")
                        .tabItem {
                            Text("Calendar")
                                .font(.largeTitle)
                        }
                        .tag(2)
                }
            }
            else {
                VStack {
                    Text("가족썸원 ㅋㅋ")
                        .font(.title)
                        .padding()
                    TextField("이름", text: $nickname)
                    Button(action: {
                        // 로그인 버튼이 눌렸을 때 처리해야 할 작업을 구현합니다.
                        print("로그인 버튼이 눌렸습니다.")
                        self.isLoggedIn = true
                    }) {
                        Text("로그인")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                }
            }
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            .navigationTitle("Detail View")
    }
}

struct AnotherView: View {
    var body: some View {
        Text("Another View")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            .navigationTitle("Another View")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
