//
//  MessagesVC.swift
//  AskHail
//
//  Created by Mohab on 11/17/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit

class MessagesVC: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var MyAdvSwitchView: UIView!
    @IBOutlet weak var LoginView: UIView!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var TopBar: UIView!
    
    @IBOutlet weak var RegisterView: UIView!
    @IBOutlet weak var RegisterBtn: UIButton!
    
    @IBOutlet weak var FilterSwitch: UIView!
    
    @IBOutlet weak var Mainview: UIView!
    @IBOutlet weak var emptyMessage: UILabel!
    
    var OpenChat = true
    var isActive = true
    
    private func createSpinnerFooter() -> UIView {
        let FooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        FooterView.backgroundColor = .clear
        let spinner = UIActivityIndicatorView()
        
        spinner.style = .large
        spinner.color = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
        
        spinner.center = FooterView.center
        FooterView.addSubview(spinner)
        spinner.startAnimating()
        
        return FooterView
        
    }
    
    var CurrentPage = 1
    var lastPage = 1
    
    var ChatArray : [ChatData] = []
    var ChatData = false
    
    lazy var SwitchControl: UISwitch = {
        let SwitchControl = UISwitch()
        SwitchControl.center = FilterSwitch.center
        SwitchControl.isOn = true
        SwitchControl.isEnabled = true
        SwitchControl.onTintColor = Colors.WhiteBlue
        SwitchControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        SwitchControl.cornerRadius = (SwitchControl.frame.height / 2)
        SwitchControl.clipsToBounds = true
        SwitchControl.translatesAutoresizingMaskIntoConstraints = false
        SwitchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        
        return SwitchControl
    }()
    
    // Mark - selectors
    
    @objc func handleSwitchAction(sender: UISwitch){
        
        
        if sender.isOn {
            print("Turned on")
            print(SwitchControl.isOn)
            Helper.SaveChatType(ChatState: "true")
            
            ChatArray.removeAll()
            CurrentPage = 1
            lastPage = 1
            getChatList()
            
            UIApplication.shared.registerForRemoteNotifications()
            
            
        }
        else{
            Helper.SaveChatType(ChatState: "false")
            ChatArray.removeAll()
            CurrentPage = 1
            lastPage = 1
            getChatList()
            
            UIApplication.shared.unregisterForRemoteNotifications()
            print("Turned off")
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Helper.getChateType() == "true" {
            SwitchControl.isOn = true
        }else{
            SwitchControl.isOn = false
        }
        LoginView.isHidden = true
        RegisterView.isHidden = true
        MyAdvSwitchView .isHidden = false
        guard Helper.getapitoken() != nil else {
            MyAdvSwitchView .isHidden = true
            LoginView.isHidden = false
            RegisterView.isHidden = false
            tableView.isHidden = true
            return
        }

        Mainview.backgroundColor = Colors.ViewBackGroundColoer
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Tajawal-Regular", size: 12)!], for: .normal)
        
        tabBarController?.tabBar.items?[0].title = "Home".localized
        tabBarController?.tabBar.items?[1].title = "Chat".localized
        tabBarController?.tabBar.items?[4].title = "More".localized
        tabBarController?.tabBar.items?[3].title = "Ask Hail".localized
      
      
        FilterSwitch.addSubview(SwitchControl)
        setShadow(view: LoginView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        
        setShadow(view: RegisterView , width: 0, height: 2, shadowRadius: 3, shadowOpacity: 0.3, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
                
        tableView.backgroundColor = Colors.ViewBackGroundColoer
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.RegisterNib(cell: MessagesCell.self)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUp), name: NSNotification.Name(rawValue: NotificationCenterpreePlusBtn), object: nil)
        
        if OpenChat == true {
            OpenChat = false
            ChatArray.removeAll()
            CurrentPage = 1
            lastPage = 1
            getChatList()
        }
        
    }
    
    @IBAction func NotificationAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Notification_Stry, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Authontication, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "WelcomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
    }
    
    @IBAction func RegisterAction(_ sender: Any) {
        
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Authontication, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "WelcomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
    }
    
    
    
    
    @IBAction func PrayTimeAction(_ sender: Any) {
        
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "PrayTimeVC") as! PrayTimeVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    
}

//MARK:TableView Controller

extension MessagesVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue() as MessagesCell
        
        if ChatArray.count > indexPath.row {
            
            let Model = ChatArray[indexPath.row]
            
            cell.ImageWideth.constant = 0
            if Model.chat_image ?? "" != "" {
                cell.ImageWideth.constant = 80
                cell.CellImage.loadImage(URL(string: Model.chat_image ?? ""))
            }
            
            cell.CellTitle.text = Model.chat_title ?? ""
            cell.CellLastTime.text = Model.chat_last_message_date
            cell.CellLastMessege.text = Model.chat_last_message ?? ""
            
            cell.CellUnreadMessge.isHidden = true
            if Model.chat_unread_messages_count ?? 0 > 0 {
                cell.CellUnreadMessge.isHidden = false
                cell.CellUnreadMessge.text = "\(Model.chat_unread_messages_count ?? 0)"
            }
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Chat, bundle: nil)
        
        print( "\(ChatArray[indexPath.row].chat_id ?? 0)")
        let vc  = storyboard.instantiateViewController(withIdentifier: "chatVC") as! chatVC
        // present(vc, animated: true, completion: nil)
        vc.isMessages = 1
        navigationController?.pushViewController(vc, animated: true)
        vc.chat_type_id = "\(ChatArray[indexPath.row].chat_id ?? 0)"
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let ContentHeight = scrollView.contentSize.height
        // print(position , tableView.contentSize.height)
        if isActive {
            if position > ContentHeight - scrollView.frame.height {
                
                print("Done")
                isActive = false
                
                //numberofitem
                
                //  print(CurrentPage , lastPage)
                if CurrentPage < lastPage {
                    
                    CurrentPage = CurrentPage + 1
                    
                    self.getChatList()
                    
                }
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

//MARK:API
extension MessagesVC {
    
    func getChatList() {
        var state = ""
        if SwitchControl.isOn {
            state = "mine"
        }else{
            state = "all"
        }
        print(state)
        
        self.Mainview.isHidden = false
        
        self.view.lock()
        ApiServices.instance.getPosts(methodType:.get, parameters: nil , url: "\(hostName)chat-operations/my-chats?show_filter=\(state)") { (data : ChatListModel?, String) in
            
            
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.ChatData = true
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.ChatArray.append(item)
                }
                
                
                self.MyAdvSwitchView.isHidden = false
                
                if data.data?.data?.count ?? 0 > 0 {

                
                    self.LoginView.isHidden = false
                    self.RegisterView.isHidden = false
                    self.tableView.isHidden = false


                }else {

                
                    self.LoginView.isHidden = true
                    self.RegisterView.isHidden = true
                    self.tableView.isHidden = true
                    self.emptyMessage.text = "No conversations in progress now. Browse ads or requests, and communicate with publishers and advertisers".localized

                }
                
                
                self.tableView.reloadData()
                self.Mainview.isHidden = true
                self.isActive = true
                self.OpenChat = true
                print(data)
                
                
            }
        }
    }
    
}
