//
//  MaskExtension.swift
//  MaskingLayer
//
//  Created by 永田大祐 on 2019/08/24.
//

import Foundation


extension UIImage {
    func animatedGIF(data: Data,duration: Double) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        var speed = 0.0; speed = duration
        let count = CGImageSourceGetCount(source)
        var images: [UIImage] = []

        for i in 0..<count {

            guard let imageRef = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [String: Any] else { continue }
            guard let gifDictionary = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] else { continue }
            guard (gifDictionary[kCGImagePropertyGIFDelayTime as String] as? Double) != nil else { continue }
            
            let image = UIImage(cgImage: imageRef, scale: UIScreen.main.scale, orientation: .up)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            image.draw(in: CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height))
            
            let renderedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let renderedImage = renderedImage { images.append(renderedImage) }
        }
        return UIImage.animatedImage(with: images, duration: speed)
    }

    func ResizeUIImage(width : CGFloat, height : CGFloat)-> UIImage! {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height),true,0.0)
        
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

    func mask(image: UIImage?) -> UIImage {
        if let maskRef = image?.cgImage,
            let ref = cgImage,
            let mask = CGImage(maskWidth: maskRef.width,
                               height: maskRef.height,
                               bitsPerComponent: maskRef.bitsPerComponent,
                               bitsPerPixel: maskRef.bitsPerPixel,
                               bytesPerRow: maskRef.bytesPerRow,
                               provider: maskRef.dataProvider!,
                               decode: nil,
                               shouldInterpolate: false),
            let output = ref.masking(mask) {
            return UIImage(cgImage: output)
        }
        return self
    }

    func updateImageOrientionUpSide() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        }
        UIGraphicsEndImageContext()
        return UIImage()
    }
    
    func horizontalInversion() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, CGFloat(1.0))
        let imageRef = self.cgImage
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: size.width, y:  size.height)
        context?.scaleBy(x: -1.0, y: -1.0)
        context?.draw(imageRef!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let flipHorizontalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return flipHorizontalImage!
    }
}

extension CGImage {
    func resize(_ image: CGImage) -> CGImage? {
        let maxWidth: CGFloat = CGFloat(UIScreen.main.bounds.width)
        let maxHeight: CGFloat = CGFloat(UIScreen.main.bounds.height)

        guard let colorSpace = image.colorSpace else { return nil }
        guard let context = CGContext(data: nil, width: Int(maxWidth), height: Int(maxHeight), bitsPerComponent: image.bitsPerComponent, bytesPerRow: image.bytesPerRow, space: colorSpace, bitmapInfo: image.alphaInfo.rawValue) else { return nil }
        
        context.interpolationQuality = .high
        context.draw(image, in: CGRect(x: 0, y: 0, width: Int(maxWidth), height: Int(maxHeight)))
        
        return context.makeImage()
    }
}

extension CGPoint {
    func middle(_ from:CGPoint) -> CGPoint {
        return CGPoint(x: (self.x + from.x)/2, y: (self.y + from.y)/2)
    }
    
    func delta(_ from:CGPoint) -> CGPoint {
        return CGPoint(x: self.x - from.x, y: self.y - from.y)
    }
    
    func dotProduct(_ with:CGPoint) -> CGFloat {
        return self.x * with.x + self.y * with.y
    }
}


extension MaskPathElement {
    func addAsPolygon(to path:CGMutablePath) -> CGMutablePath {
        return add(to: path)
    }
}
