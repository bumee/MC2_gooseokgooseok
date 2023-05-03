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
                Text("05/04")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 1)
                Spacer()
            }
            
            HStack {
                Text("오늘 몰 먹어야 잘먹었다고 생각이 들까요?")
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
