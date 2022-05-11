//
//  AddLinkView.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/09.
//

import SwiftUI

struct AddLinkView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userModel: UserModel
    
    @Binding var isAddingLink: Bool
    
    @State var linkType = ""
    @State var linkDescription = ""
    @State var linkUrl = ""
    
    var body: some View {
        ZStack {
            Color("Background")
            
            VStack(spacing: 20){
//                TextField("type", text: $linkType)
//                    .padding()
//                    .background{
//                        RoundedRectangle(cornerRadius: 20)
//                            .foregroundColor(Color("Secondary"))
//                    }
                
                TextField("description", text: $linkDescription)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color("Secondary"))
                    }
                
                TextField("url", text: $linkUrl){
                    userModel.addUserLink(linkType: linkType, linkDescription: linkDescription, linkUrl: linkUrl)
                    isAddingLink = false
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color("Secondary"))
                }
                
                Button(action: {
                    userModel.addUserLink(linkType: linkType, linkDescription: linkDescription, linkUrl: linkUrl)
                    isAddingLink = false
                }) {
                    Text("Submit")
                        .foregroundColor(Color("Black"))
                        .frame(width: 120, height: 50)
                        .background{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("Primary"))
                        }
                }
            }
            .padding()
        }
        .navigationTitle("Add Link")
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

struct AddLinkView_Previews: PreviewProvider {
    static var previews: some View {
        AddLinkView(isAddingLink: .constant(true))
            .environmentObject(UserModel())
    }
}
