//
//  ImagePickerViewController.swift
//  swiftTest
//
//  Created by 朱校明 on 2021/3/24.
//  Copyright © 2021 朱校明. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Then
import CoreServices
import Photos

class ImagePickerController: BaseViewController<ImagePickerViewModel> {

    let imagePickerView = R.nib.imagePickerView.firstView(owner: nil)!
    
    let imagePickerVC: UIImagePickerController = UIImagePickerController().then {
        $0.sourceType = .photoLibrary
        $0.mediaTypes = [kUTTypeMovie as String]
    }
    
    var selectImage: UIImage?
    var selectImageURL: NSURL?
    var selectVideoURL: NSURL?
    
//    let imageObserver: AnyObserver<UIImage>
//
//    let videoURLObserver: AnyObserver<NSURL> = AnyObserver { (event) in
//        switch event {
//        case .next(let url):
//            print(url)
//        default:
//            break
//        }
//    }
        
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerVC.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imagePickerView.snp.makeConstraints({ (make) in
            make.left.top.right.equalTo(view)
            make.height.equalTo(500)
        })
    }
    
    override func makeUI() {
        super.makeUI()
        view.addSubview(imagePickerView)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
//        let input = ImagePickerViewModel.Input(
//
//            imageTap: imagePickerView.imageBtn.rx.tap,
//            videoTap: imagePickerView.videoBtn.rx.tap,
//            transformTap: imagePickerView.transformBtn.rx.tap
//        )

//        let output = viewModel.transform(input)
//
//        output.image
//            .drive(imagePickerView.imageBtn.rx.image(for: .normal))
//            .disposed(by: rx.disposeBag)
        
        imagePickerView.imageBtn.rx.tap.subscribe { (event) in
            self.imagePickerVC.mediaTypes = [kUTTypeImage as String]
            self.present(self.imagePickerVC, animated: true, completion: nil)
        }.disposed(by: rx.disposeBag)
        
        imagePickerView.videoBtn.rx.tap.subscribe { (event) in
            self.imagePickerVC.mediaTypes = [kUTTypeMovie as String]
            self.present(self.imagePickerVC, animated: true, completion: nil)
        }.disposed(by: rx.disposeBag)
        
        imagePickerView.transformBtn.rx.tap.asObservable().filter{
            (self.selectImage != nil) && (self.selectVideoURL != nil)
        }.subscribe { (event) in

            print(PHPhotoLibrary.authorizationStatus().rawValue)
                  
            
            let imageURL = self.saveToDocument(self.selectImageURL!)
            let videoURL = self.saveToDocument(self.selectVideoURL!)
            
            print(imageURL.0, videoURL.0)
            
            PHPhotoLibrary.shared().performChanges {
                
                let request = PHAssetCreationRequest.forAsset()
                let options = PHAssetResourceCreationOptions.init()
//                request.addResource(with: .photo, data: imageURL.1, options: options)
//                request.addResource(with: .pairedVideo, data: videoURL.1, options: options)
                request.addResource(with: .photo, fileURL: imageURL.0, options: options)
                request.addResource(with: .pairedVideo, fileURL: videoURL.0, options: options)
            } completionHandler: { (result, error) in
                if result {
                    print("Save Success")
                }else {
                    print("Save Error:\(error)")
                }
            }
            
            UIImageWriteToSavedPhotosAlbum(UIImage(data: imageURL.1)!, self, #selector(self.saveImage(image:didFinishSavingWithError:contextInfo:)), nil)
            
//            PHLivePhoto.request(withResourceFileURLs: [imageURL.0, videoURL.0],
//                                placeholderImage: self.selectImage,
//                                targetSize: CGSize.zero,
//                                contentMode: .aspectFill) { (livePhoto, info) in
//
//                PHPhotoLibrary.shared().performChanges {
//
//                    let request = PHAssetCreationRequest.forAsset()
//                    let options = PHAssetResourceCreationOptions.init()
//                    request.addResource(with: .photo, data: imageURL.1, options: options)
//                    request.addResource(with: .pairedVideo, data: videoURL.1, options: options)
//                } completionHandler: { (result, error) in
//                    if result {
//                        print("Save Success")
//                    }else {
//                        print("Save Error:\(error)")
//                    }
//                }
//
//
//            }
        }.disposed(by: rx.disposeBag)
        
//        let imageObservable = Observable<UIImage>.create { [weak self] (observer) -> Disposable in
//            Disposables.create()
//        }.subscribe {imageObserver}
//        .disposed(by: rx.disposeBag)

    }
    
    func saveToDocument(_ filePath: NSURL) -> (URL,Data) {
        
        let data = try! Data.init(contentsOf: filePath.absoluteURL!)
        
        let fileManager = FileManager.default
        
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        if filePath.absoluteString?.hasSuffix("MOV") == true {
            
            path = path + "/1.MOV"
        }else if filePath.absoluteString?.hasSuffix("jpeg") == true {
            
            path = path + "/1.jpeg"
        }
        
        fileManager.createFile(atPath: path, contents: data, attributes: nil)
                
        return (URL.init(fileURLWithPath: path), data)
    }
    
    @objc func saveImage(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil{
                    
            print("保存失败")
            
        }else{
            
            print("保存成功")
            
        }

    }
    
    
}

extension ImagePickerController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true) {
                
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                self.imageObserver.onNext(image)
                self.selectImage = image;
            }
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
                self.selectImageURL = imageURL;
            }
            if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL {
                self.selectVideoURL = videoUrl
            }
        }
    }
}


func dismissViewController(viewController: UIViewController, animated: Bool) {
    
}

private func castOrThrow<T>(resultType: T.Type, object: Any) throws -> T {
    guard let resultValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return resultValue
}

class RxImagePickerDelegateProxy: RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {
    
    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }
    
    
}

extension Reactive where Base: UIImagePickerController {
    
    public var didCancel: Observable<()> {
        return delegate.methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:))).map { (_) -> () in }
    }
    
    public var didFinishPickMediaWithInfo: Observable<[UIImagePickerController.InfoKey: AnyObject]> {
        return delegate.methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:))).map { (a) in
            return try castOrThrow(resultType: Dictionary<UIImagePickerController.InfoKey, AnyObject>.self, object: a[1])
        }
    }
    
    
}
