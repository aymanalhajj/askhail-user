//
//  BusinessAdsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/6/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import FSPagerView
import Cosmos
import GoogleMaps
import GooglePlaces
import FirebaseDynamicLinks

class BusinessAdsDetailsVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    // MARK:OutLet
    @IBOutlet weak var ViewImg: UIImageView!
    
    @IBOutlet weak var noSocialLabel: UILabel!
    
    @IBOutlet weak var SARLbl: UILabel!
    @IBOutlet weak var MapIcon: UIImageView!
    @IBOutlet weak var ChatView: UIView!
    @IBOutlet weak var WatsAppView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    @IBOutlet weak var imgVedio: UIImageView!
    @IBOutlet weak var PromotionalPhotoBtn: UIButton!
    @IBOutlet weak var RateView: CosmosView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var AdsNumber: UILabel!
    @IBOutlet weak var AdsTitle: UILabel!
    @IBOutlet weak var AdsRate: UILabel!
    @IBOutlet weak var AdsDisnatce: UILabel!
    @IBOutlet weak var ViewsNumber: UILabel!
    @IBOutlet weak var AdsDate: UILabel!
    @IBOutlet weak var AdvState: UILabel!
    @IBOutlet weak var AdvPrice: UILabel!
    
    @IBOutlet weak var AdsDescribtion: UILabel!
    @IBOutlet weak var Addess: UILabel!
    @IBOutlet weak var AdsOwnerName: UILabel!
    @IBOutlet weak var NumberOsAds: UILabel!
    @IBOutlet weak var NumberOfComments: UILabel!
    @IBOutlet weak var TotalCommentsRate: UILabel!
    @IBOutlet weak var checkBoxBtn: UIButton!
    @IBOutlet weak var ScrollView: NSLayoutConstraint!
    @IBOutlet weak var StarAdsView: UIView!
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var PagerView: FSPagerView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var CommentView: UIView!
    @IBOutlet weak var CommentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var MainView: UIScrollView!
    @IBOutlet weak var ShowMoreBtn: UIButton!
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var featureHeight: NSLayoutConstraint!
    @IBOutlet weak var NoCommentLable: UILabel!
    @IBOutlet weak var CollectionBottomhight: NSLayoutConstraint!
    @IBOutlet weak var FeatuseTopTitle: UIStackView!
    
    @IBOutlet weak var SocialView: UIView!
    @IBOutlet weak var SocialViewHight: NSLayoutConstraint!
    @IBOutlet weak var SocialStackView: UIStackView!
    
    
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var instgrameView: UIView!
    @IBOutlet weak var snapChatView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var websiteView: UIView!
    
    @IBOutlet weak var AddNewRateBtn: UIButton!

    
    @IBOutlet weak var FlagBtn: UIButton!
    
    
    var refreshControl = UIRefreshControl()
    
    var RateState = false
    var AdId = ""
 //   var Adviser_id = ""
    var RateArray : [Rate] = []
    var AdData : ShowBusinessAdvData?
    var FeatureArray : [Adv_specifications] = []
    var FeatureData = false
    var media = [Adv_media]()
    
    var lang = ""
    var lat = ""
    
    var WhatsApp = ""
    
    var phoneNumber = ""
    var callState = ""
    
    var whatsNumber = ""
    var whatsState = ""
    
    var CommentCount = 0
    
    var checkBox = false
    var RateData = false
    var isActive = true
    
    
    var TwitterLbl = ""
    var InstgrameLbl = ""
    var SnapLable = ""
    var FaceBookLbl = ""
    var WebSiteLbl = ""
    
    var isHome = 0
    var isProfile = 0
    
    var x = 0.0
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        MainView.isHidden = true
        CurrentPage = 1
        lastPage = 1
        RateArray.removeAll()
        ShowRate()
        getAdData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if app_enable_show_count == false {
            ViewImg.isHidden = true
            ViewsNumber.isHidden = true
        }else {
            ViewImg.isHidden = false
            ViewsNumber.isHidden = false
        }
        
        AdsNumber.text = "\(AdId)"
        NoCommentLable.text = "No rates".localized
        
        noSocialLabel.text = "No social media avilable".localized

        
        if DynamicLinkModel.isDynamic {
            
            self.AdId = DynamicLinkModel.Product_id
            
            
        }
        
        
        tabBarController?.tabBar.isHidden = true
        
        lang = AdData?.advertisement_details?.adv_latitude ?? ""
        lat = AdData?.advertisement_details?.adv_latitude ?? ""
        
        
        if L102Language.currentAppleLanguage() == englishLang {
            
            RateView.semanticContentAttribute = .forceLeftToRight
            
        }
        
        pageControl.currentPage = 0
        
        
        AdsDescribtion.font = UIFont(name: "Tajawal-Regular", size: 16)
        
        Addess.font = UIFont(name: "Tajawal-Regular", size: 16)
        
        CommentViewHeight.constant = 0
        CommentView.alpha = 0
        mapView.addSubview(MapIcon)
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        CommentsTableView.RegisterNib(cell: RateCell.self)
        
        PagerView.dataSource = self
        PagerView.delegate = self
        
        PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.delegate = self
        DetailsCollectionView.RegisterNib(cell: ShowDetailsCell.self)
        DetailsCollectionView.flipX()
        
        
        PagerView.isInfinite = false
        PagerView.addSubview(pageControl)
        PagerView.addSubview(StarAdsView)
        PagerView.addSubview(imgVedio)
        PagerView.itemSize = CGSize(width: PagerView.frame.size.width, height: PagerView.frame.size.height)
        PagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        PagerView.automaticSlidingInterval = 5.0
        
        print(DetailsView.frame.height)
        
        self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.AdsDescribtion.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.AdsOwnerName.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.SocialStackView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        CommentsTableView.layer.removeAllAnimations()
        DetailsCollectionView.layer.removeAllAnimations()
        
        if PromotionalPhotoBtn.isHidden == true {
            featureHeight.constant = DetailsCollectionView.contentSize.height + 120 + AdsDescribtion.intrinsicContentSize.height
            CollectionBottomhight.constant = 0
        }else{
            featureHeight.constant = DetailsCollectionView.contentSize.height + 180 +  AdsDescribtion.intrinsicContentSize.height
            CollectionBottomhight.constant = 80
        }
        

        ScrollView.constant = CommentsTableView.contentSize.height + 1240 + featureHeight.constant + CommentViewHeight.constant + SocialView.frame.height
        
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
    }
    
    
    func CreateMarker(Lat : Double , lng : Double){
        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude:Lat, longitude: lng)
//        //        marker.title = "Sydney"
//        //        marker.snippet = "Australia"
//        marker.map = mapView
        let cameraPosition = GMSCameraPosition.camera(withLatitude: Lat, longitude: lng, zoom: 15.0)
        mapView.animate(to: cameraPosition)
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return media.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        pageControl.currentPage = index
        
        if media[index].media_video != "" {
            
            self.imgVedio.isHidden = false
        }else {
            self.imgVedio.isHidden = true
            
        }
        
        cell.imageView?.loadImage(URL(string: media[index].media_image ?? ""))
        cell.imageView?.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
        print(media)
        if media[index].media_video != "" {
            
            let storyboard = UIStoryboard(name: Home, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "OpenViewVC") as! OpenViewVC
            vc.modalPresentationStyle = .fullScreen
            vc.videoUrl = media[index].media_video
            present(vc, animated: true, completion: nil)
            
        }else {
            
            var imageV = UIImageView()
            imageV.loadImage(URL(string: media[index].media_image ?? ""))
            
            Helper.openZoomAbleImage(image: imageV.image ?? UIImage(), vc: self)
            
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
    
    @IBAction func FlagAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "MainAndAds", bundle: nil)
        
        guard let popupVC = storyboard.instantiateViewController(withIdentifier: "ChooseBlockVC") as? ChooseBlockVC else { return }
        
        popupVC.Delegate = self
//        popupVC.Delegate = self
        popupVC.height = 50
        popupVC.topCornerRadius = 8
        popupVC.presentDuration = 0.7
        popupVC.dismissDuration = 0.7
        //  popupVC.modalPresentationStyle = .overCurrentContext
        self.present(popupVC, animated: true, completion: nil)
    }
    
    
    @IBAction func SaveAvtion(_ sender: Any) {
        guard AuthService.userData?.advertiser_api_token != nil else {
            
            alertSkipLogin()
            return
        }
        
        AddToFavourite(advertisement_id: AdId)
        
        if checkBox == false{
            checkBoxBtn.setImage(#imageLiteral(resourceName: "save_white-1"), for: .normal)
            checkBox = true
        }else{
            checkBoxBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
            checkBox = false
        }
        
    }
    
    @IBAction func ShareAds(_ sender: Any) {
        
        guard let link = URL(string: "https://askhail.page.link/advert/\(AdId)") else { return }
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
            
            let shareText = "\(self.AdsTitle.text ?? "")" + "\n" + "\(url)"
            let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
            if(UIDevice.current.userInterfaceIdiom == .pad){
                vc.popoverPresentationController?.sourceView = self.view
            }else{
                self.present(vc, animated: true, completion: {})
            }
            
        }
        
    }
    
    @IBAction func Photogrphe(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessAdsPopUpVC") as! BusinessAdsPopUpVC
        vc.modalPresentationStyle = .fullScreen
        vc.image = AdData?.advertisement_details?.adv_promotional_image ?? ""
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func ContactTwitterAcction(_ sender: Any) {
        openUrl(link: TwitterLbl)
    }
    
    @IBAction func ContactInstgrameAction(_ sender: Any) {
        openUrl(link: InstgrameLbl)
    }
    
    
    @IBAction func ConractSnapAction(_ sender: Any) {
        openUrl(link: SnapLable)
    }
    
    @IBAction func ContactFaceBookAction(_ sender: Any) {
        openUrl(link: FaceBookLbl)
    }
    
    @IBAction func WebSiteAction(_ sender: Any) {
        openUrl(link: WebSiteLbl)
        
    }
    
    @IBAction func GoToPlaceAction(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(Double(AdData?.advertisement_details?.adv_latitude ?? "") ?? 0.0),\(Double(AdData?.advertisement_details?.adv_longitude ?? "") ?? 0.0)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
        
        
    }
    
    @IBAction func PhneCallAction(_ sender: Any) {
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
    
    @IBAction func AppChatAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: Chat, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "chatVC") as! chatVC
        vc.FromDetails = true 
        vc.chat_type_id = self.AdId
        vc.chat_type = "advertisement"
        vc.isSubView = 1
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func ProfileAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "BusinessProfileVC") as! BusinessProfileVC
        vc.User_id = "\(AdData?.advertisement_details?.adv_advertiser_id ?? 0)"
        vc.User_Name = AdData?.advertisement_details?.adv_advertiser_name ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func AddComment(_ sender: Any) {
        
        RateView.rating = 0
        
        if RateState == false {
            RateState = true
            UIView.animate(withDuration: 0.6, animations: {
                
                self.CommentViewHeight.constant = 172
                self.CommentView.alpha = 1
                self.CommentsTableView.reloadData()
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    
                    
                    
                }, completion: { _ in
                    
                    
                })
            })
            AddNewRateBtn.setTitle("Cancel".localized, for: .normal)
        }else{
            RateState = false
            UIView.animate(withDuration: 0.3, animations: {
                
                self.CommentViewHeight.constant = 0
                self.CommentView.alpha = 0
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.3, animations: {
                    
                }, completion: { _ in
                    
                })
            })
            AddNewRateBtn.setTitle("Add rate".localized, for: .normal)
        }
        
    }
    
    
    @IBAction func AddNewComment(_ sender: Any) {
        if RateView.rating > 0 {
            AddNewRate()
        }else {
            self.navigationController?.view.makeToast( "enter comment first".localized)
        }
    }
    
    @IBAction func ShawMoreRateAction(_ sender: Any) {
        
        
        
        if lastPage > CurrentPage {
            CurrentPage = CurrentPage + 1
            ShowRate()
        }
      
        
    }
    
    
    
    @IBAction func Reportaction(_ sender: Any) {
        
        
    }
    
}


extension BusinessAdsDetailsVC : Choose_Block  {
    func Report_type(Report_Type: Report_type) {
        switch Report_Type {
        case .Adv:
            let storyboard = UIStoryboard(name: "MainAndAds", bundle: nil)
            guard let popupVC = storyboard.instantiateViewController(withIdentifier: "ReportAdVC") as? ReportAdVC else { return }
            popupVC.report_type = "adv"
            popupVC.report_type_id = self.AdId
            popupVC.title_page = "Report Content".localized
            popupVC.height = 50
            popupVC.topCornerRadius = 8
            popupVC.presentDuration = 0.7
            popupVC.dismissDuration = 0.7
            //  popupVC.modalPresentationStyle = .overCurrentContext
            self.present(popupVC, animated: true, completion: nil)
        
        case .Order:
            let storyboard = UIStoryboard(name: "MainAndAds", bundle: nil)
            guard let popupVC = storyboard.instantiateViewController(withIdentifier: "ReportAdVC") as? ReportAdVC else { return }
            popupVC.title_page = "Report Content".localized
            popupVC.report_type = "order"
            popupVC.report_type_id = self.AdId
            popupVC.title_page = "Report Content".localized
            popupVC.height = 50
            popupVC.topCornerRadius = 8
            popupVC.presentDuration = 0.7
            popupVC.dismissDuration = 0.7
            //  popupVC.modalPresentationStyle = .overCurrentContext
            self.present(popupVC, animated: true, completion: nil)
        case .Ask:
            let storyboard = UIStoryboard(name: "MainAndAds", bundle: nil)
            guard let popupVC = storyboard.instantiateViewController(withIdentifier: "ReportAdVC") as? ReportAdVC else { return }
            popupVC.title_page = "Report Content".localized
            popupVC.report_type = "question"
            popupVC.report_type_id = self.AdId
            popupVC.height = 50
            popupVC.topCornerRadius = 8
            popupVC.presentDuration = 0.7
            popupVC.dismissDuration = 0.7
            //  popupVC.modalPresentationStyle = .overCurrentContext
            self.present(popupVC, animated: true, completion: nil)
        case .adviser:
            let storyboard = UIStoryboard(name: "MainAndAds", bundle: nil)
            guard let popupVC = storyboard.instantiateViewController(withIdentifier: "ReportAdVC") as? ReportAdVC else { return }
            popupVC.title_page = "Report Publisher".localized
            popupVC.report_type = "advertiser"
            popupVC.report_type_id = "\(self.AdData?.advertisement_details?.adv_advertiser_id ?? 0)"
            popupVC.height = 50
            popupVC.topCornerRadius = 8
            popupVC.presentDuration = 0.7
            popupVC.dismissDuration = 0.7
            //  popupVC.modalPresentationStyle = .overCurrentContext
            self.present(popupVC, animated: true, completion: nil)
        case .Block:
            let alert = UIAlertController.init(title: "Warning".localized , message: "Are You Sure To Ban Adviser".localized ,  preferredStyle: .alert)
          alert.view.tintColor = Colors.DarkBlue
            var Ok = "OK"
            var Cancel_lang = "cancel"
            
            if L102Language.currentAppleLanguage() == arabicLang {
                Ok = "حسنا"
                Cancel_lang = "الغاء"
                
            }


            let OkBtn = UIAlertAction.init(title: Ok, style: .default, handler: { (nil) in
                
                self.Block()
                

            })
            let Cancel = UIAlertAction.init(title: Cancel_lang, style: UIAlertAction.Style.destructive, handler: { (nil) in


            })



            alert.addAction(OkBtn)


            alert.addAction(Cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
}

//MARK:-CollectionView Controller
extension BusinessAdsDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FeatureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowDetailsCell", for: indexPath) as! ShowDetailsCell
        
        if FeatureData {
            let Model = FeatureArray[indexPath.row]
            
            cell.CellTitle.text = Model.specification_section_feature?.feature_name ?? ""
            cell.CellAnswer.text = Model.specification_answer
            
            cell.CellTitle.addInterlineSpacing(isCentered: false)
            cell.CellAnswer.addInterlineSpacing(isCentered: false)
            
        }
        
        cell.flipX()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 16)/2
        
        return CGSize.init(width: width , height:60)
    }
    
}

//MARK:-TableView Contoller
extension BusinessAdsDetailsVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  RateArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as RateCell
        
        if RateData {
            
            var Model = RateArray[indexPath.row]
            
            cell.CellName.text = "... \(Model.rate_voter_name ?? "")" + " Rated".localized
            cell.CellTime.text = Model.rate_custom_date ?? ""
            cell.CellRate.rating = Model.rate ?? 0.0
            
            cell.DeleteBtn.isHidden = true
            if "\(Model.rate_voter_id ?? 0)" == "\(AuthService.userData?.advertiser_id ?? 0)" {
                cell.DeleteBtn.isHidden = false
            }
            
            cell.DeletComment = {
                self.RemoveComment(id: Model.rate_id ?? 0)
                self.RateArray.remove(at: indexPath.row)
                self.CommentsTableView.reloadData()
            }
            
        }
        
        return cell
    }
    
}




//MARK:-API
extension BusinessAdsDetailsVC {
    
    func Block() {
        
        self.view.lock()

       var Parameters = [ "advertiser_id" : "\(self.AdData?.advertisement_details?.adv_advertiser_id ?? 0)"
       ]
       
       print(Parameters)
       
       ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)add-ban") { (data : Add_Report_Model?, String) in
           self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
               self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
               
               
                self.showAlertWithTitle(title: "", message: data.data ?? "", type: .success)
                self.dismiss(animated: true, completion: nil)
               
                print(data)
                
                
            }
        }
    }
    
    func getAdData() {
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-advertisement/\(AdId)") { (data : ShowBusinessAdvModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            } else {
                
                guard let data = data else {
                    return
                }
                
                self.AdData = data.data
                
                self.media = data.data?.advertisement_details?.adv_media ?? []
                
                self.AdsNumber.text = "  \(data.data?.advertisement_details?.adv_id ?? 0)".localized
                self.AdsTitle.text = data.data?.advertisement_details?.adv_title ?? ""
                
                if data.data?.advertisement_details?.adv_price ?? "" == "0" {
                    self.AdvPrice.isHidden = true
                    self.SARLbl.isHidden = true
                }else{
                    self.AdvPrice.text = data.data?.advertisement_details?.adv_price ?? ""
                }
                
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 10
                let attributes = [NSAttributedString.Key.paragraphStyle : style]
                self.AdsDescribtion.attributedText = NSAttributedString(string: data.data?.advertisement_details?.adv_distance ?? "", attributes:attributes)
                self.AdsDescribtion.textAlignment = .natural
                self.AdsDescribtion.textColor = Colors.DarkBlue
                self.AdsDescribtion.font = UIFont(name: "Tajawal-Regular", size: 16)
                
                
                self.ViewsNumber.text = data.data?.advertisement_details?.adv_views ?? ""
                self.AdsDisnatce.text = data.data?.advertisement_details?.adv_distance ?? ""
                self.AdsDate.text = "published ".localized + "\(data.data?.advertisement_details?.adv_custom_published_date ?? "") | " + "Modified ".localized + "\( data.data?.advertisement_details?.adv_custom_last_update_date ?? "")"
                
                self.AdsDescribtion.font = UIFont(name: "Tajawal-Regular", size: 16)
                self.AdsDescribtion.text = data.data?.advertisement_details?.adv_description ?? ""
                self.Addess.text = data.data?.advertisement_details?.adv_location ?? ""
                self.AdsOwnerName.text = data.data?.advertisement_details?.adv_advertiser_name ?? ""
                self.NumberOsAds.text = data.data?.advertisement_details?.adv_advertiser_advs_count ?? ""
                self.NumberOfComments.text = data.data?.rates_count ?? ""
                
                self.x = Double(data.data?.advertisement_details?.adv_total_rate ?? "") ?? 0.0
                let net = Double(round(100*self.x)/100)
                
                self.AdsRate.text = "\(net)"
                
                var x = 0
                
                if data.data?.advertisement_details?.adv_twitter ?? "" != ""{
                    self.TwitterLbl = data.data?.advertisement_details?.adv_twitter ?? ""
                    self.twitterView.isHidden = false
                }else{
                    self.twitterView.isHidden = true
                    x = x + 1
                }
                
                if data.data?.advertisement_details?.adv_instagram ?? "" != ""{
                    self.InstgrameLbl = data.data?.advertisement_details?.adv_instagram ?? ""
                    self.instgrameView.isHidden = false
                }else{
                    self.instgrameView.isHidden = true
                    x = x + 1
                }
                
                if data.data?.advertisement_details?.adv_snapchat ?? "" != ""{
                    self.SnapLable = data.data?.advertisement_details?.adv_snapchat ?? ""
                    self.snapChatView.isHidden = false
                }else{
                    self.snapChatView.isHidden = true
                    x = x + 1
                }
                
                if data.data?.advertisement_details?.adv_facebook ?? "" != ""{
                    self.FaceBookLbl = data.data?.advertisement_details?.adv_facebook ?? ""
                    self.facebookView.isHidden = false
                }else{
                    self.facebookView.isHidden = true
                    x = x + 1
                }
                
                if data.data?.advertisement_details?.adv_website ?? "" != ""{
                    self.WebSiteLbl = data.data?.advertisement_details?.adv_website ?? ""
                    self.websiteView.isHidden = false
                }else{
                    self.websiteView.isHidden = true
                    x = x + 1
                }
                
                self.FeatureArray = data.data?.advertisement_details?.adv_specifications ?? []
                
                
                if data.data?.advertisement_details?.adv_specifications?.count ?? 0 == 0 {
                    self.FeatuseTopTitle.isHidden = true
                }else{
                    self.FeatuseTopTitle.isHidden = false
                }
                
                
                
                self.phoneNumber = data.data?.advertisement_details?.adv_call_number ?? ""
                self.whatsNumber = data.data?.advertisement_details?.adv_whatsapp_number ?? ""
                
                self.callState = data.data?.advertisement_details?.adv_call_number_status ?? ""
                self.whatsState = data.data?.advertisement_details?.adv_whatsapp_number_status ?? ""
                
                self.pageControl.numberOfPages = self.media.count
                
                if self.media.count > 1 {
                    self.pageControl.isHidden = false
                }else{
                    self.pageControl.isHidden = true
                }
                
                self.PhoneView.isHidden = true
                self.WatsAppView.isHidden = true
                
                if "\(data.data?.advertisement_details?.adv_advertiser_id ?? 0)" != "\(AuthService.userData?.advertiser_id ?? 0)"  {
                    self.ChatView.isHidden = false
                }
                
                if data.data?.advertisement_details?.adv_call_number_status == "active" {
                    self.PhoneView.isHidden = false
                }
                

                if data.data?.advertisement_details?.adv_whatsapp_number_status == "active" {
                    self.WatsAppView.isHidden = false
                }
                
                if data.data?.advertisement_details?.adv_available_status !=  "" {
                    if data.data?.advertisement_details?.adv_available_status ==  "available" {
                        self.AdvState.textColor = #colorLiteral(red: 0.2862745098, green: 0.8588235294, blue: 0.4980392157, alpha: 1)
                    }else{
                        self.AdvState.textColor = #colorLiteral(red: 1, green: 0.4784313725, blue: 0.5803921569, alpha: 1)
                    }
                }
                
                
                if data.data?.advertisement_details?.adv_promotional_image ?? "" == "" || data.data?.advertisement_details?.adv_promotional_image ?? "" == "https://askhail.com.sa/public/images/no_image.png" {
                    self.PromotionalPhotoBtn.isHidden = true
                }else{
                    self.PromotionalPhotoBtn.isHidden = false
                }
                
                if L102Language.currentAppleLanguage() == englishLang {
                    self.AdvState.text = data.data?.advertisement_details?.adv_available_status ?? ""
                } else {
                    self.AdvState.text = data.data?.advertisement_details?.adv_available_custom_status ?? ""
                }
                
                
                self.checkBoxBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                if data.data?.advertisement_details?.adv_is_favorite == true {
                    self.checkBoxBtn.setImage(#imageLiteral(resourceName: "save_white-1"), for: .normal)
                    self.checkBox = true
                } else {
                    self.checkBoxBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                    self.checkBox = false
                }
                
                
                
                self.PhoneView.isHidden = true
                if data.data?.advertisement_details?.adv_call_number_status == "active" {
                    self.PhoneView.isHidden = false
                }
                
                self.WatsAppView.isHidden = true
                if data.data?.advertisement_details?.adv_call_number_status == "active" {
                    self.WatsAppView.isHidden = false
                }
                
                self.StarAdsView.isHidden = true
                if data.data?.advertisement_details?.adv_special_status == "مميز" || data.data?.advertisement_details?.adv_special_status == "special" {
                    self.StarAdsView.isHidden = false
                } else {
                    self.StarAdsView.isHidden = true
                }
                
                
                self.CreateMarker(Lat: Double(data.data?.advertisement_details?.adv_latitude ?? "0.0") ?? 0.0, lng: Double(data.data?.advertisement_details?.adv_longitude ?? "0.0") ?? 0.0)
                
                self.NumberOfComments.text = "( \(data.data?.rates_count ?? "") )"
                self.TotalCommentsRate.text = data.data?.rates_average ?? ""
                
//                self.SocialStackView.layoutIfNeeded()
//                if self.SocialStackView.frame.height == 24.0 {
//                    self.SocialStackView.isHidden = true
//                }
                
                if x == 5 {
                    self.SocialStackView.isHidden = true
                }else{
                    self.SocialStackView.isHidden = false
                }
                
                self.CommentsTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.AdsDescribtion.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.AdsOwnerName.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                self.SocialStackView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                
                self.PagerView.reloadData()
                self.FeatureData = true
                self.isActive = true
                self.CommentsTableView.reloadData()
                self.DetailsCollectionView.reloadData()
                self.MainView.isHidden = false
                
                print(data)
                
            }
        }
    }
    
    
    func AddToFavourite(advertisement_id : String) {
        
        self.view.lock()
        
        
        let param = [
            "advertisement_id" : advertisement_id
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-remove-favorite") { (data : ContactUsModel?, String) in
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                print(data)
                
                
            }
        }
    }
    
    
    func ShowRate() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-advertisement-rates/\(AdId)?page=\(CurrentPage)") { (data : ShowRateModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
             //   self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                print(self.CurrentPage)
              
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                self.CommentCount = data.data?.data?.count ?? 0
                self.RateData = true
                for item in data.data?.data ?? [] {
                    self.RateArray.append(item)
                }
                
                
                if data.data?.pagination?.has_more_pages == false {
                    self.ShowMoreBtn.isHidden = true
                }
                
                if data.data?.data?.count ?? 0 == 0 {
                    self.NoCommentLable.isHidden = false
                }else{
                    self.NoCommentLable.isHidden = true
                }
                self.AddNewRateBtn.isHidden = false
                self.CommentsTableView.reloadData()
                
                for item in self.RateArray {
                    if "\(item.rate_voter_id ?? 0)" == "\(AuthService.userData?.advertiser_id ?? 0)" {
                        self.AddNewRateBtn.isHidden = true
                        return
                    }else{
                        self.AddNewRateBtn.isHidden = false
                    }
                }
                
               
                self.isActive = true
                
                print(data)
            }
        }
    }
    
    func AddNewRate() {

            let Parameters = [
                "advertisement_id" : AdData?.advertisement_details?.adv_id ?? "",
                "rate" : "\(Int(RateView.rating))"
            ] as [String : Any]

            self.view.lock()

            ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-rate") { (data : AddRateModel?, String) in
                self.view.unlock()

                if String != nil {
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        
                        self.CommentViewHeight.constant = 0
                        self.CommentView.alpha = 0
                        
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.3, animations: {
                            
                        }, completion: { _ in
                            
                        })
                        
                        self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                    })

                } else {

                    guard let data = data else {
                        return
                    }
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        
                        self.CommentViewHeight.constant = 0
                        self.CommentView.alpha = 0
                        
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.3, animations: {
                            
                        }, completion: { _ in
                            
                        })
                    })
                    
                    guard let model = data.data?.rate else {
                        return
                    }
                    
                    self.RateArray.insert(model, at: 0)
                    
                    self.CommentCount += 1
                    self.NumberOfComments.text = "( \(self.CommentCount) )"
                    
                    self.NoCommentLable.isHidden = true
                    self.CommentsTableView.isHidden = false
                    self.AddNewRateBtn.isHidden = true
                    
                    self.CommentsTableView.reloadData()
                    
                    print(data)

                }
            }
        }
    
    
        func RemoveComment(id : Int) {
            self.view.lock()
    
            let Parameters = [
                "rate_id" : "\(id)",
            ]
            ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)advertisement-operations/remove-rate") { (data : Level_6_Model?, String) in
    
                self.view.unlock()
    
                if String != nil {
    
                    self.showAlertWithTitle(title: "Error", message: String!, type: .error)
    
                }else {
    
                    guard let data = data else {
                        return
                    }
                    
                    if self.RateArray.count == 0 {
                        self.CommentsTableView.isHidden = true
                        self.NoCommentLable.isHidden = false
                    }else{
                        self.CommentsTableView.isHidden = false
                        self.NoCommentLable.isHidden = true
                    }
                    
                    self.CommentCount -= 1
                    self.NumberOfComments.text = "( \(self.CommentCount) )"
                    
                    self.AddNewRateBtn.isHidden = false
                    self.CommentsTableView.reloadData()
                    
                    print(data)
    
                }
            }
        }
}

