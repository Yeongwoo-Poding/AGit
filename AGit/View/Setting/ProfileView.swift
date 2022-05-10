//
//  ProfileView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userModel: UserModel
    @Environment(\.openURL) var openURL
    
    @State var isAddingTag = false
    @State var isDeletingTag = false
    @State var isAddingLink = false
    @State var addTag = ""
    
    var body: some View {
        VStack {
            NavigationBarView(title: userModel.user?.nickname ?? "Guest", hasBackButton: true)
            
            HStack(spacing: 30) {
                Image("defaultImage")
                    .resizable()
                    .frame(width: screenWidth/3, height: screenWidth/3)
                    .clipShape(Circle())
                    
                
                if let user = userModel.user{
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
            }
            .padding()
            
            ScrollView(.horizontal){
                HStack{
                    if userModel.user != nil && userModel.user!.tags != nil{
                        ForEach(userModel.user!.tags!, id: \.self){ tag in
                            ZStack(alignment: .leading){
                                Text(tag)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background{
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(Color("primary"))
                                    }
                                    .onTapGesture {
                                        isDeletingTag = true
                                    }
                                
                                if isDeletingTag{
                                    Button(action: {
                                        userModel.deleteUserTag(tag: tag)
                                    }) {
                                        Image(systemName: "x.circle.fill")
                                    }
                                    .offset(x: -2, y: -12)
                                }
                            }
                        }
                    }
                    
                    if isAddingTag{
                        HStack {
                            Text("#")
                            TextField("태그", text: $addTag){
                                userModel.addUserTag(tag: addTag)
                                addTag = ""
                                isAddingTag = false
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background{
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color("primary"))
                        }
                    }else{
                        if !isDeletingTag{
                            Button(action: {
                                isAddingTag = true
                            }) {
                                Text(" 태그 추가 ")
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
            }
            .padding(.top)
            .padding(.horizontal)
            
            if isDeletingTag {
                Button(action: {
                    isDeletingTag = false
                }) {
                    Text("완료")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background{
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundColor(Color("gray"))
                        }
                        .frame(height: 40)
                }
            }else{
                HStack{
                    Text("Links")
                        .frame(height: 40)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
            }
            
            if userModel.user != nil && userModel.user!.links != nil{
                ScrollView{
                    ForEach(userModel.user!.links!, id: \.self){ link in
                        HStack {
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
                            
                            Button(action: {
                                userModel.deleteUserLink(linkUrl: link.linkUrl)
                            }) {
                                Image(systemName: "x.circle.fill")
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                isAddingLink = true
            }) {
                Text("Add Link")
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("primary"))
                    }
            }
            .sheet(isPresented: $isAddingLink) {
                AddLinkView(isAddingLink: $isAddingLink)
            }
            
            Spacer()
                .frame(height: 30)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("black"))
        .navigationBarHidden(true)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserModel())
    }
}
