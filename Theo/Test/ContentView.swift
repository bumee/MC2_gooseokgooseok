//
//  ContentView.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TalkList()
                .tabItem {
                    Label("대화", systemImage: "message")
                }
            
            QuestionList()
                .tabItem {
                    Label("질문", systemImage: "plus.message.fill")
                }
            
            CalendarList()
                .tabItem {
                    Label("캘린더", systemImage: "calendar")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
