//
//  OrderrVC.swift
//  AskHail
//
//  Created by bodaa on 15/02/2021.
//  Copyright © 2021 MOHAB. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import FirebaseDynamicLinks

class OrderVC: UIViewController {

    @IBOutlet weak var ScrollBackGround: UIView!
    @IBOutlet var MainBackRound: UIView!
    @IBOutlet weak var buttomView: UIView!
    
    @IBOutlet weak var collectionViewHight: NSLayoutConstraint!
    @IBOutlet weak var tableviewhight: NSLayoutConstraint!
    @IBOutlet weak var MainView: UIScrollView!
    
    @IBOutlet weak var AdvNumber: UILabel!
    
    @IBOutlet weak var SarLbl: UILabel!
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var OrderTitle: UILabel!
    @IBOutlet weak var OrderPrice: UILabel!
    @IBOutlet weak var OrderDate: UILabel!
    
    @IBOutlet weak var FeatureView: UIView!
    @IBOutlet weak var FueatureTitle: UIStackView!
    @IBOutlet weak var OrderDescription: UILabel!
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    
    @IBOutlet weak var OwnerView: UIView!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var OwnerAdsCount: UILabel!
    @IBOutlet weak var ChatView: UIView!
    @IBOutlet weak var WatsAppView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    @IBOutlet weak var VisitorView: UIView!
    @IBOutlet weak var Lable: UILabel!
    
    @IBOutlet weak var CommemtView: UIView!
    @IBOutlet weak var OrderCommentCount: UILabel!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var addCommentBtn: UIButton!
    @IBOutlet weak var ShowMoreBtn: UIButton!
    @IBOutlet weak var NoCommentLable: UILabel!
    
    @IBOutlet weak var EditView: UIView!
    
    @IBOutlet weak var adNomberLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var featureLbl: UILabel!
    @IBOutlet weak var goNowBnt: UIButton!
    @IBOutlet weak var adviserLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var adviserBtn: UIButton!
    @IBOutlet weak var AdviserNomLbl: UILabel!
    @IBOutlet weak var deleteLbl: UILabel!
    @IBOutlet weak var editLbl: UILabel!
    
    
    var is_Success = false

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
    
    var markers = [GMSMarker]()
    var Order : ShowOrderData?
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
    
    var isSaved = false
    
    var isActive = true
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        EditView.isHidden = true
        MainView.isHidden = true
        CurrentPage = 1
        lastPage = 1
        CommentArray.removeAll()
        getOrderDetails()
        ShowComment()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deleteLbl.text = "Delete".localized
        editLbl.text = "Edit".localized

        adNomberLbl.text = "Order number".localized
        detailsLbl.text = "Description".localized
        featureLbl.text = "Specifications".localized
        addressLbl.text = "Address".localized
        adviserLbl.text = "Advertiser".localized
        commentLbl.text = "Comments".localized
        addCommentBtn.setTitle("Add comment".localized, for: .normal)
        ShowMoreBtn.setTitle("Show more".localized, for: .normal)
        goNowBnt.setTitle("Go now".localized, for: .normal)
        adviserBtn.setTitle("Advertiser page".localized, for: .normal)
        AdviserNomLbl.text = "ads".localized
        SarLbl.text = "SAR".localized
        
        ScrollBackGround.backgroundColor = UIColor(hexString: "E5F2F7")
        MainBackRound.backgroundColor = UIColor(hexString: "E5F2F7")
        
        setShadow(view: DetailsView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: FeatureView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: OwnerView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: CommemtView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: EditView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        AdvNumber.text = Order_id
        
        NoCommentLable.text = "No Commentns".localized
        
        if DynamicLinkModel.isDynamic {
            
            self.Order_id = DynamicLinkModel.Product_id
            self.AdvNumber.text = DynamicLinkModel.Product_id
            
        }
        
        OrderDescription.font = UIFont(name: "Tajawal-Regular", size: 16)

        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        CommentsTableView.RegisterNib(cell: CommentWithReplayCell.self)
        
        CommentsTableView.RegisterNib(cell: CommentCellTableViewCell.self)
        
        CommentsTableView.RegisterNib(cell: ReplayCommentCell.self)
        
        
        
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.delegate = self
        DetailsCollectionView.RegisterNib(cell: ShowDetailsCell.self)
        DetailsCollectionView.flipX()
        
        
        VisitorView.isHidden = true
        
        if Helper.getapitoken() == nil {
            
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
    
    @IBAction func BackAction(_ sender: Any) {
        
        if DynamicLinkModel.isDynamic || is_Success {
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
    
    @IBAction func ShareAds(_ sender: Any) {
        
        guard let link = URL(string: "https://askhail.page.link/order/\(Order_id)") else { return }
        let dynamicLinksDomainURIPrefix = "https://askHail.page.link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.wesal.askHail")
        linkBuilder?.iOSParameters?.appStoreID = "1542462594"
        linkBuilder?.iOSParameters?.minimumAppVersion = "1.1.0"
        
        linkBuilder?.navigationInfoParameters = DynamicLinkNavigationInfoParameters()
        linkBuilder?.navigationInfoParameters?.isForcedRedirectEnabled = true
        
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.wesal.askhail")
        linkBuilder?.androidParameters?.minimumVersion = 1
        
        guard let longDynamicLink = linkBuilder?.url else {
            return
            
        }
        print(longDynamicLink)
        
        DynamicLinkComponents.shortenURL(longDynamicLink, options: nil) { url, warnings, error in
          guard let url = url, error == nil else { return }
          print("The short URL is: \(url)")
            
            let shareText = "\(self.OrderTitle.text ?? "")" + "\n" + "\(url)"
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            if(UIDevice.current.userInterfaceIdiom == .pad){
                vc.popoverPresentationController?.sourceView = self.view
            }else{
                self.present(vc, animated: true, completion: {})
            }
            
        }
        
    }
    
    @IBAction func OtherPageAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
        vc.User_id = self.Urer_Id
        vc.User_Name = self.User_Name
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func ShoeMoreCommentAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
        vc.Adv_Id = "\(Order?.order_details?.order_id ?? 0)"
        vc.user_id = "\(Order?.order_details?.order_advertiser_id ?? 0)"
        vc.statue = 2
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        
    }
    
    @IBAction func AddComment(_ sender: Any) {

        guard Helper.getapitoken() != nil else {
            alertSkipLogin()
            return
        }
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "CommentPopupVC") as! CommentPopupVC
        vc.Delegte = self
        vc.action = "comment"
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func EditAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: EditOrder_srory , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "EditOrderPopUpVC") as! EditOrderPopUpVC
        vc.deleget = self
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func DeletAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "DeleteOrderPopUpVC") as! DeleteOrderPopUpVC
        vc.Ad_Id = Order_id
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }

}

//MARK:-CollectionView Controller
extension OrderVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
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

//MARK:- Protocol Controller

extension OrderVC : AddComent{
    func addNewComment(comment_text: String, state: Int, comment_id: String) {
        if state == 1 {
           AddReplay(comment_id: comment_id, CommentText: comment_text)
        }else{
            print("\(Order?.order_details?.order_id ?? 0)")
            NewComment(Adv_id: "\(Order?.order_details?.order_id ?? 0)", CommentText: comment_text)
        }
    }
}

//MARK:-API

extension OrderVC {
    
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
                
                self.Order = data.data
                self.CheckIfMyAds()
                
                self.Urer_Id = "\(data.data?.order_details?.order_advertiser_id ?? 0)"
                self.User_Name = data.data?.order_details?.order_advertiser_name ?? ""
                self.Order_id = "\(data.data?.order_details?.order_id ?? 0)"
                self.OrderTitle.text = "\(data.data?.order_details?.order_title ?? "")"
                self.OrderPrice.text = "less than ".localized + "\(data.data?.order_details?.order_price ?? "")"
                self.OrderDate.text = "published ".localized + "\(data.data?.order_details?.order_custom_published_date ?? "") | " + "Modified ".localized + "\(data.data?.order_details?.order_custom_last_update_date ?? "")"
                self.OrderDescription.text = "\(data.data?.order_details?.order_description ?? "")"
                self.OwnerName.text = "\(data.data?.order_details?.order_advertiser_name ?? "")"
                
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
                
                self.WatsAppView.isHidden = true
                if data.data?.order_details?.order_whatsapp_number_status == "active" {
                    self.WatsAppView.isHidden = false
                    
                }
                
                self.ChatView.isHidden = true
                if "\(data.data?.order_details?.order_advertiser_id ?? 0)" != Helper.getaUser_id()  {
                    self.ChatView.isHidden = false
                }
                
                
                self.OrderCommentCount.text = "( \(data.data?.comments_count ?? "") )"
                self.Commentnumber = Int(data.data?.comments_count ?? "") ?? 0
                
                if self.CommentArray.count > 0 {
                    self.CommentsTableView.reloadData()
                    self.CommentsTableView.removeNoDataLabel()
                    self.tableviewhight.constant = self.CommentsTableView.contentSize.height
                    self.NoCommentLable.isHidden = true
                }else {
                    self.CommentsTableView.reloadData()
                    self.NoCommentLable.isHidden = false
                    self.tableviewhight.constant = 50
                   
                }
                
                DispatchQueue.main.async {
                    self.CommentsTableView.reloadData()
                    self.collectionViewHight.constant = self.DetailsCollectionView.contentSize.height
                    self.DetailsCollectionView.updateConstraints()
                }
                
                DispatchQueue.main.async {
                    self.CommentsTableView.reloadData()
                    self.tableviewhight.constant = self.CommentsTableView.contentSize.height
                    self.CommentsTableView.reloadData()
                    self.MainView.layoutIfNeeded()
                }
              
                self.DetailsCollectionView.reloadData()
                self.CommentsTableView.reloadData()
                self.MainView.layoutIfNeeded()
                
                self.MainView.isHidden = false
                print(data)
                
            }
        }
    }
    
    func ShowComment() {
        DispatchQueue.main.async {
            self.CommentsTableView.removeNoDataLabel()
        }
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-order-comments/\(Order_id)?page=\(CurrentPage)") { (data : AllCommentModel?, String) in
            
            if String != nil {
                
            }else {
                
                guard let data = data else {
                    return
                }
                
              
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.CommentArray.append(item)
                }
                
                if data.data?.pagination?.has_more_pages == false {
                    self.ShowMoreBtn.isHidden = true
                }else{
                    self.ShowMoreBtn.isHidden = false
                }
                
                if self.CommentArray.count > 0 {
                    self.CommentsTableView.isHidden = false
                    self.CommentsTableView.reloadData()
                    self.tableviewhight.constant = self.CommentsTableView.contentSize.height
                    self.NoCommentLable.isHidden = true
                }else {
                    self.CommentsTableView.reloadData()
                    self.CommentsTableView.isHidden = true
                    self.NoCommentLable.isHidden = false
                    self.tableviewhight.constant = 50
                   
                }
                
               
                DispatchQueue.main.async {
                    self.CommentsTableView.reloadData()
                    self.collectionViewHight.constant = self.DetailsCollectionView.contentSize.height
                    self.DetailsCollectionView.updateConstraints()
                    self.tableviewhight.constant = self.CommentsTableView.contentSize.height
                    self.CommentsTableView.reloadData()
                    self.MainView.layoutIfNeeded()
                }

                self.DetailsCollectionView.reloadData()
                self.CommentsTableView.reloadData()
                self.MainView.layoutIfNeeded()
                
                self.isActive = true
                
                print(data)
            }
        }
    }
    func NewComment(Adv_id : String , CommentText : String) {
        
        let Parameters = [
            "order_id" : Adv_id,
            "comment" : CommentText
        ] as [String : Any]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)order-operations/add-comment") { (data : SingleCommentModel?, String) in
            
            if String != nil {
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            } else {
                
                guard let data = data else {
                    return
                }

                print(data)
                
                
                guard let model = data.data?.comment else {
                    return
                }

                self.Commentnumber += 1
                self.OrderCommentCount.text = "( \(self.Commentnumber) )"
                
                self.NoCommentLable.isHidden = true
                self.CommentsTableView.isHidden = false
                
                self.CurrentPage = 1
                self.CommentArray.removeAll()
                
                self.ShowComment()
                
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
                

                self.Commentnumber -= 1
                self.OrderCommentCount.text = "( \(self.Commentnumber) )"
                
                if self.CommentArray.count == 0 {
                    self.CommentsTableView.isHidden = true
                    self.NoCommentLable.isHidden = false
                }else{
                    self.CommentsTableView.isHidden = false
                    self.NoCommentLable.isHidden = true
                }
                
                self.CurrentPage = 1
                self.CommentArray.removeAll()
                self.ShowComment()
                
                print(data)
                
            }
        }
    }
    
    func AddReplay(comment_id : String , CommentText : String) {
        
        let Parameters = [
            "comment_id" : comment_id,
            "reply" : CommentText
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/order-add-or-update-reply-on-comment") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                self.CurrentPage = 1
                self.CommentArray.removeAll()
                
                self.ShowComment()

                print(data)
            }
        }
    }
}
