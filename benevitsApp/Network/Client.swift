import Foundation
import Alamofire
class Service{
    fileprivate var baseUrl = "https://staging.api.socioinfonavit.io/api/v1/"
    typealias walletsCallBack = (_ wallets:[Wallet]?,_ status:Bool,_ mesage:String ) -> Void
    var  callBackWallet :walletsCallBack?
    typealias callBackBenevits = (_ wallets:AllBenevits?,_ status:Bool,_ mesage:String ) -> Void
    var  callBackBenevit:callBackBenevits?
    
    typealias loginCallBack = (_ wallets:userSetings?,_ status:Bool,_ mesage:String ) -> Void
    var  callBacklogin :loginCallBack?
    
    func postLogIn(user:LoginData){
        AF.request(self.baseUrl + "login",method: .post,parameters: ["user":["email":user.email, "password":user.password]],encoding: URLEncoding.default,headers: nil,interceptor: nil).response{
            (response) in
            
            if let header = response.response?.allHeaderFields as? [String : Any] {
                if let tokenAux = header["Authorization"] as? String{
                    UserDefaults.standard.set(tokenAux, forKey: "Authorization")
                }
            }
           guard let data = response.data else {return}
           do{
            let data = try JSONDecoder().decode(userSetings.self,from:data)
               self.callBacklogin?(data,true,"")
           }catch{

               self.callBacklogin?(nil,false,error.localizedDescription)
           }
    
        }
    }
    func getMemberWallets(Autorization:String){
        let headers: HTTPHeaders = [
            "Authorization": Autorization,
        ]
        AF.request(self.baseUrl + "member/wallets", headers: headers).responseJSON { (response)in
            guard let data = response.data else {return}
            do{
                let wallets = try JSONDecoder().decode([Wallet].self,from:data)
               
                self.callBackWallet?(wallets,true,"")
            }catch{
               
                self.callBackWallet?(nil,false,error.localizedDescription)
            }
        }
    }
     func getLandingBenevits(Autorization:String){
            let headers: HTTPHeaders = [
                "Authorization": Autorization,
            ]
          
            AF.request(self.baseUrl + "member/landing_benevits", headers: headers).responseJSON { response in
                 guard let data = response.data else {return}
                           do{
                               let benevits = try JSONDecoder().decode(AllBenevits.self,from:data)
                               self.callBackBenevit?(benevits,true,"")
                            }catch{
                                            
                                self.callBackWallet?(nil,false,error.localizedDescription)
                            }
            }
            
        }
    func walletCompletitionHandler(callBack:@escaping walletsCallBack){
        self.callBackWallet = callBack
        
    }
    func benevitsCompletitionHandler(callBack:@escaping callBackBenevits){
        self.callBackBenevit = callBack
        
    }
    
    func loginCompletitionHandler(callBack:@escaping loginCallBack){
        self.callBacklogin = callBack
        
    }
    
    
}
