////
////  MyOrderDetailsVC.swift
////  AskHail
////
////  Created by Abdullah Tarek on 11/5/20.
////  Copyright © 2020 MOHAB. All rights reserved.
////
//
//import UIKit
//import FirebaseDynamicLinks
//class MyOrderDetailsVC: UIViewController {
//    
//    @IBOutlet weak var OrderTitle: UILabel!
//    
//    @IBOutlet weak var OrderNumber: UILabel!
//    @IBOutlet weak var OrderPrice: UILabel!
//    @IBOutlet weak var OrderDate: UILabel!
//    @IBOutlet weak var OrderDesc: UILabel!
//    
//    @IBOutlet weak var CommentCount: UILabel!
//    @IBOutlet weak var MenuBar: UIView!
//    @IBOutlet weak var NoCommentLabel: UILabel!
//    
//    @IBOutlet weak var ScrollView: NSLayoutConstraint!
//    
//    @IBOutlet weak var DetailsView: UIView!
//    @IBOutlet weak var CommentsTableView: UITableView!
//    
//    @IBOutlet weak var FeatuseTopTitle: UIStackView!
//    @IBOutlet weak var DetailsCollectionView: UICollectionView!
//    @IBOutlet weak var featureHeight: NSLayoutConstraint!
//    @IBOutlet weak var MainView: UIScrollView!
//    @IBOutlet weak var ShowMoreBtn: UIStackView!
//    
//    var FeatureArray : [Order_specifications] = []
//    var FeatureData = false
//    
//    var phoneNumber = ""
//    var whatsNumber = ""
//    
//    var CommentArray : [Comments_data] = []
//    var CommentData = false
//    
//    var WhatsApp = ""
//    
//    var ordar_data : ShowOrderData?
//    
//    var whatsState = ""
//    var callState = ""
//    var Order_id = ""
//    var myOrderCount = ""
//    var isSaved = false
//    var isActive = true
//    
//    private func createSpinnerFooter() -> UIView {
//        let FooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
//        FooterView.backgroundColor = .clear
//        let spinner = UIActivityIndicatorView()
//        
//        spinner.style = .large
//        spinner.color = #colorLiteral(red: 0, green: 0.2846388221, blue: 0.497141242, alpha: 1)
//        
//        spinner.center = FooterView.center
//        FooterView.addSubview(spinner)
//        spinner.startAnimating()
//        
//        return FooterView
//        
//    }
//    
//    var CurrentPage = 1
//    var lastPage = 1
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        NoCommentLabel.text = "No Commentns".localized
//        MainView.backgroundColor = Colors.ViewBackGroundColoer
//        
//        OrderNumber.text = Order_id
//        
//        if DynamicLinkModel.isDynamic {
//            self.Order_id = DynamicLinkModel.Product_id
//        }
//        
//        setShadow(view: MenuBar, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
//        
//        OrderDesc.font = UIFont(name: "Tajawal-Regular", size: 16)
//        
//        DetailsCollectionView.dataSource = self
//        DetailsCollectionView.delegate = self
//        DetailsCollectionView.RegisterNib(cell: ShowDetailsCell.self)
//        DetailsCollectionView.flipX()
//        
//        
//        CommentsTableView.delegate = self
//        CommentsTableView.dataSource = self
//        
//        CommentsTableView.RegisterNib(cell: ReplayCommentCell.self)
//        CommentsTableView.RegisterNib(cell: CommentWithReplayCell.self)
//        
//        // Do any additional setup after loading the view.
//        self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
//        
//        setShadow(view: MenuBar, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
//                
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        getOrderDetails()
//        ShowComment()
//    }
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        CommentsTableView.layer.removeAllAnimations()
//        DetailsCollectionView.layer.removeAllAnimations()
//        
//        
//        
//        featureHeight.constant = DetailsCollectionView.contentSize.height + 120 +  OrderDesc.intrinsicContentSize.height
//        
//        ScrollView.constant = CommentsTableView.contentSize.height  + 350 + featureHeight.constant
//        
//        UIView.animate(withDuration: 0.5) {
//            self.updateViewConstraints()
//            self.loadViewIfNeeded()
//        }
//    }
//    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        .darkContent
//    }
//    
//    @IBAction func BackAction(_ sender: Any) {
//        
//        if DynamicLinkModel.isDynamic {
//            DynamicLinkModel.isDynamic = false
//            guard let window = UIApplication.shared.keyWindow else{return}
//            let sb = UIStoryboard(name: Home, bundle: nil)
//            var vc : UIViewController
//            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
//            window.rootViewController = vc
//            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
//            
//        }
//        
//        
//        navigationController?.popToRootViewController(animated: true)
//        tabBarController?.tabBar.isHidden = false
//        
//    }
//    
//    @IBAction func ShareOrderAction(_ sender: Any) {
//        
//        let longLinkUrl = "https://askHail.page.link/?link=6\(self.Order_id)"
//        
//        DynamicLinkComponents.shortenURL(URL(string: longLinkUrl)!, options: nil) { shortUrl, warnings, error in
//            if error != nil{
//                let shareText = "\(self.OrderTitle.text ?? "")" + "\n" + longLinkUrl
//                let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
//                if(UIDevice.current.userInterfaceIdiom == .pad){
//                    vc.popoverPresentationController?.sourceView = self.view
//                }else{
//                    self.present(vc, animated: true, completion: {})
//                }
//                
//            }
//        }
//    }
//    
//    @IBAction func PhotoGraphImageAction(_ sender: Any) {
//        
//        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
//        
//        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsPopUpVC") as! BusinessAdsPopUpVC
//        vc.modalPresentationStyle = .fullScreen
//        self.addChild(vc)
//        vc.view.frame = self.view.frame
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
//        
//        
//    }
//    
//    @IBAction func ShowLocationAction(_ sender: Any) {
//        
//        
//        
//    }
//    
//    @IBAction func PhoneCallAtion(_ sender: Any) {
//        
//        if callState == "active"{
//            MakeCall(number: phoneNumber)
//        }else{
//            self.showAlertWithTitle(title: "Not Allaw", message: "It is not possible to communicate with him via phone call", type: .warning)
//        }
//        
//    }
//    
//    
//    @IBAction func WhatsAppAction(_ sender: Any) {
//        
//        if whatsState == "active"{
//            OpenWhatsApp(number: whatsNumber)
//        }else{
//            self.showAlertWithTitle(title: "Not Allaw", message: "It is not possible to communicate with him via WhatsApp", type: .warning)
//        }
//        
//    }
//    
//    
//    @IBAction func ChatInAppAction(_ sender: Any) {
//        
//        let storyboard = UIStoryboard(name: Chat, bundle: nil)
//        let vc  = storyboard.instantiateViewController(withIdentifier: "chatVC") as! chatVC
//        navigationController?.pushViewController(vc, animated: true)
//        
//    }
//    
//    @IBAction func OtherPageAction(_ sender: Any) {
//        
//        
//    }
//    
//    @IBAction func MoreCommentAction(_ sender: Any) {
//        
//        if isActive {
//            print("Done")
//            isActive = false
//            
//            
//            if CurrentPage < lastPage {
//                
//                CurrentPage = CurrentPage + 1
//                
//                self.getOrderDetails()
//                
//            }
//            self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
//        }
//        
//    }
//    
//    @IBAction func EditAction(_ sender: Any) {
//        
//        let storyboard = UIStoryboard(name: EditOrder_srory , bundle: nil)
//        let vc  = storyboard.instantiateViewController(withIdentifier: "EditOrderPopUpVC") as! EditOrderPopUpVC
//        vc.deleget = self
//        vc.modalPresentationStyle = .fullScreen
//        self.addChild(vc)
//        vc.view.frame = self.view.frame
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
//        
//    }
//    
//    @IBAction func DeletAction(_ sender: Any) {
//        
//        let storyboard = UIStoryboard(name: MyProfile , bundle: nil)
//        let vc  = storyboard.instantiateViewController(withIdentifier: "DeleteOrderPopUpVC") as! DeleteOrderPopUpVC
//        vc.Ad_Id = Order_id
//        vc.modalPresentationStyle = .fullScreen
//        self.addChild(vc)
//        vc.view.frame = self.view.frame
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
//        
//    }
//    
//}
//
////MARK:-CollectionView Controller
//
//extension MyOrderDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return FeatureArray.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDetailsCell", for: indexPath) as! ShowDetailsCell
//        
//        if FeatureData {
//            let Model = FeatureArray[indexPath.row]
//            
//            cell.CellTitle.text = Model.specification_section_feature?.feature_name ?? ""
//            cell.CellAnswer.text = Model.specification_answer
//            
//        }
//        
//        cell.flipX()
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.frame.width - 16)/3
//        return CGSize.init(width: width , height:46)
//    }
//    
//}
//
////MARK:-TableView Controller
//
//extension MyOrderDetailsVC : UITableViewDataSource , UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return CommentArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let Model = CommentArray[indexPath.row]
//        
//        if Model.comment_if_advertiser_reply_yet == true {
//            
//            let cell_2 = tableView.dequeue() as CommentWithReplayCell
//            cell_2.CommentName.text = Model.comment_voter_name ?? ""
//            cell_2.CommentText.text = Model.comment_text ?? ""
//            cell_2.CommentTime.text = Model.comment_text_custom_date ?? ""
//            cell_2.CommentReplayText.text = Model.comment_advertiser_reply ?? ""
//            cell_2.CommentReplayTime.text = Model.comment_advertiser_reply_custom_date ?? ""
//            cell_2.DeleteHight.constant = 0
//            cell_2.Deletbtn.isHidden = true
//            
////            cell_2.DeletComment = {
////
////            }
////
//            return cell_2
//            
//        } else {
//            
//            let cell = tableView.dequeue() as ReplayCommentCell
//            cell.CommentName.text = Model.comment_voter_name ?? ""
//            cell.CommentText.text = Model.comment_text ?? ""
//            cell.CommentTime.text = Model.comment_text_custom_date ?? ""
//            
////            cell.ShowReplay = {
////                self.CommentsTableView.reloadData()
////            }
////            
////            cell.CancelReplay = {
////                self.CommentsTableView.reloadData()
////            }
////            
////            cell.AddReplay = {
////                if cell.AddCommentTV.text.isEmpty == true{
////                    self.navigationController?.view.makeToast( "enter comment first".localized)
////                }else{
////                    self.AddReplay(text: cell.AddCommentTV.text, id: "\(self.CommentArray[indexPath.row].comment_id ?? 0)", index: indexPath.row)
////                    self.CommentsTableView.reloadData()
////                }
////            }
//            return cell
//        }
//    }
//    
//}
//
//extension MyOrderDetailsVC : selectEditOrderSection {
//    func SelectEdit(select: Int) {
//        
//        if select == 0 {
//            
//            let storyboard = UIStoryboard(name: EditOrder_srory , bundle: nil)
//            let vc  = storyboard.instantiateViewController(withIdentifier: "EditOrderCategoryVC") as! EditOrderCategoryVC
//            vc.Order_id = self.Order_id
//            navigationController?.pushViewController(vc, animated: true)
//            
//        }else if select == 1 {
//            
//            let storyboard = UIStoryboard(name: EditOrder_srory , bundle: nil)
//            let vc  = storyboard.instantiateViewController(withIdentifier: "EditOrderDetailsVD") as! EditOrderDetailsVD
//            vc.Order_id = self.Order_id
//            vc.CurrentFeatureArray = ordar_data?.order_details?.order_specifications ?? []
//            navigationController?.pushViewController(vc, animated: true)
//            
//        }
//        else if select == 2 {
//            
//            let storyboard = UIStoryboard(name: EditOrder_srory , bundle: nil)
//            let vc  = storyboard.instantiateViewController(withIdentifier: "EditOrderContactWayVC") as! EditOrderContactWayVC
//            vc.Order_id = self.Order_id
//            navigationController?.pushViewController(vc, animated: true)
//            
//        }
//    }
//}
//
//
////MARK:-API
//
//extension MyOrderDetailsVC {
//    
//    func getOrderDetails() {
//        
//        self.MainView.isHidden = true
//        self.view.lock()
//        print(Order_id)
//        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-order/\(Order_id)") { (data : ShowOrderModel?, String) in
//            
//            self.view.unlock()
//            if String != nil {
//                
//                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
//                
//            }else {
//                
//                guard let data = data else {
//                    return
//                }
//                
//                self.ordar_data = data.data
//                self.CurrentPage = data.data?.comments_pagination?.current_page ?? 1
//                self.lastPage = data.data?.comments_pagination?.last_page ?? 1
//                
//                self.Order_id = "\(data.data?.order_details?.order_id ?? 0)"
//                self.OrderNumber.text = "\(data.data?.order_details?.order_id ?? 0)"
//                self.OrderTitle.text = "\(data.data?.order_details?.order_title ?? "")"
//                self.OrderPrice.text = "less than ".localized + "\(data.data?.order_details?.order_price ?? "")"
//                self.OrderDate.text = "published ".localized + "\(data.data?.order_details?.order_custom_published_date ?? "") | " + "Modified ".localized + "\(data.data?.order_details?.order_custom_last_update_date ?? "")"
//                
//                self.OrderDesc.text = "\(data.data?.order_details?.order_description ?? "")"
//                
//                self.phoneNumber = data.data?.order_details?.order_call_number ?? ""
//                self.whatsNumber = data.data?.order_details?.order_whatsapp_number ?? ""
//                
//                self.callState = data.data?.order_details?.order_call_number_status ?? ""
//                self.whatsState = data.data?.order_details?.order_whatsapp_number_status ?? ""
//                
//                self.FeatureArray = data.data?.order_details?.order_specifications ?? []
//                
//                if data.data?.order_details?.order_specifications?.count ?? 0 == 0 {
//                    self.FeatuseTopTitle.isHidden = true
//                }else{
//                    self.FeatuseTopTitle.isHidden = false
//                }
//                
//                
//                self.FeatureData = true
//                
//                self.CommentCount.text = "( \(data.data?.comments_count ?? "") )"
//                self.CommentCount.text = data.data?.comments_count ?? ""
//                
//                
//                if data.data?.comments_count != "0" {
//                    self.CommentData = true
//                    self.NoCommentLabel.isHidden = true
//                    self.CommentsTableView.reloadData()
//                }else{
//                    self.NoCommentLabel.isHidden = false
//                    self.CommentData = false
//                    self.CommentsTableView.reloadData()
//                }
//                
//                
//                if data.data?.comments_pagination?.has_more_pages == false {
//                    self.ShowMoreBtn.isHidden = true
//                }
//                
//                self.DetailsCollectionView.reloadData()
//                self.MainView.isHidden = false
//                
//                print(data)
//                
//            }
//        }
//    }
//    
//    
//    func AddReplay(text : String , id : String , index : Int) {
//        
//        let Parameters = [
//            "comment_id" : id,
//            "reply" : text
//        ]
//        
//        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/order-add-or-update-reply-on-comment") { (data : Level_6_Model?, String) in
//            
//            if String != nil {
//                
//                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
//                
//            }else {
//                
//                guard let data = data else {
//                    return
//                }
//                
//                
//                self.CommentArray[index].comment_if_advertiser_reply_yet = true
//                self.CommentArray[index].comment_advertiser_reply = text
//                self.CommentsTableView.reloadData()
//                
//                self.NoCommentLabel.isHidden = true
//                self.CommentsTableView.isHidden = false
//                
//                
//                print(data)
//            }
//        }
//    }
//    
//    func ShowComment() {
//        
//        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-order-comments/\(Order_id)?page=\(CurrentPage)") { (data : AllCommentModel?, String) in
//            
//            if String != nil {
//                
//                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
//                
//            }else {
//                
//                guard let data = data else {
//                    return
//                }
//                
//                
//                self.CurrentPage = data.data?.pagination?.current_page ?? 1
//                self.lastPage = data.data?.pagination?.last_page ?? 1
//                
//                for item in data.data?.data ?? [] {
//                    self.CommentArray.append(item)
//                }
//                
//                self.NoCommentLabel.isHidden = false
//                self.ShowMoreBtn.isHidden = true
//                
//                if data.data?.data?.count ?? 0 > 0 {
//                   
//                    self.NoCommentLabel.isHidden = true
//                }
//                
//                if data.data?.pagination?.has_more_pages == true {
//                    self.ShowMoreBtn.isHidden = false
//                }
//                
//                if data.data?.data?.count ?? 0 == 0 {
//                    self.NoCommentLabel.isHidden = false
//                    self.CommentsTableView.isHidden = true
//                }else{
//                    self.NoCommentLabel.isHidden = true
//                    self.CommentsTableView.isHidden = false
//                }
//                
//                self.CommentsTableView.reloadData()
//                
//                self.isActive = true
//                
//                print(data)
//            }
//        }
//    }
//    
//}
