//
//  TalkRow.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TalkRow: View {
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 8)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
                Text("오늘")
                    .font(.footnote)
                    .opacity(0.6)
                
                Spacer()
            }
            
            HStack {
                Text("우리 가족이 가장 자랑스러웠던 순간은 언제인가요?")
                
                Spacer()
            }
        }
    }
}

struct TalkRow_Previews: PreviewProvider {
    static var previews: some View {
        TalkRow()
    }
}
