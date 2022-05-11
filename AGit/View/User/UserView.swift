//
//  UserView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var userModel: UserModel
    @State var searchString = ""
    
    var columns = [GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        NavigationView{
            VStack {
                ZStack {
                    Color("Background")
                    
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("닉네임이나 태그를 검색하세요", text: $searchString)
                            
                            Button(action: {
                                searchString = ""
                            }) {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(Color("White"))
                            }
                        }
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color("Secondary"))
                        }

                        .padding()
                                                
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                if searchString == ""{
                                    ForEach(userModel.userList, id: \.self){user in
                                        NavigationLink(destination: {
                                            UserDetailView(user: user)
                                        }) {
                                            UserCellView(user: user)
                                        }
                                    }
                                }else if searchString.hasPrefix("#"){
                                    ForEach(userModel.userList, id: \.self){ user in
                                        if let tag = user.tags{
                                            if tag.contains(searchString){
                                                NavigationLink(destination: {
                                                    UserDetailView(user: user)
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
                                                UserDetailView(user: user)
                                            }) {
                                                UserCellView(user: user)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 30)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("\(dateFormatter.string(from: Date.now))")
                            
                            Button(action: {
                                userModel.loadUserList()
                            }) {
                                Image(systemName: "repeat")
                            }
                        }
                        .padding()
                    }
                }
                
                Color.black
                    .frame(height: 5)
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationBarTitle("User")
        }
        .font(.custom(fontStyle, size: bodyFontSize))
        .foregroundColor(Color("White"))
    }
}

struct UserView_Previews: PreviewProvider {
    @State static var hasBackButton = false
    
    static var previews: some View {
        UserView()
            .environmentObject(UserModel())
    }
}
