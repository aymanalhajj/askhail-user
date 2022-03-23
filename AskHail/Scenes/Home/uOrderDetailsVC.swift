//
//  uOrderDetailsVC.swift
//  AskHail
//
//  Created by bodaa on 15/12/2020.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseDynamicLinks


class uOrderDetailsVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var ChatView: UIView!
    @IBOutlet weak var WhatsAppView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    
    @IBOutlet weak var FueatureTitle: UIStackView!
    @IBOutlet weak var OrderTitle: UILabel!
    
    @IBOutlet weak var OrderNumber: UILabel!
    @IBOutlet weak var OrderPrice: UILabel!
    @IBOutlet weak var OrderDate: UILabel!
    @IBOutlet weak var OrderDesc: UILabel!
    
    @IBOutlet weak var OtherNumberOfOrder: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var CommentCount: UILabel!
    @IBOutlet weak var WhatsBtn: UIButton!
    @IBOutlet weak var VisitorView: UIView!
    @IBOutlet weak var Lable: UILabel!
    
    @IBOutlet weak var OtherName: UILabel!
    
    @IBOutlet weak var ScrollView: NSLayoutConstraint!
    @IBOutlet weak var NoCommentLable: UILabel!
    
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var featureHeight: NSLayoutConstraint!
    
    @IBOutlet weak var CommentsTableView: UITableView!
    
    @IBOutlet weak var CommentView: UIView!
    @IBOutlet weak var CommentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var AddCommentTV: UITextView!
    @IBOutlet weak var MainView: UIScrollView!
    @IBOutlet weak var ShowMoreBtn: UIButton!
    @IBOutlet weak var addCommentBtn: UIButton!
    
    var markers = [GMSMarker]()
    
    var FeatureArray : [Order_specifications] = []
    var FeatureData = false
    
    var phoneNumber = ""
    var whatsNumber = ""
    
    var CommentArray : [Comments_data] = []
    var CommentData = false
    var Commentnumber = 0
    
    var WhatsApp = ""
    
    var whatsState = ""
    var callState = ""
    
    var Order_id = ""
    var User_Name = ""
    
    var myOrderCount = ""
    
    var Urer_Id = ""
    var CommentState = false
    
    
    var isSaved = false
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainView.isHidden = true
        
        OrderNumber.text = Order_id
        
        if DynamicLinkModel.isDynamic {
            
            self.Order_id = DynamicLinkModel.Product_id
            
            
        }
        
        // Do any additional setup after loading the view.
        self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.OrderDesc.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        getOrderDetails()
        ShowComment()
        
        OrderDesc.font = UIFont(name: "Tajawal-Regular", size: 16)
        
        CommentViewHeight.constant = 0
        CommentView.alpha = 0
        
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        AddCommentTV.delegate = self
        
        CommentsTableView.RegisterNib(cell: CommentCellTableViewCell.self)
        CommentsTableView.RegisterNib(cell: CommentWithReplayCell.self)
        
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.delegate = self
        DetailsCollectionView.RegisterNib(cell: ShowDetailsCell.self)
        DetailsCollectionView.flipX()
        
        
        VisitorView.isHidden = true
        
        if L102Language.currentAppleLanguage() == "en" {
            AddCommentTV.text = "Add New Comment"
            AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
        }else {
            AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
            AddCommentTV.text = "اضافة تعليق جديد"
        }
        
        NoCommentLable.text = "No Commentns".localized
        
        AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
        if AuthService.userData?.advertiser_api_token == nil {
            
            VisitorView.isHidden = false
            
            let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 16), NSAttributedString.Key.foregroundColor : Colors.DarkBlue]
            
            let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 16), NSAttributedString.Key.foregroundColor : UIColor(hexString: "#39CDEE")]
            
            let attributedString1 = NSMutableAttributedString(string: "قم بتسجيل الدخول لتتمكن من ", attributes:attrs1)
            
            let attributedString2 = NSMutableAttributedString(string: "التواصل مع المعلن", attributes:attrs2)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 7
            
            attributedString1.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: NSRange(location: 0, length: attributedString1.length
                ))
            
            attributedString2.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: NSRange(location: 0, length: attributedString2.length
                ))
            
            attributedString1.append(attributedString2)
            Lable.attributedText = attributedString1
            
        }
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        CommentsTableView.layer.removeAllAnimations()
        DetailsCollectionView.layer.removeAllAnimations()
        
        
        
        featureHeight.constant = DetailsCollectionView.contentSize.height + 120 +  OrderDesc.intrinsicContentSize.height
        
        ScrollView.constant = CommentsTableView.contentSize.height  + 700 + featureHeight.constant + CommentViewHeight.constant
        
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if AddCommentTV.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            AddCommentTV.text = ""
            AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        if DynamicLinkModel.isDynamic {
            DynamicLinkModel.isDynamic = false
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ShareOrderAction(_ sender: Any) {
        
        
        let longLinkUrl = "https://askHail.page.link/?link=3\(self.Order_id)"
        
        DynamicLinkComponents.shortenURL(URL(string: longLinkUrl)!, options: nil) { shortUrl, warnings, error in
            if error != nil{
                let shareText = "\(self.OrderTitle.text ?? "")" + "\n" + longLinkUrl
                let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
                if(UIDevice.current.userInterfaceIdiom == .pad){
                    vc.popoverPresentationController?.sourceView = self.view
                }else{
                    self.present(vc, animated: true, completion: {})
                }
            }
            guard let url = shortUrl, error == nil else { return }
            print("The short URL is: \(shortUrl)")
            let shareText = "See the product on the AskHail store" + "\n" + "\(shortUrl!)"
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            if(UIDevice.current.userInterfaceIdiom == .pad){
                vc.popoverPresentationController?.sourceView = self.view
            }else{
                self.present(vc, animated: true, completion: {})
            }
        }
        
        
        
        
    }
    
    
    @IBAction func ShowLocationAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "AdvOnMapVC") as! AdvOnMapVC
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func PhoneCallAtion(_ sender: Any) {
        
        if callState == "active"{
            MakeCall(number: phoneNumber)
        }else{
            self.showAlertWithTitle(title: "Not Allaw", message: "It is not possible to communicate with him via phone call", type: .warning)
        }
        
    }
    
    
    @IBAction func WhatsAppAction(_ sender: Any) {
        
        if whatsState == "active"{
            OpenWhatsApp(number: whatsNumber)
        }else{
            self.showAlertWithTitle(title: "Not Allaw", message: "It is not possible to communicate with him via WhatsApp", type: .warning)
        }
        
    }
    
    
    @IBAction func ChatInAppAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Chat, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "chatVC") as! chatVC
        vc.chat_type_id = self.Order_id
        vc.chat_type = "order"
        vc.isSubView = 2
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func OtherPageAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
        vc.User_id = self.Urer_Id
        vc.User_Name = self.User_Name
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func MoreCommentAction(_ sender: Any) {
        
        if isActive {
            print("Done")
            isActive = false
            
            
            if CurrentPage < lastPage {
                
                CurrentPage = CurrentPage + 1
                
                self.getOrderDetails()
                
            }
            self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        }
        
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        guard AuthService.userData?.advertiser_api_token != nil else {
            
            alertSkipLogin()
            return
        }
        
    }
    
    @IBAction func AddComment(_ sender: Any) {
        
        guard AuthService.userData?.advertiser_api_token != nil else {
            
            alertSkipLogin()
            return
        }
        
        if CommentState == false{
            CommentState = true
            if L102Language.currentAppleLanguage() == "en" {
                AddCommentTV.text = "Add New Comment"
                AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
            }else {
                AddCommentTV.text = "اضافة تعليق جديد"
                AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
            }
            AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
            
            UIView.animate(withDuration: 0.6, animations: {
                
                self.CommentViewHeight.constant = 172
                self.CommentView.alpha = 1
                self.CommentsTableView.reloadData()
                
            }, completion: { _ in
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                }, completion: { _ in
                    
                })
            })
            
            addCommentBtn.setTitle("Cancel".localized, for: .normal)
        }else{
            
            CommentState = false
            UIView.animate(withDuration: 0.3, animations: {
                self.CommentViewHeight.constant = 0
                self.CommentView.alpha = 0
                self.CommentsTableView.reloadData()
                
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    
                }, completion: { _ in
                    
                    
                })
            })
            addCommentBtn.setTitle("Add comment".localized.localized, for: .normal)
            
        }
    }
    
    @IBAction func AddNewComment(_ sender: Any) {
        
        if AddCommentTV.text == "اضافة تعليق جديد" || AddCommentTV.text == "" || AddCommentTV.text == "" {
            self.navigationController?.view.makeToast( "enter comment first".localized)
        }else {
            AddComment()
        }
        
    }
    
}

//MARK:-CollectionView Controller
extension uOrderDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FeatureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDetailsCell", for: indexPath) as! ShowDetailsCell
        
        if FeatureData {
            let Model = FeatureArray[indexPath.row]
            
            cell.CellTitle.text = Model.specification_section_feature?.feature_name ?? ""
            cell.CellAnswer.text = Model.specification_answer
            
        }
        
        cell.flipX()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16)/3
        return CGSize.init(width: width , height:46)
    }
    
}

//MARK:-TableView Contoller

extension uOrderDetailsVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Model = CommentArray[indexPath.row]
        
        if Model.comment_if_advertiser_reply_yet == true {
            
            let cell = tableView.dequeue() as CommentWithReplayCell
            
            cell.CommentName.text = Model.comment_voter_name ?? "" + "say".localized
            cell.CommentTime.text = Model.comment_text_custom_date ?? ""
            cell.CommentText.text = Model.comment_text ?? ""
            
            cell.CommentReplayName.text = "Advertiser's answer".localized
            cell.CommentReplayText.text = Model.comment_advertiser_reply ?? ""
            cell.CommentReplayTime.text = Model.comment_advertiser_reply_custom_date ?? ""
            
            cell.DeleteHight.constant = 0
            if Model.comment_voter_name == AuthService.userData?.advertiser_name {
                cell.Deletbtn.isHidden = false
                cell.DeleteHight.constant = 24
            }
            
            cell.DeletComment = {
                self.RemoveComment(id: Model.comment_id ?? 0)
                self.CommentArray.remove(at: indexPath.row)
                self.CommentsTableView.reloadData()
            }
            
            return cell
            
        }else{
            
            let cell = tableView.dequeue() as CommentCellTableViewCell
            
            cell.CommentName.text = Model.comment_voter_name ?? ""
            cell.CommentText.text = Model.comment_text ?? ""
            cell.CommentTime.text = Model.comment_text_custom_date ?? ""
            
            cell.DeleteBtnHight.constant = 0
            cell.Deletbtn.isHidden = true
            
            if Model.comment_voter_name == AuthService.userData?.advertiser_name {
                cell.Deletbtn.isHidden = false
                cell.DeleteBtnHight.constant = 24
            }
            
            cell.DeletComment = {
                self.RemoveComment(id: Model.comment_id ?? 0)
                self.CommentArray.remove(at: indexPath.row)
                self.CommentsTableView.reloadData()

            }
            return cell
        }
    }
    
}

//MARK:-API

extension uOrderDetailsVC {
    
    func getOrderDetails() {
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-order/\(Order_id)?page=\(CurrentPage)") { (data : ShowOrderModel?, String) in
            
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                //                self.CurrentPage = data.data?.comments_pagination?.current_page ?? 1
                //                self.lastPage = data.data?.comments_pagination?.last_page ?? 1
                //
                
                self.Urer_Id = "\(data.data?.order_details?.order_advertiser_id ?? 0)"
                self.User_Name = data.data?.order_details?.order_advertiser_name ?? ""
                self.Order_id = "\(data.data?.order_details?.order_id ?? 0)"
                self.OrderNumber.text = "\(data.data?.order_details?.order_id ?? 0)"
                self.OrderTitle.text = "\(data.data?.order_details?.order_title ?? "")"
                self.OrderPrice.text = "less than ".localized + "\(data.data?.order_details?.order_price ?? "")"
                self.OrderDate.text = "published ".localized + "\(data.data?.order_details?.order_custom_published_date ?? "") | " + "Modified ".localized + "\(data.data?.order_details?.order_custom_last_update_date ?? "")"
                self.OrderDesc.text = "\(data.data?.order_details?.order_description ?? "")"
                // self.OrderAddress.text = "\(data.data?.order_details?.order_block?.block_name ?? "")"
                self.OtherName.text = "\(data.data?.order_details?.order_advertiser_name ?? "")"
                
                self.phoneNumber = data.data?.order_details?.order_call_number ?? ""
                self.whatsNumber = data.data?.order_details?.order_whatsapp_number ?? ""
                
                self.callState = data.data?.order_details?.order_call_number_status ?? ""
                self.whatsState = data.data?.order_details?.order_whatsapp_number_status ?? ""
                
                self.FeatureArray = data.data?.order_details?.order_specifications ?? []
                self.FeatureData = true
                
                if self.FeatureArray.count == 0 {
                    self.FueatureTitle.isHidden = true
                }else{
                    self.FueatureTitle.isHidden = false
                }
                
                
                self.PhoneView.isHidden = true
                if data.data?.order_details?.order_call_number_status == "active" {
                    
                    self.PhoneView.isHidden = false
                    
                }
                
                self.WhatsAppView.isHidden = true
                if data.data?.order_details?.order_whatsapp_number_status == "active" {
                    self.WhatsAppView.isHidden = false
                    
                }
                
                self.ChatView.isHidden = true
                if "\(data.data?.order_details?.order_advertiser_id ?? 0)" != "\(AuthService.userData?.advertiser_id ?? 0)"  {
                    self.ChatView.isHidden = false
                }
                
                
                self.CommentCount.text = "( \(data.data?.comments_count ?? "") )"
                self.Commentnumber = Int(data.data?.comments_count ?? "") ?? 0
                
                
                if data.data?.comments_count != "0" {
                    self.CommentData = true
                    self.CommentsTableView.reloadData()
                }
                
                
                self.addCommentBtn.isHidden = true
                if "\(data.data?.order_details?.order_advertiser_id ?? 0)" != "\(AuthService.userData?.advertiser_id ?? 0)" {
                    
                    self.addCommentBtn.isHidden = false
                    
                }
                
                self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.OrderDesc.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                
                
                self.DetailsCollectionView.reloadData()
                self.MainView.isHidden = false
                
                print(data)
                
            }
        }
    }
    
    
    func AddComment() {
        self.view.lock()
        
        let Parameters = [
            "order_id" : Order_id,
            "comment" : AddCommentTV.text ?? ""
        ]
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)order-operations/add-comment") { (data : SingleCommentModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.CommentViewHeight.constant = 0
                    self.CommentView.alpha = 0
                    self.CommentsTableView.reloadData()
                    
                    
                }, completion: { _ in
                    UIView.animate(withDuration: 0.3, animations: {
                        
                    }, completion: { _ in
                        
                        
                    })
                })
                
                
                print(data)
                
                
                guard let model = data.data?.comment else {
                    return
                }
                
                self.CommentArray.insert(model, at: 0)
                
                self.Commentnumber += 1
                self.CommentCount.text = "( \(self.Commentnumber) )"
                
                self.NoCommentLable.isHidden = true
                self.CommentsTableView.isHidden = false
                
                self.addCommentBtn.setTitle("Add comment".localized.localized, for: .normal)
                
                self.CommentsTableView.reloadData()
                
                print(data)
                
            }
        }
    }
    
    
    func RemoveComment(id : Int) {
        self.view.lock()
        
        let Parameters = [
            "comment_id" : "\(id)",
        ]
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)order-operations/remove-comment") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                if self.Commentnumber == 0 {
                    self.NoCommentLable.isHidden = false
                }
                
                self.Commentnumber -= 1
                self.CommentCount.text = "( \(self.Commentnumber) )"
                
                if self.CommentArray.count == 0 {
                    self.CommentsTableView.isHidden = true
                    self.NoCommentLable.isHidden = false
                }else{
                    self.CommentsTableView.isHidden = false
                    self.NoCommentLable.isHidden = true
                }
                
                self.CommentsTableView.reloadData()
                
                print(data)
                
            }
        }
    }
    
    func ShowComment() {
        
       
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-order-comments/\(Order_id)?page=\(CurrentPage)") { (data : AllCommentModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                print(String!)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.CommentArray.append(item)
                }
                
                if data.data?.data?.count ?? 0 == 0 {
                    self.NoCommentLable.isHidden = false
                }else{
                    self.NoCommentLable.isHidden = true
                }
                
                self.CommentData = true
                
                if data.data?.pagination?.has_more_pages == false {
                    self.ShowMoreBtn.isHidden = true
                }
                
                if data.data?.data?.count ?? 0 == 0 {
                    self.NoCommentLable.isHidden = false
                    self.CommentsTableView.isHidden = true
                }else{
                    self.NoCommentLable.isHidden = true
                    self.CommentsTableView.isHidden = false
                }
                
                self.CommentsTableView.reloadData()
    
                self.isActive = true
                
                print(data)
            }
        }
    }
    
}
