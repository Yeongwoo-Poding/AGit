//
//  UserView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var userModel: UserModel
    @Binding var hasBackButton: Bool
    
    @State var searchString = ""
    
    var columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack {
                    NavigationBarView(title: "User", hasBackButton: false)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("닉네임이나 태그를 검색하세요", text: $searchString)
                            .clipShape(RoundedRectangle(cornerRadius: 3))
                        
                        Button(action: {
                            searchString = ""
                        }) {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(Color("black"))
                        }
                    }
                    .padding()
                    
                    ScrollView{
                        LazyVGrid(columns: columns) {
                            if searchString == ""{
                                ForEach(userModel.userList, id: \.self){user in
                                    NavigationLink(destination: {
                                        UserDetailView(user: user, hasBackButton: $hasBackButton)
                                    }) {
                                        UserCellView(user: user)
                                    }
                                }
                            }else if searchString.hasPrefix("#"){
                                ForEach(userModel.userList, id: \.self){ user in
                                    if let tag = user.tags{
                                        if tag.contains(searchString){
                                            NavigationLink(destination: {
                                                UserDetailView(user: user, hasBackButton: $hasBackButton)
                                            }) {
                                                UserCellView(user: user)
                                            }
                                        }
                                    }
                                   
                                }
                            }else{
                                ForEach(userModel.userList, id: \.self){ user in
                                    if user.nickname.lowercased().hasPrefix(searchString.lowercased()){
                                        NavigationLink(destination: {
                                            UserDetailView(user: user, hasBackButton: $hasBackButton)
                                        }) {
                                            UserCellView(user: user)
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    
                    HStack {
                        Text("\(dateFormatter.string(from: Date.now))")
                        
                        Button(action: {
                            userModel.loadUserList()
                        }) {
                            Image(systemName: "repeat")
                                .foregroundColor(Color("black"))
                        }
                    }
                    .padding()
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .navigationBarHidden(true)
            }
            .font(.custom(fontStyle, size: bodyFontSize))
            .foregroundColor(Color("black"))
        }
    }
}

struct UserView_Previews: PreviewProvider {
    @State static var hasBackButton = false
    
    static var previews: some View {
        UserView(hasBackButton: $hasBackButton)
            .environmentObject(UserModel())
    }
}
