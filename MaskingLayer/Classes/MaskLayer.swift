//
//  MaskLayer.swift
//  MaskingLayer
//
//  Created by daisukenagata on 2018/08/04.
//  Copyright © 2018年 daisukenagata. All rights reserved.
//

import UIKit

public class MaskLayer: NSObject {

    open var convertPath = CGMutablePath()
    open var path = CGMutablePath()
    open var clipLayer = CAShapeLayer()
    open var maskClor = UIColor()


    public override init() {
        maskClor = .maskWhite
        clipLayer.backgroundColor = UIColor.clear.cgColor
        clipLayer.name = "clipLayer"
        clipLayer.strokeColor = UIColor.white.cgColor
        clipLayer.fillColor = UIColor.clear.cgColor
        clipLayer.lineWidth = 1
    }

    public func maskConvertPointFromView(viewPoint: CGPoint,view: UIView, imageView: UIImageView,bool: Bool) {
        clipLayer.path = path

        if bool ==  true{
            convertPath.move(to: CGPoint(x: convertPointFromView(viewPoint, view: view, imageView: imageView).x, y: convertPointFromView(viewPoint, view: view, imageView: imageView).y))
        } else {
            convertPath.addLine(to: CGPoint(x: convertPointFromView(viewPoint, view: view, imageView: imageView).x, y: convertPointFromView(viewPoint, view: view, imageView: imageView).y))
        }
    }

    public func maskPath(position: CGPoint) {
        clipLayer.isHidden = false
        path.move(to: CGPoint(x: position.x, y: position.y))
    }

    public func maskAddLine(position: CGPoint){
        path.addLine(to: CGPoint(x: position.x, y: position.y))
    }

    public func convertPath(convertLocation: CGPoint){
        convertPath.move(to: CGPoint(x: convertLocation.x, y: convertLocation.y))
    }

    public func mask(image: UIImage,convertPath: CGMutablePath)-> UIImage {
        clipLayer.isHidden = true
        return clipedMotoImage(image,convertPath:convertPath)
    }

    public func maskImage(color:UIColor, size: CGSize,convertPath:CGMutablePath)-> UIImage {
        return mask(image: image(color: color, size: size), convertPath: convertPath)
    }

    public func imageSet(view:UIView, imageView: UIImageView, name: String) {
        imageView.image =  UIImage(named: name)?.mask(image: imageView.image)
        imageView.image = imageView.image?.ResizeUIImage(width: view.frame.width, height: view.frame.height)
        imageView.frame = view.frame
        guard clipLayer.strokeEnd == 0 else {
            path = CGMutablePath()
            return
        }
    }

    public func imageSave(imageView: UIImageView, name: String) {
        let pngImageData = UIImagePNGRepresentation(imageView.image!)
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(name)
        do {
            try pngImageData!.write(to: fileURL)
            imageLoad(imageView: imageView, name: name)
        } catch {
        }
    }

    public func imageReSet(view:UIView, imageView: UIImageView, name: String) {
        imageView.image =  UIImage(named: name)
        imageView.image = imageView.image?.ResizeUIImage(width: view.frame.width, height: view.frame.height)
        imageView.frame = view.frame
        convertPath = CGMutablePath()
        path = CGMutablePath()
    }

    public func alertSave(views:UIViewController,imageView: UIImageView, name: String) {
        let alertController = UIAlertController(title: NSLocalizedString("BackGround Color", comment: ""), message: "", preferredStyle: .alert)
        let stringAttributes: [NSAttributedStringKey : Any] = [
            .foregroundColor : UIColor(red: 0/255, green: 136/255, blue: 83/255, alpha: 1.0),
            .font : UIFont.systemFont(ofSize: 22.0)
        ]
        let string = NSAttributedString(string: alertController.title!, attributes:stringAttributes)
        alertController.setValue(string, forKey: "attributedTitle")
        alertController.view.tintColor = UIColor(red: 0/255, green: 136/255, blue: 83/255, alpha: 1.0)


        let maskWhite = UIAlertAction(title: NSLocalizedString("maskWhite", comment: ""), style: .default) {
            action in
            alertController.dismiss(animated: true, completion: nil)
            self.maskClor = .maskWhite
            imageView.image = self.mask(image: self.image(color: .maskWhite, size: views.view.frame.size), convertPath: self.convertPath)
            self.imageSet(view: views.view, imageView: imageView, name: name)
        }
        let maskLightGray = UIAlertAction(title: NSLocalizedString("maskLightGray", comment: ""), style: .default) {
            action in
            alertController.dismiss(animated: true, completion: nil)
            self.maskClor = .maskLightGray
            imageView.image = self.mask(image: self.image(color: .maskLightGray, size: views.view.frame.size), convertPath: self.convertPath)
            self.imageSet(view: views.view, imageView: imageView, name: name)
        }
        let maskGray = UIAlertAction(title: NSLocalizedString("maskGray", comment: ""), style: .default) {
            action in
            alertController.dismiss(animated: true, completion: nil)
            self.maskClor = .maskGray
            imageView.image = self.mask(image: self.image(color: .maskGray, size: views.view.frame.size), convertPath: self.convertPath)
            self.imageSet(view: views.view, imageView: imageView, name: name)
        }
        let maskDarkGray = UIAlertAction(title: NSLocalizedString("maskDarkGray", comment: ""), style: .default) {
            action in
            alertController.dismiss(animated: true, completion: nil)
            self.maskClor = .maskDarkGray
            imageView.image = self.mask(image: self.image(color: .maskDarkGray, size: views.view.frame.size), convertPath: self.convertPath)
            self.imageSet(view: views.view, imageView: imageView, name: name)
        }
        let maskLightBlack = UIAlertAction(title: NSLocalizedString("maskLightBlack", comment: ""), style: .default) {
            action in
            alertController.dismiss(animated: true, completion: nil)
            self.maskClor = .maskLightBlack
            imageView.image = self.mask(image: self.image(color: .maskLightBlack, size: views.view.frame.size), convertPath: self.convertPath)
            self.imageSet(view: views.view, imageView: imageView, name: name)
        }
        alertController.addAction(maskWhite)
        alertController.addAction(maskLightGray)
        alertController.addAction(maskGray)
        alertController.addAction(maskDarkGray)
        alertController.addAction(maskLightBlack)
        views.present(alertController, animated: true, completion: nil)
    }
    private func imageLoad(imageView: UIImageView, name: String) {
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(name)

        let image = UIImage(contentsOfFile: fileURL.path)
        if image == nil {
            print("missing image at: \(fileURL)")
        } else {
            imageView.image! = image!
            path = CGMutablePath()
        }
    }

    private func image(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    private func clipedMotoImage(_ img: UIImage,convertPath: CGMutablePath) -> UIImage {
        let motoImage = img

        UIGraphicsBeginImageContextWithOptions((motoImage.size), false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()

        motoImage.draw(in: CGRect(x: 0, y: 0, width: (motoImage.size.width), height: (motoImage.size.height)))
        context?.addPath(convertPath)

        context?.setFillColor(UIColor.black.cgColor)
        context?.drawPath(using: CGPathDrawingMode.fillStroke)

        let reImage = UIGraphicsGetImageFromCurrentImageContext()
        context?.restoreGState()
        UIGraphicsEndImageContext()

        return reImage!
    }

    private func convertPointFromView(_ viewPoint: CGPoint,view: UIView, imageView: UIImageView) ->CGPoint {
        var imagePoint : CGPoint = viewPoint
        let imageSize = imageView.image?.size
        let viewSize = view.frame.size

        let ratioX : CGFloat = viewSize.width / imageSize!.width
        let ratioY : CGFloat = viewSize.height / imageSize!.height
        let scale : CGFloat = min(ratioX, ratioY)

        imagePoint.x -= (viewSize.width  - imageSize!.width  * scale) / 2
        imagePoint.y -= (viewSize.height - imageSize!.height * scale) / 2

        imagePoint.x /= scale
        imagePoint.y /= scale

        return imagePoint
    }
}

public extension UIColor {
    class var maskWhite: UIColor { return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) }
    class var maskLightGray: UIColor { return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) }
    class var maskGray: UIColor { return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) }
    class var maskDarkGray: UIColor { return #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) }
    class var maskLightBlack: UIColor { return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) }
}

public extension UIImage {
    func ResizeUIImage(width : CGFloat, height : CGFloat)-> UIImage!{
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
}
