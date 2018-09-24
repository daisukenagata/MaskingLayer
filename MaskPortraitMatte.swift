//
//  MaskDepthDataMap.swift
//  MaskingLayer
//
//  Created by 永田大祐 on 2018/09/23.
//

import ImageIO
import AVFoundation
import Photos
import UIKit

@available(iOS 12.0, *)
public class MaskPortraitMatte: NSObject {

    public func portraitMatte(imageV: UIImageView,vc: UIViewController) {

        let defo = UserDefaults.standard
        let url = defo.url(forKey: "url")
        var mattePixelBuffer: CVPixelBuffer?
        let maskingLayer = MaskLayer()

        guard let source = CGImageSourceCreateWithURL(url! as CFURL, nil) else { return }

        var matteData: [String : AnyObject]? {
            return CGImageSourceCopyAuxiliaryDataInfoAtIndex(source, 0, kCGImageAuxiliaryDataTypePortraitEffectsMatte) as? [String : AnyObject]
        }

        do {
            guard let matte = matteData else {
                maskingLayer.alertPortrait(views: vc)
                return
            }
            mattePixelBuffer = try AVPortraitEffectsMatte(fromDictionaryRepresentation: matte).mattingImage
            guard let pixelBuffer = mattePixelBuffer else { return }
            guard let image2 = UIImage(contentsOfFile: url!.path) else { return }
            guard let cgOriginalImage = image2.cgImage else { return }

            let orgImage = CIImage(cgImage: cgOriginalImage)
            let transform = CGAffineTransform (scaleX: orgImage.extent.width / CIImage(cvPixelBuffer: pixelBuffer).extent.size.width, y: orgImage.extent.height / CIImage(cvPixelBuffer: pixelBuffer).extent.size.height)
            let maskImage = CIImage(cvPixelBuffer: pixelBuffer).transformed(by: transform)
            
            let filter = CIFilter(name: "CIBlendWithMask")
            filter?.setValue(orgImage, forKey: kCIInputImageKey)
            filter?.setValue(maskImage, forKey: kCIInputMaskImageKey)

            guard let outputImage = filter?.outputImage else { return }
            imageV.image = UIImage(ciImage: outputImage)
            imageV.frame = CGRect(x: Margin.current.xOrigin, y: Margin.current.yOrigin, width: Margin.current.width, height: Margin.current.height)
        } catch {
            print(error)
        }
    }
}
