//
//  MyAdsDetailsVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/12/20.
//  Copyright © 2020 MOHAB. All rights reserved.

import UIKit
import FSPagerView
import GoogleMaps
import GooglePlaces
import FirebaseDynamicLinks

class MyAdsDetailsVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate, UITextViewDelegate {
    
    var isSaved = false
    @IBOutlet weak var ContainView: UIView!
    
    @IBOutlet weak var mapVieww: GMSMapView!

    @IBOutlet weak var FeatuseTopTitle: UIStackView!
    @IBOutlet weak var ShowMoreComment: UIButton!
    @IBOutlet weak var imgVedio: UIImageView!
    @IBOutlet weak var NoCommentLabel: UILabel!
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var featureHeight: NSLayoutConstraint!
    @IBOutlet weak var featureBottom: NSLayoutConstraint!
    
    @IBOutlet weak var PromotionalPhotoBtn: UIButton!
    @IBOutlet weak var ScrollView: NSLayoutConstraint!
    
    @IBOutlet weak var PagerView: FSPagerView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var DetailsView: UIView!
    
    @IBOutlet weak var AddNumber: UILabel!
    @IBOutlet weak var StarAdsView: UIView!
        
    @IBOutlet weak var AdsTitle: UILabel!
    @IBOutlet weak var AdsPrice: UILabel!
    @IBOutlet weak var AdsDistance: UILabel!
    @IBOutlet weak var AdsViewNumber: UILabel!
    @IBOutlet weak var AdsDateAndTime: UILabel!
    @IBOutlet weak var AdNumber: UILabel!
    
    @IBOutlet weak var SpecialImageStar: UIImageView!
    
    @IBOutlet weak var AdsDescribe: UILabel!

    @IBOutlet weak var Address: UILabel!
    
    @IBOutlet weak var CommentView: UIView!
    @IBOutlet weak var CommentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var MainView: UIScrollView!
    
    
    @IBOutlet weak var NumberOfComment: UILabel!
    @IBOutlet weak var addCommentBtn: UIButton!
    
    @IBOutlet weak var MapView: UIView!
    @IBOutlet weak var CommentTableView: UITableView!
    @IBOutlet weak var AddCommentTV: UITextView!
    
    var phoneNumber = ""
    var whatsNumber = ""
    
    var isWating = false
    
    var CommentState = false

    var FeatureArray : [Adv_specifications] = []
    var FeatureData = false
    
    var AdData : ShowAdData?
    var media = [Adv_media]()
    var ComentData = false
    
    var AdId = ""
    var CommentArray : [Comments_data] = []
    var checkBox = false
    
    var lang = ""
    var lat = ""
    
    var WhatsApp = ""
    
    var whatsState = ""
    var callState = ""
    
    var User_id = 0
    var isActive = true
    var isMyAdv = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AdNumber.text = AdId
        
        AdsDistance.font = UIFont(name: "Tajawal-Regular", size: 16)
        
        NoCommentLabel.text = "No Commentns".localized
        tabBarController?.tabBar.isHidden = true
        
        setShadow(view: ContainView, width: 1, height: 1, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1))
        
        if DynamicLinkModel.isDynamic {
            
            self.AdId = DynamicLinkModel.Product_id
            
            
        }
        
        
        lang = AdData?.advertisement_details?.adv_latitude ?? ""
        lat = AdData?.advertisement_details?.adv_latitude ?? ""
        
        pageControl.currentPage = 0
        
        
        CommentViewHeight.constant = 0
        CommentView.alpha = 0
        
        CommentTableView.delegate = self
        CommentTableView.dataSource = self
        
        CommentTableView.RegisterNib(cell: ReplayCommentCell.self)
        CommentTableView.RegisterNib(cell: CommentWithReplayCell.self)
        
        PagerView.dataSource = self
        PagerView.delegate = self
        AddCommentTV.delegate = self
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
        
        self.CommentTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.DetailsCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.AdsDistance.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        
        if L102Language.currentAppleLanguage() == "en" {
            AddCommentTV.text = "Add New Comment"
            AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
        }else {
            AddCommentTV.font = UIFont(name: "Tajawal-Regular", size: 16)
            AddCommentTV.text = "اضافة تعليق جديد"
        }
        
        AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MainView.isHidden = true
        getAdData()
        CommentArray.removeAll()
        ShowComment()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if AddCommentTV.textColor == #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 0.5) {
            AddCommentTV.text = ""
            AddCommentTV.textColor = #colorLiteral(red: 0.01176470588, green: 0.2941176471, blue: 0.537254902, alpha: 1)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        CommentTableView.layer.removeAllAnimations()
        DetailsCollectionView.layer.removeAllAnimations()
        
        
        
        if PromotionalPhotoBtn.isHidden == true {
            featureHeight.constant = DetailsCollectionView.contentSize.height + 120 + AdsDescribe.intrinsicContentSize.height
            featureBottom.constant = 0
        }else{
            featureHeight.constant = DetailsCollectionView.contentSize.height + 180 +  AdsDescribe.intrinsicContentSize.height
            featureBottom.constant = 80
        }
        
        
        ScrollView.constant = CommentTableView.contentSize.height + 660 + featureHeight.constant + CommentViewHeight.constant + MapView.frame.height
        
        
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
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
    
    func CreateMarker(Lat : Double , lng : Double){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude:Lat, longitude: lng)
        //        marker.title = "Sydney"
        //        marker.snippet = "Australia"
        marker.map = mapVieww
        marker.icon = #imageLiteral(resourceName: "locationInAds")
        let cameraPosition = GMSCameraPosition.camera(withLatitude: Lat, longitude: lng, zoom: 15.0)
        mapVieww.animate(to: cameraPosition)
        
    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        if isMyAdv == 1{
            isMyAdv = 0
            navigationController?.popViewController(animated: true)
        }else {
        guard let window = UIApplication.shared.keyWindow else{return}
        let sb = UIStoryboard(name: Home, bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeVC")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        
       }
        
    }
    
    @IBAction func AdvOnMapAction(_ sender: Any) {
        let targetURL = "https://www.google.com/maps/@\(Double(AdData?.advertisement_details?.adv_latitude ?? "") ?? 0.0),\(Double(AdData?.advertisement_details?.adv_longitude ?? "") ?? 0.0),6z"
        openUrl(link: "\(targetURL)")
        
    }
    
    @IBAction func ShareAdsAction(_ sender: Any) {
        
        let longLinkUrl = "https://askHail.page.link/?link=5\(self.AdId)"
        
        DynamicLinkComponents.shortenURL(URL(string: longLinkUrl)!, options: nil) { shortUrl, warnings, error in
            if error != nil{
                let shareText = "\(self.AdsTitle.text ?? "")" + "\n" + longLinkUrl
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
    
    @IBAction func PromotionalPhotoAction(_ sender: Any) {
        
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
    
    @IBAction func GoNowAction(_ sender: Any) {
        UIApplication.shared.open(URL(string: "http://maps.google.com/maps?q=\(Double(AdData?.advertisement_details?.adv_latitude ?? "") ?? 0.0),\(Double(AdData?.advertisement_details?.adv_longitude ?? "") ?? 0.0)&zoom=14&views=traffic")!, options: [:], completionHandler: nil)
    }
    
    @IBAction func PhoneCallAcion(_ sender: Any) {
        
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
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func OtherProfileAction(_ sender: Any) {
        
    }
    
    @IBAction func SeeMoreCommentAction(_ sender: Any) {
        
        if isActive {
            print("Done")
            isActive = false
            
            
            if CurrentPage < lastPage {
                
                CurrentPage = CurrentPage + 1
                
                self.ShowComment()
                
            }
            self.CommentTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        }
        
    }
    
    @IBAction func StarAdsAction(_ sender: Any) {
        
        if AdData?.advertisement_details?.adv_special_status == "مميز" || AdData?.advertisement_details?.adv_special_status == "special" {
            let storyboard = UIStoryboard(name: MyProfile, bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "StarAdDetailsVC") as! StarAdDetailsVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
        } else {
            
            if isWating {
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
        //vc.deleget = self
        vc.modalPresentationStyle = .fullScreen
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func CancelCommentAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.CommentViewHeight.constant = 0
            self.CommentView.alpha = 0
            self.CommentTableView.reloadData()
            
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                
            }, completion: { _ in
                
                
            })
        })
        
    }
}


//MARK:-CollectionView Controller
extension MyAdsDetailsVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
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


//MARK:-TableView Contol

extension MyAdsDetailsVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Model = CommentArray[indexPath.row]
        
        if Model.comment_if_advertiser_reply_yet == true {
            
            let cell_2 = tableView.dequeue() as CommentWithReplayCell
            cell_2.CommentName.text = Model.comment_voter_name ?? ""
            cell_2.CommentText.text = Model.comment_text ?? ""
            cell_2.CommentTime.text = Model.comment_text_custom_date ?? ""
            cell_2.CommentReplayText.text = Model.comment_advertiser_reply ?? ""
            cell_2.CommentReplayTime.text = Model.comment_advertiser_reply_custom_date ?? ""
            cell_2.DeleteHight.constant = 0
            cell_2.Deletbtn.isHidden = true
            
//            cell_2.DeletComment = {
//
//            }
//
            return cell_2
            
        } else {
            
            let cell = tableView.dequeue() as ReplayCommentCell
            cell.CommentName.text = Model.comment_voter_name ?? ""
            cell.CommentText.text = Model.comment_text ?? ""
            cell.CommentTime.text = Model.comment_text_custom_date ?? ""
            
//            cell.ShowReplay = {
//                self.CommentTableView.reloadData()
//            }
//            
//            cell.CancelReplay = {
//                self.CommentTableView.reloadData()
//            }
//            
//            cell.AddReplay = {
//                if cell.AddCommentTV.text.isEmpty == true{
//                    self.navigationController?.view.makeToast( "enter comment first".localized)
//                }else{
//                    self.AddReplay(text: cell.AddCommentTV.text, id: "\(self.CommentArray[indexPath.row].comment_id ?? 0)", index: indexPath.row)
//                    self.CommentTableView.reloadData()
//                }
//            }
            
            return cell
        }
    }
}

//MARK:-Edit Section

extension MyAdsDetailsVC : selectEditSection {
    func SelectEdit(select: Int) {
        
        if select == 0 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditCategoryVC") as! EditCategoryVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
        }else if select == 1 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditImageVC") as! EditImageVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        else if select == 2 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditDetailsVD") as! EditDetailsVD
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            vc.CurrentFeatureArray = AdData?.advertisement_details?.adv_specifications ?? []
            navigationController?.pushViewController(vc, animated: true)
            
        }else if select == 3 {
            
            let storyboard = UIStoryboard(name: EditAds_Story , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "EditContactWayVC") as! EditContactWayVC
            vc.Ad_id = "\(AdData?.advertisement_details?.adv_id ?? 0)"
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
    }
}


//MARK:-API

extension MyAdsDetailsVC {
    
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
                
                self.AdData = data.data
                
                print(data.data?.advertisement_details?.adv_title)
                self.media = data.data?.advertisement_details?.adv_media ?? []
                
                self.isSaved = data.data?.advertisement_details?.adv_is_favorite ?? false
                self.AdNumber.text = "  \(data.data?.advertisement_details?.adv_id ?? 0)".localized
                self.AdsTitle.text = data.data?.advertisement_details?.adv_title ?? ""
                self.AdsPrice.text = data.data?.advertisement_details?.adv_price ?? ""
                self.AdsDistance.text = data.data?.advertisement_details?.adv_distance ?? ""
                self.AdsDescribe.text = data.data?.advertisement_details?.adv_distance ?? ""
                self.AdsViewNumber.text = data.data?.advertisement_details?.adv_views ?? ""
                self.AdsDateAndTime.text = "published ".localized + "\(data.data?.advertisement_details?.adv_custom_published_date ?? "") | " + "Modified ".localized + "\( data.data?.advertisement_details?.adv_custom_last_update_date ?? "")"
                self.AdsDescribe.font = UIFont(name: "Tajawal-Regular", size: 16)
                self.AdsDescribe.text = data.data?.advertisement_details?.adv_description ?? ""
                self.Address.text = data.data?.advertisement_details?.adv_location ?? ""
                self.NumberOfComment.text = "( \(data.data?.comments_count ?? "") )"
                
                self.FeatureArray = data.data?.advertisement_details?.adv_specifications ?? []
                
                if data.data?.advertisement_details?.adv_specifications?.count ?? 0 == 0 {
                    self.FeatuseTopTitle.isHidden = true
                }else{
                    self.FeatuseTopTitle.isHidden = false
                }
                
                self.FeatureData = true
                
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

                self.CreateMarker(Lat: Double(data.data?.advertisement_details?.adv_latitude ?? "0.0") ?? 0.0, lng: Double(data.data?.advertisement_details?.adv_longitude ?? "0.0") ?? 0.0)
                
                
                if data.data?.advertisement_details?.adv_promotional_image ?? "" == "" || data.data?.advertisement_details?.adv_promotional_image ?? "" == "https://askhail.com.sa/public/images/no_image.png" {
                    self.PromotionalPhotoBtn.isHidden = true
                }else{
                    self.PromotionalPhotoBtn.isHidden = false
                }
                
                self.StarAdsView.isHidden = true
                
                print(data.data?.advertisement_details?.adv_special_status)
                
                if data.data?.advertisement_details?.adv_special_status == "مميز" || data.data?.advertisement_details?.adv_special_status == "special" {
                    
                    self.SpecialImageStar.image = #imageLiteral(resourceName: "feature")
                    self.StarAdsView.isHidden = false
                } else {
                    self.SpecialImageStar.image = #imageLiteral(resourceName: "rate-1")
                    self.StarAdsView.isHidden = true
                }
                
                
                if data.data?.advertisement_details?.isWaiting == true {
                    self.SpecialImageStar.image = #imageLiteral(resourceName: "feature")
                    self.StarAdsView.isHidden = true
                    self.isWating = true
                    
                }
                
                self.ComentData = true
                self.MainView.isHidden = false
                self.DetailsCollectionView.reloadData()
                self.PagerView.reloadData()
                
                print(data)
                
            }
        }
    }
    
    
    func ShowComment() {
        
        ApiServices.instance.getPosts(methodType: .get, parameters: nil , url: "\(hostName)show-advertisement-comments/\(AdId)?page=\(CurrentPage)") { (data : AllCommentModel?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CurrentPage = data.data?.pagination?.current_page ?? 1
                self.lastPage = data.data?.pagination?.last_page ?? 1
                
                for item in data.data?.data ?? [] {
                    self.CommentArray.append(item)
                }
                
                self.NoCommentLabel.isHidden = false
                self.ShowMoreComment.isHidden = true
                
                if data.data?.data?.count ?? 0 > 0 {
                   
                    self.NoCommentLabel.isHidden = true
                }
                
                if data.data?.pagination?.has_more_pages == true {
                    self.ShowMoreComment.isHidden = false
                }
                
                if data.data?.data?.count ?? 0 == 0 {
                    self.NoCommentLabel.isHidden = false
                    self.CommentTableView.isHidden = true
                }else{
                    self.NoCommentLabel.isHidden = true
                    self.CommentTableView.isHidden = false
                }
                
                self.CommentTableView.reloadData()
                
                self.isActive = true
                
                print(data)
            }
        }
    }
    
    func AddReplay(text : String , id : String , index : Int) {
        
        let Parameters = [
            "comment_id" : id,
            "reply" : text
        ]
        
        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)user/add-or-update-reply-on-comment") { (data : Level_6_Model?, String) in
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                
            }else {
                
                guard let data = data else {
                    return
                }
                
                
                self.CommentArray[index].comment_if_advertiser_reply_yet = true
                self.CommentArray[index].comment_advertiser_reply = text
                
                self.NoCommentLabel.isHidden = true
                self.CommentTableView.isHidden = false
                
                self.CommentTableView.reloadData()
                
                
                print(data)
            }
        }
    }
    
    
//    func RemoveComment(id : Int) {
//        self.view.lock()
//        
//        let Parameters = [
//            "comment_id" : "\(id)",
//        ]
//        ApiServices.instance.getPosts(methodType: .post, parameters: Parameters as [String : AnyObject] , url: "\(hostName)advertisement-operations/remove-comment") { (data : Level_6_Model?, String) in
//            
//            self.view.unlock()
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
//                self.CommentTableView.reloadData()
//                
//                print(data)
//                
//            }
//        }
//    }
    
}
