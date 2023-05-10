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
//            HStack{
//                Circle()
//                    .frame(width: 8)
//                    .foregroundColor(.red)
//                
//                Spacer()
//            }
//            .padding(.top, 8)
//            .padding(.bottom, 6)
//            .frame(height: 24)
            
            HStack {
                Text("오늘")
                    .font(.footnote).bold()
                    .foregroundColor(Color(uiColor: .white))
//                    .foregroundColor(Color(uiColor: .black))
                
                    Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.footnote).bold()
                    .foregroundColor(Color(uiColor: .white))
//                    .foregroundColor(Color(uiColor: .black))
            }
            .padding(.bottom, -4)
            
            HStack {
                Text("우리 가족이 가장 자랑스러웠던 순간은 언제인가요?")
                    .font(.title).bold()
                    .foregroundColor(.white)
//                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(-4)
                
                Spacer()
            }
        }
        .padding()
        .cornerRadius(12)
        .background(Color(uiColor: .systemGreen))
//        .background(Color(uiColor: .secondarySystemBackground))
    }
}

struct TalkRow_Previews: PreviewProvider {
    static var previews: some View {
        TalkRow()
    }
}
