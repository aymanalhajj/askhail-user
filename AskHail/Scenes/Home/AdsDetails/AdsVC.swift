//
//  AdsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 10/30/20.
//  Copyright © 2020 MOHAB. All rights reserved.
//

import UIKit
import FSPagerView
import FirebaseDynamicLinks
import GoogleMaps
import GooglePlaces
import Toast_Swift

class AdsVC: UIViewController , FSPagerViewDataSource , FSPagerViewDelegate , UITextViewDelegate {
    
//MARK:Outlets
    
    @IBOutlet weak var ScrollBackGround: UIView!
    @IBOutlet var MainBackRound: UIView!
    @IBOutlet weak var buttomView: UIView!
    
    @IBOutlet weak var collectionViewHight: NSLayoutConstraint!
    @IBOutlet weak var tableviewhight: NSLayoutConstraint!
    @IBOutlet weak var PromotionalPhotoHight: NSLayoutConstraint!
    @IBOutlet weak var MainView: UIScrollView!
    
    
    @IBOutlet weak var AdvNumber: UILabel!
    @IBOutlet weak var PagerView: FSPagerView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var StarAdsView: UIView!
    @IBOutlet weak var imgVedio: UIImageView!
    @IBOutlet weak var SaveBtn: UIButton!
    
    @IBOutlet weak var SarLbl: UILabel!
    @IBOutlet weak var DetailsView: UIView!
    @IBOutlet weak var AdvTitle: UILabel!
    @IBOutlet weak var AdvPrice: UILabel!
    @IBOutlet weak var AdvDistance: UILabel!
    @IBOutlet weak var AdvViewer: UILabel!
    @IBOutlet weak var AdvDate: UILabel!
    
    @IBOutlet weak var FeatureView: UIView!
    @IBOutlet weak var FueatureTitle: UIStackView!
    @IBOutlet weak var AdvDescription: UILabel!
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var PromotionalPhotoBtn: UIButton!
    
    @IBOutlet weak var LocationView: UIView!
    @IBOutlet weak var AdvAddress: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var MapIcon: UIImageView!

    @IBOutlet weak var OwnerView: UIView!
    @IBOutlet weak var OwnerName: UILabel!
    @IBOutlet weak var OwnerAdsCount: UILabel!
    @IBOutlet weak var ChatView: UIView!
    @IBOutlet weak var WatsAppView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    @IBOutlet weak var VisitorView: UIView!
    @IBOutlet weak var Lable: UILabel!
    
    @IBOutlet weak var CommemtView: UIView!
    @IBOutlet weak var AdvCommentCount: UILabel!
    @IBOutlet weak var CommentsTableView: UITableView!
    @IBOutlet weak var addCommentBtn: UIButton!
    @IBOutlet weak var ShowMoreBtn: UIButton!
    @IBOutlet weak var NoCommentLable: UILabel!
    
    @IBOutlet weak var EditView: UIView!
    @IBOutlet weak var starImage: UIImageView!
    

    @IBOutlet weak var adNomberLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var featureLbl: UILabel!
    @IBOutlet weak var goNowBnt: UIButton!
    @IBOutlet weak var adviserLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var adviserBtn: UIButton!
    @IBOutlet weak var KmLbl: UILabel!
    @IBOutlet weak var AdviserNomLbl: UILabel!
    @IBOutlet weak var deleteLbl: UILabel!
    @IBOutlet weak var disableLbl: UILabel!
    @IBOutlet weak var editLbl: UILabel!
    @IBOutlet weak var specialLbl: UILabel!
    

    
    var is_Success = true
    
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
    
    private func styleGoogleMaps(){
            
            do {
             
                if let StyleUrl = Bundle.main.url(forResource: "style", withExtension: "json")
                {
                    mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: StyleUrl)
                    
                }else {
                    
                    print("(unable to find sryle file")
                    
                }
                
            }catch {
                
                
                print("failed to load json")
            }
            
            
        }
    
    //pram
    
    var CurrentPage = 1
    var lastPage = 1
    
    var isActive = true
    var CommentState = false
    
    var AdData : ShowAdData?
    var media = [Adv_media]()
    var ComentData = false
    
    var AdId = ""
    var user_id = ""
    var CommentArray : [Comments_data] = []
    var FeatureArray : [Adv_specifications] = []
    var FeatureData = false
    var checkBox = false
  
    
    var lang = ""
    var lat = ""
    
    var WhatsApp = ""
    var isHome = 0
    
    var phoneNumber = ""
    var callState = ""
    
    var whatsNumber = ""
    var whatsState = ""
    
    var CommentCount = 0
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        EditView.isHidden = true
        MainView.isHidden = true
        CurrentPage = 1
        lastPage = 1
        CommentArray.removeAll()
        ShowComment()
        getAdData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SarLbl.text = "SAR".localized
        deleteLbl.text = "Delete".localized
        disableLbl.text = "Disable".localized
        editLbl.text = "Edit".localized
        specialLbl.text = "Special".localized
        adNomberLbl.text = "Ad number".localized
        detailsLbl.text = "Description".localized
        featureLbl.text = "Specifications".localized
        addressLbl.text = "Address".localized
        adviserLbl.text = "Advertiser".localized
        commentLbl.text = "Comments".localized
        addCommentBtn.setTitle("Add comment".localized, for: .normal)
        ShowMoreBtn.setTitle("Show more".localized, for: .normal)
        goNowBnt.setTitle("Go now".localized, for: .normal)
        adviserBtn.setTitle("Advertiser page".localized, for: .normal)
        KmLbl.text = "Km".localized
        AdviserNomLbl.text = "ads".localized
        
        styleGoogleMaps()

        setShadow(view: DetailsView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: FeatureView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: LocationView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: OwnerView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: CommemtView, width: Int(0.1), height: Int(0.1), shadowRadius: 1, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        setShadow(view: EditView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        AdvNumber.text = "\(AdId)"
        
        lang = AdData?.advertisement_details?.adv_latitude ?? ""
        lat = AdData?.advertisement_details?.adv_latitude ?? ""
        
        ScrollBackGround.backgroundColor = UIColor(hexString: "E5F2F7")
        MainBackRound.backgroundColor = UIColor(hexString: "E5F2F7")
        
        NoCommentLable.text = "No Commentns".localized
        
        MainView.isHidden = true
        
        PagerView.addSubview(imgVedio)
        
        if DynamicLinkModel.isDynamic {
            self.AdId = DynamicLinkModel.Product_id
        }
        
        tabBarController?.tabBar.isHidden = true
        
        pageControl.currentPage = 0
        
        CommentsTableView.delegate = self
        CommentsTableView.dataSource = self
        
        CommentsTableView.RegisterNib(cell: CommentWithReplayCell.self)
        
        CommentsTableView.RegisterNib(cell: CommentCellTableViewCell.self)
        
        CommentsTableView.RegisterNib(cell: ReplayCommentCell.self)
        
        
       
    
        
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.delegate = self
        DetailsCollectionView.RegisterNib(cell: ShowDetailsCell.self)
        DetailsCollectionView.flipX()
        
        PagerView.dataSource = self
        PagerView.delegate = self
        PagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        PagerView.isInfinite = false
        PagerView.addSubview(pageControl)
        PagerView.addSubview(StarAdsView)
        PagerView.itemSize = CGSize(width: PagerView.frame.size.width, height: PagerView.frame.size.height)
        PagerView.transformer = FSPagerViewTransformer(type: .linear)
        
        PagerView.automaticSlidingInterval = 5.0
        mapView.addSubview(MapIcon)
        
        VisitorView.isHidden = true
        
        if Helper.getapitoken() == nil {
            
            VisitorView.isHidden = false
            
            let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 16), NSAttributedString.Key.foregroundColor : Colors.DarkBlue]
            
            let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Tajawal-Bold", size: 16), NSAttributedString.Key.foregroundColor : UIColor(hexString: "#39CDEE")]
            
            let attributedString1 = NSMutableAttributedString(string: "قم بتسجيل الدخول لتتمكن من ", attributes:attrs1 as [NSAttributedString.Key : Any])
            
            let attributedString2 = NSMutableAttributedString(string: "التواصل مع المعلن", attributes:attrs2 as [NSAttributedString.Key : Any])
            
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

    func CreateMarker(Lat : Double , lng : Double){

        let cameraPosition = GMSCameraPosition.camera(withLatitude: Lat, longitude: lng, zoom: 15.0)
        mapView.animate(to: cameraPosition)
        view.unlock()
        
    }
    
//MARK: - PagerView Controller
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
        
        self.pageControl.currentPage = index
        
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
        
        print(DynamicLinkModel.isDynamic , is_Success )
        if DynamicLinkModel.isDynamic || is_Success {
            DynamicLinkModel.isDynamic = false
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
            
        }
        
        if isHome == 1 {
            navigationController?.popToViewController(ofClass: HomeVC.self)
            tabBarController?.tabBar.isHidden = false
            isHome = 0
        }
        navigationController?.popViewController(animated: true)
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
    
    
    
    @IBAction func SaveAvtion(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
        
        AddToFavourite(advertisement_id: AdId)
        
        if checkBox == false{
            SaveBtn.setImage(#imageLiteral(resourceName: "save_white-1"), for: .normal)
            checkBox = true
            
        }else{
            SaveBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
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
            
            let shareText = "\(self.AdvTitle.text ?? "")" + "\n" + "\(url)"
            
            print(shareText)
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
        print(AdData?.advertisement_details?.adv_promotional_image ?? "")
        
        vc.image = AdData?.advertisement_details?.adv_promotional_image ?? ""
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    
    
    @IBAction func PhoneCallAction(_ sender: Any) {
        
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
    
    @IBAction func ChatAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Chat, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "chatVC") as! chatVC
        
        vc.chat_type_id = self.AdId
        vc.chat_type = "advertisement"
        vc.isSubView = 1
        // present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func OwnerProfile(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: BusinessAds, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "UserProfileVC") as!UserProfileVC
        vc.User_id = "\(AdData?.advertisement_details?.adv_advertiser_id ?? 0)"
        vc.User_Name = AdData?.advertisement_details?.adv_advertiser_name ?? ""
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func AdvOnMapAction(_ sender: Any) {
        
        UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(Double(AdData?.advertisement_details?.adv_latitude ?? "") ?? 0.0),\(Double(AdData?.advertisement_details?.adv_longitude ?? "") ?? 0.0)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
        
        
    }
    
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
           UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        } else {
            // add error message here
        }
    }
    
    
    @IBAction func LoginAction(_ sender: Any) {
        
        guard Helper.getapitoken() != nil else {
            
            alertSkipLogin()
            return
        }
    }
    
    
    @IBAction func ShoeMoreCommentAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: Home, bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
        vc.Adv_Id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
        vc.user_id = "\(AdData?.advertisement_details?.adv_advertiser_id ?? 0)"
        vc.statue = 1
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func StarAdsAction(_ sender: Any) {
        
        if AdData?.advertisement_details?.adv_special_status == "مميز" || AdData?.advertisement_details?.adv_special_status == "special" {
            let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdDetailsVC") as! StarAdDetailsVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
        } else {
            
            if AdData?.advertisement_details?.isWaiting == true {
                let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdDetailsVC") as! StarAdDetailsVC
                vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
                vc.isWaiting = true
                navigationController?.pushViewController(vc, animated: true)
                
            }else {
                let storyboard = UIStoryboard(name: StarAds, bundle: nil)
                let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdsVC") as! StarAdsVC
                vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
                navigationController?.pushViewController(vc, animated: true)
                
            }
      
        }
    }
    
    @IBAction func EditAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "EditAdsPopUpVC") as! EditAdsPopUpVC
        vc.deleget = self
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func DisableAdsAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "DisableAdsPopUpVC") as! DisableAdsPopUpVC
        vc.Ad_id = AdData?.advertisement_details?.adv_id ?? 0
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    
    @IBAction func DeletAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: MyProfile , bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "DeletePopUpVC") as! DeletePopUpVC
        vc.Ad_Id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
}

//MARK:-CollectionView Controller
extension AdsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
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

extension AdsVC : AddComent{
    func addNewComment(comment_text: String, state: Int, comment_id: String) {
        if state == 1 {
            AddReplay(comment_id: comment_id, CommentText: comment_text)
        }else{
            NewComment(Adv_id: "\(AdData?.advertisement_details?.adv_id ?? 0)", CommentText: comment_text)
        }
    }
}

//MARK:-API

extension AdsVC {
    
    func getAdData() {
        
        self.view.lock()
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-advertisement/\(AdId)") { (data : ShowAdModel?, String) in
            self.view.unlock()
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            } else {
                
                guard let data = data else {
                    return
                }
                
                if data.data?.advertisement_details?.adv_type == "business" {
                    
                    DynamicLinkModel.Product_id = self.AdId
                    DynamicLinkModel.isDynamic = true
                    guard let window = UIApplication.shared.keyWindow else{return}
                    let sb = UIStoryboard(name: Home, bundle: nil)
                    var vc : UIViewController
                    vc = sb.instantiateViewController(withIdentifier: "BusinessAdsDetailsVC")
                    window.rootViewController = vc
                    UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
                    
                }
                
                self.AdData = data.data
                
                self.CheckIfMyAds()
                
                self.ComentData = true
                
                
                
                self.media = data.data?.advertisement_details?.adv_media ?? []
                
                self.AdvNumber.text = "  \(data.data?.advertisement_details?.adv_id ?? 0)".localized
                self.AdvTitle.text = data.data?.advertisement_details?.adv_title ?? ""
                self.AdvPrice.text = data.data?.advertisement_details?.adv_price ?? ""
                self.AdvDistance.text = data.data?.advertisement_details?.adv_distance ?? ""
                print(data.data?.advertisement_details?.adv_distance ?? "")
                self.AdvViewer.text = data.data?.advertisement_details?.adv_views ?? ""
               
                self.AdvDate.text = "published ".localized + "\(data.data?.advertisement_details?.adv_custom_published_date ?? "") | " + "Modified ".localized + "\( data.data?.advertisement_details?.adv_custom_last_update_date ?? "")"
                
                self.AdvDescription.font = UIFont(name: "Tajawal-Regular", size: 16)
                self.AdvDescription.text = data.data?.advertisement_details?.adv_description ?? ""
                self.AdvAddress.text = data.data?.advertisement_details?.adv_location ?? ""
                self.OwnerName.text = data.data?.advertisement_details?.adv_advertiser_name ?? ""
                self.OwnerAdsCount.text = data.data?.advertisement_details?.adv_advertiser_advs_count ?? ""
                self.AdvCommentCount.text = "( \(data.data?.comments_count ?? "") )"
                self.CommentCount = Int(data.data?.comments_count ?? "") ?? 0
                
                self.phoneNumber = data.data?.advertisement_details?.adv_call_number ?? ""
                self.whatsNumber = data.data?.advertisement_details?.adv_whatsapp_number ?? ""
                
                self.callState = data.data?.advertisement_details?.adv_call_number_status ?? ""
                self.whatsState = data.data?.advertisement_details?.adv_whatsapp_number_status ?? ""
                
                self.FeatureArray = data.data?.advertisement_details?.adv_specifications ?? []
                    
                
                if data.data?.advertisement_details?.adv_specifications?.count ?? 0 == 0 {
                    self.FueatureTitle.isHidden = true
                }else{
                    self.FueatureTitle.isHidden = false
                }
                
                print(data.data?.advertisement_details?.adv_specifications?.count ?? 0)
                self.FeatureData = true
                
                
                self.PhoneView.isHidden = true
                self.WatsAppView.isHidden = true
                self.ChatView.isHidden = true
                
                if "\(data.data?.advertisement_details?.adv_advertiser_id ?? 0)" != Helper.getaUser_id()  {
                    self.ChatView.isHidden = false
                }
                
                if data.data?.advertisement_details?.adv_call_number_status == "active" {
                    self.PhoneView.isHidden = false
                    
                }
                

                if data.data?.advertisement_details?.adv_whatsapp_number_status == "active" {
                    self.WatsAppView.isHidden = false
                    
                }
                
                self.CreateMarker(Lat: Double(data.data?.advertisement_details?.adv_latitude ?? "") ?? 0.0, lng: Double(data.data?.advertisement_details?.adv_longitude ?? "") ?? 0.0)
                
                self.SaveBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                if data.data?.advertisement_details?.adv_is_favorite == true {
                    self.SaveBtn.setImage(#imageLiteral(resourceName: "save_white-1"), for: .normal)
                    self.checkBox = true
                } else {
                    self.SaveBtn.setImage(#imageLiteral(resourceName: "save"), for: .normal)
                    self.checkBox = false
                }
                
                self.StarAdsView.isHidden = true
                if data.data?.advertisement_details?.adv_special_status == "مميز" || data.data?.advertisement_details?.adv_special_status == "special" {
                    self.starImage.image = #imageLiteral(resourceName: "feature")
                    self.StarAdsView.isHidden = false
                } else {
                    self.starImage.image = #imageLiteral(resourceName: "feature-1")
                    self.StarAdsView.isHidden = true
                }
                
                if data.data?.advertisement_details?.isWaiting == true {
                    self.starImage.image = #imageLiteral(resourceName: "feature")
                    self.StarAdsView.isHidden = true
                }
                
                
                if data.data?.advertisement_details?.adv_promotional_image ?? "" == "" || data.data?.advertisement_details?.adv_promotional_image ?? "" == "https://askhail.com/public/images/no_image.png" {
                    self.PromotionalPhotoBtn.isHidden = true
                    self.PromotionalPhotoHight.constant = 0
                }else{
                    self.PromotionalPhotoBtn.isHidden = false
                    self.PromotionalPhotoHight.constant = 40
                }
                
               
                
               
                self.isActive = true
                
                self.pageControl.numberOfPages = self.media.count
                
                if self.media.count > 1 {
                    self.pageControl.isHidden = false
                }else{
                    self.pageControl.isHidden = true
                }
                
                
                
                if self.CommentArray.count > 0 {
                    self.CommentsTableView.reloadData()
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
                self.PagerView.reloadData()
                
                print(data)
                
                self.MainView.isHidden = false
                
            }
        }
    }
    
    
    func ShowComment() {
        DispatchQueue.main.async {
            self.CommentsTableView.removeNoDataLabel()
        }
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-advertisement-comments/\(AdId)?page=\(CurrentPage)") { (data : AllCommentModel?, String) in
            
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
                    self.CommentsTableView.reloadData()
                    self.CommentsTableView.isHidden = false
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
                self.PagerView.reloadData()
                
                self.isActive = true
                
                print(data)
            }
        }
    }
    func NewComment(Adv_id : String , CommentText : String) {
        
        let Parameters = [
            "advertisement_id" : Adv_id,
            "comment" : CommentText
        ] as [String : Any]
        
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-comment") { (data : SingleCommentModel?, String) in
            
            if String != nil {
                
//                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            } else {
                
                guard let data = data else {
                    return
                }

                print(data)
                
                self.CommentCount += 1
                self.AdvCommentCount.text = "( \(self.CommentCount) )"
                
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
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)advertisement-operations/remove-comment") { (data : Level_6_Model?, String) in
            
            self.view.unlock()
            
            if String != nil {

                
            }else {
                
                guard let data = data else {
                    return
                }
                

                self.CommentCount -= 1
                self.AdvCommentCount.text = "( \(self.CommentCount) )"
                
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
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/add-or-update-reply-on-comment") { (data : Level_6_Model?, String) in
            
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
    
    
    func AddToFavourite(advertisement_id : String) {
        
        let param = [
            "advertisement_id" : advertisement_id
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: param as [String : AnyObject] , url: "\(hostName)advertisement-operations/add-remove-favorite") { (data : ContactUsModel?, String) in
            
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
    
}

