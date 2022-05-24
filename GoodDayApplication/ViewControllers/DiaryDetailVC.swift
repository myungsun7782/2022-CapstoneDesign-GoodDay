//
//  DiaryDetailVC.swift
//  GoodDayApplication
//
//  Created by myungsun on 2022/05/23.
//

import UIKit
import BSImagePicker
import Photos

class DiaryDetailVC: UIViewController {
    // Constant
    let NUM_PHOTO_MAX = 5
    
    // UICollectionView
    @IBOutlet weak var photoCollectionView: UICollectionView!

    // Variable
    var photoList = Array<UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI() {
        // UICollectionView
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(UINib(nibName: "AddPhotoCell", bundle: nil), forCellWithReuseIdentifier: "AddPhotoCell")
        photoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// UICollectionView
extension DiaryDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return photoList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPhotoCell", for: indexPath) as! AddPhotoCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photoImageView.image = photoList[indexPath.row]
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(tapDeleteButton(button:)), for: .touchUpInside)
        return cell
    }
    
    @objc private func tapDeleteButton(button: UIButton) {
        let index = button.tag
        photoList.remove(at: index)
        photoCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if photoList.count == NUM_PHOTO_MAX {
                // TODO: Show alert
                let alert = UIAlertController(title: nil, message: "사진은 최대 5장까지 등록할 수 있습니다.", preferredStyle: .alert)
                let confirmButton = UIAlertAction(title: "확인", style: .default)
                alert.addAction(confirmButton)
                present(alert, animated: true, completion: nil)
                return
            }
            
            let imagePicker = ImagePickerController()
            imagePicker.overrideUserInterfaceStyle = .light
            imagePicker.settings.selection.max = self.NUM_PHOTO_MAX-self.photoList.count
            imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
            imagePicker.settings.theme.selectionStyle = .numbered
            imagePicker.settings.theme.selectionFillColor = ColorManager.shared.getThemeMain()
            imagePicker.settings.theme.selectionStrokeColor = .white
            imagePicker.doneButton.tintColor = ColorManager.shared.getThemeMain()
            imagePicker.cancelButton.tintColor = .red

            presentImagePicker(imagePicker, select: { (asset) in
                   }, deselect: { (asset) in
                   }, cancel: { (assets) in
                   }, finish: { (assets) in
                       for asset in assets {
                           let image = self.getAssetThumbnail(asset: asset)
                    self.photoList.append(image)
                }
                self.photoCollectionView.reloadData()
            })
        } else {
            
        }
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        
        option.isNetworkAccessAllowed = true
        option.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info) -> Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
