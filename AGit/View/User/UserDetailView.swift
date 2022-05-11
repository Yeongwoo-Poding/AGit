//
//  UserDetailView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    
    var user: User
    
    var body: some View {
        VStack {
            ZStack {
                Color("Background")
                
                VStack{
                    HStack {
                        ZStack {
                            Circle()
                                .foregroundColor(user.isStudying ? Color("Primary") : Color("Secondary"))
                                .frame(width: screenWidth/2.5)
                            
                            Image("defaultImage")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: screenWidth/3)
                        }
                        
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("Secondary"))
                                    .frame(height: 50)
                                
                                VStack {
                                    Text("오늘 공부 시간")
                                    
                                    Text(secondToTime(second: user.todayStudyTime))
                                }
                            }
                            
                            Spacer().frame(height: 15)
                            
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("Secondary"))
                                    .frame(height: 50)
                                
                                VStack {
                                    Text("평균 공부 시간")
                                    
                                    Text(secondToTime(second: user.totalStudyTime/user.days))
                                }
                            }
                        }
                    }
                    .frame(height: 200)
                    
                    ScrollView(.horizontal){
                        HStack{
                            if user.tags != nil{
                                ForEach(user.tags!, id: \.self){ tag in
                                    Text(tag)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background{
                                            RoundedRectangle(cornerRadius: 5)
                                                .foregroundColor(Color("Secondary"))
                                        }
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(height: 50)
                    
                    HStack{
                        Text("Links")
                        
                        Spacer()
                    }
                    .padding(.horizontal, 30)
                    
                    ScrollView{
                        VStack(spacing: 5){
                            if user.links != nil{
                                ForEach(user.links!, id: \.self){ link in
                                    Button(action: {
                                        print(link.linkUrl)
                                        openURL(URL(string: link.linkUrl)!)
                                    }) {
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width: screenWidth*4/5, height: 30)
                                                .foregroundColor(Color("Secondary"))
                                            Text(link.linkDescription)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            
            Color.black
                .frame(height: 5)
        }
        .navigationTitle(user.nickname)
        .navigationBarTitleDisplayMode(.large)
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("White"))
        .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: Button(action: {  presentationMode.wrappedValue.dismiss() }, label: {
                    HStack(spacing: 2) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color("White"))

                        Text("Back")
                            .foregroundColor(Color("White"))
                    }
                })
            )
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var user = User(id: 1, nickname: "poding", email: "poding")
    @State static var hasBackButton = true
    
    static var previews: some View {
        UserDetailView(user: user)
    }}
