//
//  ViewController.swift
//  CharacterRecognitionApp
//
//  Created by 黑田光 on 2020/06/20.
//  Copyright © 2020 Hikaru Kuroda. All rights reserved.
//

import UIKit
import CropViewController
import SwiftyTesseract

class TrimViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trimButton: UIButton!
    @IBOutlet weak var transButton: UIButton!
    @IBOutlet weak var goGoogleButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    var endPickeImage = false
    var endTriming = false
    var endOCR = false
    
    @IBAction func launchCamera(_ sender: Any) {
        let camera = UIImagePickerController.SourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(camera) {
            let picker = UIImagePickerController()
            picker.sourceType = camera
            picker.cameraFlashMode = .on
            picker.delegate = self
            self.present(picker, animated: true)
        }
    }
    
    @IBAction func trimImage(_ sender: Any) {
        let image = (imageView.image)!
        let cropVC = CropViewController(image: image)
        cropVC.delegate = self
        self.present(cropVC, animated: true, completion: nil)
    }
    
    @IBAction func convertText(_ sender: Any) {
        if let image = imageView.image {
            let swiftyTesseract = SwiftyTesseract(language: RecognitionLanguage.english)
            swiftyTesseract.performOCR(on: image) { (recognizedString) in
                guard let transText = recognizedString else { return }
                let editText = transText.remove(characterSet: .newlines)
                textView.text = editText
                endOCR = true
                check()
            }
        }
    }
    
    @IBAction func goGoogle(_ sender: Any) {
        tapCopy(copyText: textView.text)
    }
    
    @IBAction func tappedResetButton(_ sender: Any) {
        endPickeImage = false
        endTriming = false
        endOCR = false
        imageView.image = UIImage()
        textView.text = ""
        check()
    }
    
    func tapCopy(copyText: String) {
        UIPasteboard.general.string = copyText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        check()
    }
    
    func check() {
        trimButton.isEnabled = false
        trimButton.alpha = 0.3
        transButton.isEnabled = false
        transButton.alpha = 0.3
        goGoogleButton.isEnabled = false
        goGoogleButton.alpha = 0.3
        
        if(endPickeImage) {
            trimButton.isEnabled = true
            trimButton.alpha = 1
        }
        
        if(endPickeImage && endTriming) {
            transButton.isEnabled = true
            transButton.alpha = 1
        } else {
            
        }
        
        if(endPickeImage && endTriming && endOCR) {
            goGoogleButton.isEnabled = true
            goGoogleButton.alpha = 1
        }
    }
}

extension TrimViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        endPickeImage = true
        check()
        self.dismiss(animated: true, completion: nil)
    }
}

extension TrimViewController: CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        imageView.image = image
        cropViewController.dismiss(animated: true, completion: nil)
        endTriming = true
        check()
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true, completion: nil)
    }
}

extension String {
    /// StringからCharacterSetを取り除く
    func remove(characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }

    /// StringからCharacterSetを抽出する
    func extract(characterSet: CharacterSet) -> String {
        return remove(characterSet: characterSet.inverted)
    }
}
