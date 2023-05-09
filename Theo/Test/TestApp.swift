//
//  TestApp.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

@main
struct TestApp: App {
    var body: some Scene {
        WindowGroup {
             ContentView()
                .environment(\.locale, .init(identifier: "kr"))
        }
    }
}
