//
//  AdsAddPhotoVC.swift
//  AskHail
//
//  Created by Abdullah Tarek on 11/7/20.
//  Copyright © 2020 MOHAB. All rights reserved.

import UIKit
import AVFoundation
import PMAlertController
struct ChooseImage {
    var image : UIImage
    var  isVedio : Bool
    var seconds : Float64
}

class AdsAddPhotoVC: UIViewController {
    
    var selecte_image = 0
    var isHome = 0
    
    
    @IBOutlet weak var ImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var CoverImage: UIImageView!
    @IBOutlet weak var CoverImageBtn: UIButton!
    
    @IBOutlet weak var ConfirmBtn: UIButton!
    
    var vedioDataTets = NSData()
    
    var ImagesArray = [ChooseImage]()
    var VediosArray = [NSData]()
    var VedioDuration = [Int]()
    
    
    var isCoverImage = false
    var isCoverImage1 = 0
    
    var Ad_id = ""
    
    var section_ID = ""
    var subSection_ID = ""
    
    let Seconds = 0.0
    
    var haveVideo = false
    
    let imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImagesCollectionView.dataSource = self
        ImagesCollectionView.delegate = self
        imagePickerController.delegate = self
        ImagesCollectionView.RegisterNib(cell: ImageCell.self)
        
        setShadowButton(view: ConfirmBtn, width: 0, height: 5, shadowRadius: 5, shadowOpacity: 0.5, shadowColor: #colorLiteral(red: 0.7725490196, green: 0.8235294118, blue: 0.8862745098, alpha: 1))
        ConfirmBtn.setGradientTopToButtom(ColorTop: Colors.TopGradBtnColoer , ColorButtom: Colors.ButtomGradBtnColoer)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        
        if isHome == 0 {
            navigationController?.popViewController(animated: true)
        }
        else{
            guard let window = UIApplication.shared.keyWindow else{return}
            let sb = UIStoryboard(name: Home, bundle: nil)
            var vc : UIViewController
            vc = sb.instantiateViewController(withIdentifier: "HomeVC")
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .showHideTransitionViews, animations: nil, completion: nil)
        }
        
    }
    
    @IBAction func AddMoreImageAction(_ sender: Any) {
        isCoverImage = false
        isCoverImage1 = 0
        ChooseMedia()
    }
    
    
    
    
    @IBAction func CoverAction(_ sender: Any) {
        
        if CoverImage.image == nil {
            isCoverImage = true
            isCoverImage1 = 1
            ChooseMedia()
        }else{
            CoverImage.image = nil
            CoverImageBtn.setImage(#imageLiteral(resourceName: "add-1"), for: .normal)
        }
        
    }
    
    
    @IBAction func ConfirmAction(_ sender: Any) {
        
        uploadMedia()
        
    }
    
}

//MARK:CollectionView

extension AdsAddPhotoVC : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ImagesArray.count == 0 {
            return 1
            
        }else {
            
            return ImagesArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.CellImage.image = nil
        cell.cellBtn.setImage(#imageLiteral(resourceName: "add-1"), for: .normal)
        
        cell.VideotimeView.isHidden = true
        
        if ImagesArray.count > 0 {
            cell.CellImage.image = ImagesArray[indexPath.row].image
            cell.cellBtn.setImage(#imageLiteral(resourceName: "remove-1"), for: .normal)
            if ImagesArray[indexPath.row].isVedio == true {
                haveVideo = false
                var dur = Int(ImagesArray[indexPath.row].seconds)
                var Minutes = Int(dur/60)
                var Second = dur%60
                if Minutes < 9 , Second < 9 {
                    cell.VideoTime.text = "0\(Minutes):0\(Second)"
                    
                }else if Minutes < 9 , Second > 9 {
                    
                    cell.VideoTime.text = "0\(Minutes):\(Second)"
                }else if Minutes > 9 , Second > 9 {
                    
                    cell.VideoTime.text = "\(Minutes):\(Second)"
                }else {
                    cell.VideoTime.text = "\(Minutes):0\(Second)"
                    
                }
               
                cell.VideotimeView.isHidden = false
            }
        }
        
       
      
        
        
        cell.CellButton = {
            
            if (self.ImagesArray.count - 1) >= indexPath.row {
                
                if self.VediosArray.count - 1 >= indexPath.row {
                    self.VediosArray.remove(at: indexPath.row)
                    self.VedioDuration.remove(at: indexPath.row)
                }
                
                self.ImagesArray.remove(at: indexPath.row)
                self.ImagesCollectionView.deleteItems(at: [indexPath])
                self.ImagesCollectionView.reloadData()
                
            }else {
                self.isCoverImage = false
                self.isCoverImage1 = 0
                self.ChooseMedia()
                
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        isCoverImage = false
//        isCoverImage1 = 0
//        ChooseMedia()
        
        
    }
    
}

extension AdsAddPhotoVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width = (collectionView.frame.width - 32)/2
        let height = collectionView.frame.height
        
        return CGSize.init(width: width , height:height)
        
    }
}




//MARK:Select image
extension AdsAddPhotoVC {
    
    
    func ChooseMedia(){
        
        let alertVC = PMAlertController(title: "Chose media".localized, description: "you can add photo or video".localized, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "Camera".localized, style: .default, action: { () -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.imagePickerController.sourceType = .camera
                self.imagePickerController.allowsEditing = true
                self.present(self.imagePickerController, animated: true, completion: nil)}
            
        }))
        
        alertVC.addAction(PMAlertAction(title: "Gallery".localized, style: .default, action: { () in
            
            self.imagePickerController.sourceType = .photoLibrary
            self.imagePickerController.allowsEditing = true
            self.present(self.imagePickerController, animated: true, completion: nil)
            
        }))
        
        
        if isCoverImage1 == 1{
            
        } else {
            if self.VediosArray.count < 2  {
                
                alertVC.addAction(PMAlertAction(title: "Video".localized, style: .default, action: { () in
                    
                    self.haveVideo = true
                    self.showAllVideoToChose()
                    
                }))
            }
        }
        
        alertVC.addAction(PMAlertAction(title: "Cancel".localized, style: .cancel, action: { () in
            
        }))
        
        self.present(alertVC, animated: true, completion: nil)
        
        //        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        //        actionSheet.addAction(UIAlertAction(title: "Camera".localized, style: .default, handler: { (alert:UIAlertAction?)-> Void in
        //
        //            if UIImagePickerController.isSourceTypeAvailable(.camera){
        //                self.imagePickerController.sourceType = .camera
        //                self.imagePickerController.allowsEditing = true
        //                self.present(self.imagePickerController, animated: true, completion: nil)}
        //        }))
                
                
        //        actionSheet.addAction(UIAlertAction(title: "Gallery".localized, style: .default, handler: { (alert:UIAlertAction?)-> Void in
        //            self.imagePickerController.sourceType = .photoLibrary
        //            self.imagePickerController.allowsEditing = true
        //            self.present(self.imagePickerController, animated: true, completion: nil)
        //        }))
        //actionSheet.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler:nil))
        
    }
    
    @objc func showAllVideoToChose(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        present(imagePickerController, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            if mediaType  == "public.image" {
                print("Image Selected")
                var selectedImagefromPicker : UIImage?
                if let editedImage = info[.editedImage ] as? UIImage{
                    //send it
                    selectedImagefromPicker = editedImage
                    print("editedImage")
                }else if let originalImage = info[.originalImage ] as? UIImage{
                    selectedImagefromPicker = originalImage
                    print("originalImage")
                }
                if let selectedImage = selectedImagefromPicker{
                    if isCoverImage {
                        
                        CoverImage.image = selectedImage
                        self.CoverImageBtn.setImage(#imageLiteral(resourceName: "remove-1"), for: .normal)
                        
                    }else {
                        self.ImagesArray.append(ChooseImage(image: selectedImage, isVedio: false, seconds: 0.0))
                        self.ImagesCollectionView.reloadData()
                    }
                    
                }
            }
            
            if mediaType == "public.movie" {
                print("Video Selected")
                var videoURL: NSURL?
                videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
                print(videoURL)
                let asset = AVAsset(url: videoURL as! URL)
                
                let duration = asset.duration
                let durationTime = CMTimeGetSeconds(duration)
                print(duration)
                print(durationTime)
                
             
                if let videoURL = videoURL{
                    
                    
                    self.getThumbnailImageFromVideoUrl(url: videoURL as URL) { (thumbImage) in
                        
                        self.ImagesArray.insert(ChooseImage(image: thumbImage!, isVedio: true, seconds: durationTime), at: 0)
                        
                        self.ImagesCollectionView.reloadData()
                    }
                    
                    
                    if let videoURL = info[.mediaURL] as? NSURL {
                        if let data = NSData(contentsOf: videoURL as URL){
                            vedioDataTets = data
                            self.VediosArray.insert(vedioDataTets, at: 0)
                            var second = Int(durationTime)
                            
                            self.VedioDuration.insert(second, at: 0)
                            
                        }
                    }
                }
            }
            
            
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async { //1
            let asset = AVAsset(url: url) //2
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
            avAssetImageGenerator.appliesPreferredTrackTransform = true //4
            let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
                let thumbImage = UIImage(cgImage: cgThumbImage) //7
                DispatchQueue.main.async { //8
                    completion(thumbImage) //9
                }
            } catch {
                print(error.localizedDescription) //10
                DispatchQueue.main.async {
                    completion(nil) //11
                }
            }
        }
    }
}


//MARK: Upload To Services

extension AdsAddPhotoVC {
    
    func uploadMedia(){
        
        self.view.lock()
        
        var Param = ["advertisement_id": Ad_id]
        
        var images = [UIImage]()
        
        
        for item in ImagesArray {
            
            
            images.append(item.image)
        }
        
        var x = 0
        for item in VedioDuration {
            
            Param["media[\(x)]['video_duration']"] = "\(item)"
            x = x + 1
        }
        
        
        print(Param)
        
        
        ApiServices.instance.uploadImage(methodType: .post, parameters: Param as [String : AnyObject], url: "\(hostName)user-add-advertisement/level4-add-media", imagesArray: images, profileImage: CoverImage.image, commercial_register_image: nil, office_license_image: nil, id_image: nil, VediosArray: VediosArray, VediosDuration: VedioDuration){ (data : FixedPagesModel?, String) in
            
            self.view.unlock()
            
            if String != nil {
                
                self.showAlertWithTitle(title: "Error", message: String!, type: .error)
                self.view.unlock()
                
            }else {
                
                guard let data = data else {
                    return
                }
                print(data)
                
                let storyboard = UIStoryboard(name: AddAds, bundle: nil)
                let vc   = storyboard.instantiateViewController(withIdentifier: "AdsDetailsVC") as! AdsDetailsVC
                vc.Ad_id = self.Ad_id
                vc.section_ID = self.section_ID
                vc.subSection_ID = self.subSection_ID
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                
            }
        }
    }
    
}
