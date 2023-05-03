//
//  LoginView.swift
//  TestSumone
//
//  Created by kibum on 2023/05/03.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var nickname = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to my App")
                    .font(.title)
                    .padding()
                TextField("Email", text: $nickname)
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
                .padding()
                NavigationLink(destination: MainView(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                .transition(.slide)
            }
        }
    }
}

