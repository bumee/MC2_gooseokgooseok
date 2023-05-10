//
//  MessageView.swift
//  TestSumone
//
//  Created by kibum on 2023/05/03.
//

import Foundation
import SwiftUI

struct MessageShowingView: View {
    var Title: String
    var MessageList: [String:String]
    
    var body: some View {
        VStack{
            HStack {
                
                VStack {
                    Text("05/25")
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
            }
            Divider()

            ScrollView {
                ForEach(MessageList.keys.sorted(), id: \.self) { key in
                    VStack{
                        HStack {
                            Text(key)
                                .font(.footnote)
                                .padding(.leading, 20)
                                .padding(.bottom, -4)
                            Spacer()
                        }
                        MessageBubbleView(message: MessageList[key]!, isFromCurrentUser: false)
                            .padding(.leading, 16)
                            .padding(.bottom, 16)
                    }
                }
            }
            
            Spacer()
            
        }
    }
}

//SF Pro Display
