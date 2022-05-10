//
//  UserDetailView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.openURL) var openURL
    
    var user: User
    @Binding var hasBackButton: Bool
    
    var body: some View {
        VStack {
            NavigationBarView(title: user.nickname, hasBackButton: true)
            
            HStack(spacing: 30) {
                Image("defaultImage")
                    .resizable()
                    .frame(width: screenWidth/2.5, height: screenWidth/2.5)
                    .clipShape(Circle())
                
                VStack{
                    VStack{
                        Text("오늘 공부 시간")
                        Text(secondToTime(second: user.todayStudyTime))
                    }
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 120, height: 50)
                            .foregroundColor(Color("primary"))
                    }
                    
                    VStack{
                        Text("평균 공부 시간")
                        Text(secondToTime(second: user.totalStudyTime/user.days))
                    }
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 120, height: 50)
                            .foregroundColor(Color("primary"))
                    }
                }
            }
            .padding()
            
            ScrollView(.horizontal){
                HStack{
                    if user.tags != nil{
                        ForEach(user.tags!, id: \.self){ tag in
                            Text(tag)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .background{
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color("primary"))
                                }
                        }
                    }
                }
            }
            .padding()
            
            VStack{
                if user.links != nil{
                    ForEach(user.links!, id: \.self){ link in
                        Button(action: {
                            print(link.linkUrl)
                            openURL(URL(string: link.linkUrl)!)
                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: screenWidth*4/5, height: 30)
                                    .foregroundColor(Color("gray"))
                                Text(link.linkDescription)
                            }
                        }
                    }
                }
            }
            
            Spacer()
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("black"))
        .navigationBarHidden(true)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var user = User(id: 1, nickname: "poding", email: "poding")
    @State static var hasBackButton = true
    
    static var previews: some View {
        UserDetailView(user: user, hasBackButton: $hasBackButton)
    }}
