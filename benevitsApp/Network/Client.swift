import Foundation
import Alamofire
class Service{
    fileprivate var baseUrl = "https://staging.api.socioinfonavit.io/api/v1/"
    typealias walletsCallBack = (_ wallets:[Wallet]?,_ status:Bool,_ mesage:String ) -> Void
    var  callBackWallet :walletsCallBack?
    typealias callBackBenevits = (_ wallets:AllBenevits?,_ status:Bool,_ mesage:String ) -> Void
    var  callBackBenevit:callBackBenevits?
    
    typealias loginCallBack = (_ wallets:String?,_ status:Bool,_ mesage:String ) -> Void
    var  callBacklogin :loginCallBack?
    
    func postLogIn(user:LoginData){
        AF.request(self.baseUrl + "login",method: .post,parameters: ["user":["email":user.email, "password":user.password]],encoding: URLEncoding.default,headers: nil,interceptor: nil).responseJSON{
            (response) in
           guard let data = response.data else {return}
           do{
               let wallets = try JSONDecoder().decode([userSetings].self,from:data)
              
               self.callBacklogin?("auth",true,"")
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
        self.callBacklogin? = callBack
        
    }
    
    
}
