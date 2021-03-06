//
//  MaskingLayerModel.swift
//  MaskingLayer
//
//  Created by 永田大祐 on 2021/03/13.
//

import Foundation

public struct MaskingLayerModel {
    public var image: UIImage?
    public var originPosition: CGFloat
    public var windowSizeWidth: CGFloat
    public var windowSizeHeight: CGFloat
    public var windowColor: UIColor
    public var windowAlpha: CGFloat
    public var imageView: UIImageView
    public var windowFrameView: UIView?
    public var copyFrame: CGRect?
    public var defaltImageView: UIImageView
    public var maskGestureView: UIView?
}
