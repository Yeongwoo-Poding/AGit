//
//  User.swift
//  A_Git
//
//  Created by Yeongwoo Kim on 2022/05/06.
//

import Foundation

struct User: Codable, Hashable{
    let id: Int
    let nickname: String
    let email: String
    var isStudying: Bool = false
    var lastModified: String = ""
    var curStudyTime: Int = 0
    var todayStudyTime: Int = 0
    var totalStudyTime: Int = 0
    var days: Int = 1
    
    var tags: [String]?
    var links: [Link]?
}

struct Link: Codable, Hashable{
    var linkType: String
    var linkDescription: String
    var linkUrl: String
}

struct Response: Codable{
    let returnCode: Int
    let user: User?
    let userList: [User]?
}

class UserModel: ObservableObject{
    @Published var loginId = UserDefaults.standard.integer(forKey: "loginId")
    @Published var user: User?
    @Published var userList: [User] = []
    
    func signIn(email: String, password: String, returnValue: @escaping(Bool) -> ()){
        let url = URL(string: "\(domain)/SignIn.php")!
        
        let postData: [String : String] = ["email": email, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: postData, options: [])
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            do{
                let response = try JSONDecoder().decode(Response.self, from: data!)
                
                switch response.returnCode{
                case 0:
                    DispatchQueue.main.async {
                        self.user = response.user
                        
                        if let u = self.user{
                            self.loginId = u.id
                            UserDefaults.standard.set(self.loginId, forKey: "loginId")
                        }
                        
                        print("DEBUG: Successfully Sign In")
                        returnValue(true)
                    }
                    
                case 1:
                    print("SIGN IN ERROR: DB Connect Error")
                    returnValue(false)
                    
                case 2:
                    print("SIGN IN ERROR: No Account")
                    returnValue(false)
                    
                default:
                    print("SIGN IN ERROR: Unknown Error")
                    returnValue(false)
                }
            }catch let error{
                print("SIGN IN ERROR: \(error)")
                returnValue(false)
            }
        }.resume()
    }
    
    func signUp(nickname: String, email: String, password: String, returnValue: @escaping(Bool) -> ()){
        let url = URL(string: "\(domain)/SignUp.php")!
        
        let postData: [String : String] = ["nickname": nickname, "email": email, "password": password, "lastModified": dateFormatter.string(from: Date.now)]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: postData, options: [])
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            do{
                let response = try JSONDecoder().decode(Response.self, from: data!)
                
                switch response.returnCode{
                case 0:
                    DispatchQueue.main.async {
                        print("DEBUG: Successfully Sign Up")
                        returnValue(true)
                    }
                    
                case 1:
                    print("SIGN UP ERROR: DB Connect Error")
                    returnValue(false)
                    
                case 3:
                    print("SIGN UP ERROR: Same Email Exist")
                    returnValue(false)
                    
                default:
                    print("SIGN UP ERROR: Unknown Error")
                    returnValue(false)
                }
            }catch let error{
                print("SIGN UP ERROR: \(error)")
                returnValue(false)
            }
        }.resume()
    }
    
    func signOut(){
        self.loginId = 0
        UserDefaults.standard.set(0, forKey: "loginId")
        user = nil
        
        print("DEBUG: Successfully Sign Out")
    }
    
    func loadUser(id: Int, returnValue: @escaping(Bool) -> ()){
        let url = URL(string: "\(domain)/LoadUser.php?id=\(id)")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            do{
                let response = try JSONDecoder().decode(Response.self, from: data!)
                
                switch response.returnCode{
                case 0:
                    DispatchQueue.main.async {
                        self.user = response.user
                        
                        print("DEBUG: Successfully Load User")
                        returnValue(true)
                    }
                    
                case 1:
                    print("LOAD USER ERROR: DB Connect Error")
                    returnValue(false)
                    
                case 2:
                    print("LOAD USER ERROR: No Account")
                    returnValue(false)
                    
                default:
                    print("LOAD USER ERROR: Unknown Error")
                    returnValue(false)
                }
            }catch let error{
                print("LOAD USER ERROR: \(error)")
                returnValue(false)
            }
        }.resume()
    }
    
    func loadUserList(){
        let url = URL(string: "\(domain)/LoadUserList.php")!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            do{
                let response = try JSONDecoder().decode(Response.self, from: data!)
                
                switch response.returnCode{
                case 0:
                    DispatchQueue.main.async {
                        self.userList = response.userList!.sorted(by: {$0.todayStudyTime > $1.todayStudyTime})
                        
                        print("DEBUG: Successfully Load User List")
                    }
                    
                case 1:
                    print("LOAD USER LIST ERROR: DB Connect Error")
                    
                case 2:
                    print("LOAD USER LIST ERROR: No Account")
                    
                default:
                    print("LOAD USER LIST ERROR: Unknown Error")
                }
            }catch let error{
                print("LOAD USER LIST ERROR: \(error)")
            }
        }.resume()
    }
    
    func updateUser(){
        if self.user != nil{
            let url = URL(string: "\(domain)/UpdateUser.php?id=\(self.user!.id)")!
            print(url)
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                do{
                    let response = try JSONDecoder().decode(Response.self, from: data!)
                    
                    switch response.returnCode{
                    case 0:
                        DispatchQueue.main.async {
                            self.user = response.user
                            
                            print("DEBUG: Successfully Update User")
                        }
                        
                    case 1:
                        print("UPDATE USER ERROR: DB Connect Error")
                        
                    case 2:
                        print("UPDATE USER ERROR: No Account")
                        
                    default:
                        print("UPDATE USER ERROR: Unknown Error")
                    }
                }catch let error{
                    print("UPDATE USER ERROR: \(error)")
                }
            }.resume()
        }else{
            print("UPDATE USER ERROR: No LOGIN")
        }
    }
    
    func addUserTag(tag: String){
        if self.user != nil{
            let url = URL(string: "\(domain)/AddTag.php")!
            print(url)
            
            let postData: [String : String] = ["id": String(self.user!.id), "tag": tag]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = try? JSONSerialization.data(withJSONObject: postData, options: [])
            
            URLSession.shared.dataTask(with: request) { data, _, _ in
                do{
                    let response = try JSONDecoder().decode(Response.self, from: data!)
                    
                    switch response.returnCode{
                    case 0:
                        DispatchQueue.main.async {
                            self.user?.tags = response.user?.tags
                            
                            print("DEBUG: Successfully Add User Tag")
                        }
                        
                    case 1:
                        print("ADD TAG ERROR: DB Connect Error")
                        
                    case 2:
                        print("ADD TAG ERROR: No Account")
                        
                    default:
                        print("ADD TAG ERROR: Unknown Error")
                    }
                }catch let error{
                    print("ADD TAG ERROR: \(error)")
                }
            }.resume()
        }else{
            print("ADD TAG ERROR: No LOGIN")
        }
    }
    
    func deleteUserTag(tag: String){
        if self.user != nil{
            let url = URL(string: "\(domain)/DeleteTag.php")!
            print(url)
            
            let postData: [String : String] = ["id": String(self.user!.id), "tag": tag]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = try? JSONSerialization.data(withJSONObject: postData, options: [])
            
            URLSession.shared.dataTask(with: request) { data, _, _ in
                do{
                    let response = try JSONDecoder().decode(Response.self, from: data!)
                    
                    switch response.returnCode{
                    case 0:
                        DispatchQueue.main.async {
                            self.user?.tags = response.user?.tags
                            
                            print("DEBUG: Successfully Delete User Tag")
                        }
                        
                    case 1:
                        print("DELETE TAG ERROR: DB Connect Error")
                        
                    case 2:
                        print("DELETE TAG ERROR: No Account")
                        
                    default:
                        print("DELETE TAG ERROR: Unknown Error")
                    }
                }catch let error{
                    print("DELETE TAG ERROR: \(error)")
                }
            }.resume()
        }else{
            print("DELETE TAG ERROR: No LOGIN")
        }
    }
    
    func addUserLink(linkType: String, linkDescription: String, linkUrl: String){
        if self.user != nil{
            let url = URL(string: "\(domain)/AddLink.php")!
            print(url)
            
//            let postData: [String : String] = ["id": String(self.user!.id), "linkType": linkType, "linkDescription": linkDescription, "linkUrl": linkUrl]
            let postData: [String : String] = ["id": String(self.user!.id), "linkType": "", "linkDescription": linkDescription, "linkUrl": linkUrl]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = try? JSONSerialization.data(withJSONObject: postData, options: [])
            
            URLSession.shared.dataTask(with: request) { data, _, _ in
                do{
                    let response = try JSONDecoder().decode(Response.self, from: data!)
                    
                    switch response.returnCode{
                    case 0:
                        DispatchQueue.main.async {
                            self.user?.links = response.user?.links
                            
                            print("DEBUG: Successfully Add User Link")
                        }
                        
                    case 1:
                        print("ADD LINK ERROR: DB Connect Error")
                        
                    case 2:
                        print("ADD LINK ERROR: No Account")
                        
                    default:
                        print("ADD LINK ERROR: Unknown Error")
                    }
                }catch let error{
                    print("ADD LINK ERROR: \(error)")
                }
            }.resume()
        }else{
            print("ADD LINK ERROR: No LOGIN")
        }
    }
    
    func deleteUserLink(linkUrl: String){
        if self.user != nil{
            let url = URL(string: "\(domain)/DeleteLink.php")!
            print(url)
            
            print(String(self.user!.id))
            print(linkUrl)
            
            let postData: [String : String] = ["id": String(self.user!.id), "linkUrl": linkUrl]
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.httpBody = try? JSONSerialization.data(withJSONObject: postData, options: [])
            
            URLSession.shared.dataTask(with: request) { data, _, _ in
                do{
                    let response = try JSONDecoder().decode(Response.self, from: data!)
                    
                    switch response.returnCode{
                    case 0:
                        DispatchQueue.main.async {
                            self.user?.links = response.user?.links
                            
                            print("DEBUG: Successfully Delete User Link")
                        }
                        
                    case 1:
                        print("DELETE LINK ERROR: DB Connect Error")
                        
                    case 2:
                        print("DELETE LINK ERROR: No Account")
                        
                    default:
                        print("DELETE LINK ERROR: Unknown Error")
                    }
                }catch let error{
                    print("DELETE LINK ERROR: \(error)")
                }
            }.resume()
        }else{
            print("DELETE LINK ERROR: No LOGIN")
        }
    }
}
