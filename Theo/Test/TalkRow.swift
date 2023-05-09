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
            HStack{
                Circle()
                    .frame(width: 8)
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(.top, 8)
            .padding(.bottom, 6)
            
            HStack {
                Text("오늘")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
                
                    Spacer()
            }
            .padding(.bottom, -4)
            
            HStack {
                Text("우리 가족이 가장 자랑스러웠던 순간은 언제인가요?")
                    .font(.title).bold()
                
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
