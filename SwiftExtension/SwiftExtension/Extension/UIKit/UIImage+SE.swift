//
//  UIImage+MKAdd.swift
//  SwiftExtension
//
//  Created by Mike on 17/1/23.
//  Copyright © 2017年 Mike. All rights reserved.
//

import UIKit
import ImageIO
import Accelerate

public func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / 180.0;
}

public extension UIImage {
    public class func animatedImage(gifData: Data, scale: CGFloat = 2.0) -> UIImage? {
        guard let imageSource = CGImageSourceCreateWithData(gifData as CFData, nil)
            else { return nil }
        let count = CGImageSourceGetCount(imageSource)
        
        if count <= 1 {
            return UIImage(data: gifData, scale: scale)
        }
        
        var images: [UIImage] = []
        var duration: TimeInterval = 0
        for i in 0..<count {
            duration += imageSource.frameDurationAtIndex(i)
            
            let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil)
            let image = UIImage(cgImage: cgImage!, scale: scale, orientation: .up)
            images.append(image)
        }
        
        if duration == 0 {
            duration = 0.1 * Double(count)
        }
        
        return UIImage.animatedImage(with: images, duration: duration)
    }
    
//    public class func image(emoji: String, size: CGFloat = 2.0) {
//        
//    }
    
    public class func image(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {return nil}
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public class func image(size: CGSize, drawFunction: (CGContext) -> Swift.Void) -> UIImage? {
        if size.width <= 0 || size.height <= 0 {return nil}
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        drawFunction(context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public var hasAlphaChannel: Bool {
        guard let cgImage = self.cgImage else { return false}
        let alphaInfo = cgImage.alphaInfo
        switch alphaInfo {
        case .first, .last, .premultipliedFirst, .premultipliedLast:
            return true
        default:
            return false
        }
    }
    
}

// MARK: - Modify Image
public extension UIImage {
    public func draw(in: CGRect, contentMode: UIViewContentMode, clipToBounds: Bool) {
        let drawRect = CGRect.renderRect(canvas: `in`, renderSize: self.size, mode: contentMode)
        if drawRect.size.width == 0 || drawRect.size.height == 0 { return }
        if clipToBounds {
            if let context = UIGraphicsGetCurrentContext() {
                context.saveGState()
                context.addRect(`in`)
                context.clip()
                self.draw(in: drawRect)
                context.restoreGState()
            }
        } else {
            self.draw(in: drawRect)
        }
    }

    public func resizing(size: CGSize, contentMode: UIViewContentMode? = nil) -> UIImage? {
        if size.width <= 0 || size.height <= 0 { return nil }
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        if contentMode != nil {
            self.draw(in: rect, contentMode: contentMode!, clipToBounds: false)
        } else {
            self.draw(in: rect)
        }
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    
    public func cropping(to: CGRect) -> UIImage? {
        var rect = to
        rect.origin.x *= self.scale;
        rect.origin.y *= self.scale;
        rect.size.width *= self.scale;
        rect.size.height *= self.scale;
        guard rect.size.width > 0 && rect.size.height > 0, let cgImage = self.cgImage
            else { return nil }
        guard let croppedImage = cgImage.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: croppedImage, scale: self.scale, orientation: self.imageOrientation)
    }
    
    public func rendering(edgeInset: UIEdgeInsets, color: UIColor) -> UIImage? {
        var size = self.size
        size.width -= edgeInset.left + edgeInset.right
        size.height -= edgeInset.top + edgeInset.bottom
        if size.width <= 0 || size.height <= 0 { return nil }
        let rect = CGRect(x: -edgeInset.left, y: -edgeInset.top, width: self.size.width, height: self.size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.setFillColor(color.cgColor)
        let path = CGMutablePath()
        path.addRect(CGRect(origin: .zero, size: size))
        path.addRect(rect)
        context.addPath(path)
        context.fillPath(using: .evenOdd)
        
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func clippingRoundCorner(radius: CGFloat, borderWidth: CGFloat = 0, borderColor: UIColor? = nil, corners: UIRectCorner = .allCorners, borderLineJoin: CGLineJoin = .miter) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard  let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let rect = CGRect(origin: .zero, size: self.size)
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -rect.size.height)
        
        let minSize = min(self.size.width, self.size.height)
        if borderWidth < minSize * 0.5 {
            let path = UIBezierPath(roundedRect: rect.insetBy(dx: borderWidth, dy: borderWidth), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: borderWidth))
            path.close()
            
            context.saveGState()
            path.addClip()
            guard let cgImage = self.cgImage else {
                return nil
            }
            context.draw(cgImage, in: rect)
        }
        
        if let borderColor = borderColor, borderWidth < minSize * 0.5 && borderWidth > 0 {
            let strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale
            let strokeRect = rect.insetBy(dx: strokeInset, dy: strokeInset)
            let strokeRadius = radius > self.scale * 0.5 ? radius - self.scale * 0.5 : 0
            let path = UIBezierPath(roundedRect: strokeRect, byRoundingCorners: corners, cornerRadii: CGSize(width: strokeRadius, height: borderWidth))
            path.close()
            
            path.lineWidth = borderWidth
            path.lineJoinStyle = borderLineJoin
            borderColor.setStroke()
            path.stroke()
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    public func rotating(radians: CGFloat, fitSize: Bool) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let width = cgImage.width
        let height = cgImage.height
        let newRect = CGRect(x: 0, y: 0, width: width, height: height).applying(fitSize ? CGAffineTransform(rotationAngle: radians) : .identity)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: nil, width: Int(newRect.size.width), height: Int(newRect.size.height), bitsPerComponent: 8, bytesPerRow: Int(newRect.size.width) * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) else {
            return nil
        }
        
        context.setShouldAntialias(true)
        context.setAllowsAntialiasing(true)
        context.interpolationQuality = .high
        context.translateBy(x: +(newRect.size.width * 0.5), y: +(newRect.size.height * 0.5))
        context.rotate(by: radians)
        
        context.draw(cgImage, in: CGRect(x: -(Double(width) * 0.5), y: -(Double(height) * 0.5), width: Double(width), height: Double(height)))
        guard let imageRef = context.makeImage() else { return nil }
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
    }
    
    public var rotatingLeft90: UIImage? {
        return rotating(radians: degreesToRadians(90), fitSize: true)
    }

    public var rotatingRight90: UIImage? {
        return rotating(radians: degreesToRadians(-90), fitSize: true)
    }

    public var rotating180: UIImage? {
        return flipping(horizontal: true, vertical: true)
    }

    public var rotatingFlipVertical: UIImage? {
        return flipping(horizontal: false, vertical: true)
    }

    public var rotatingFlipHorizontal: UIImage? {
        return flipping(horizontal: true, vertical: false)
    }
    
    public func flipping(horizontal: Bool, vertical: Bool) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let width = cgImage.width
        let height = cgImage.height
        let bytesPerRow = width * 4
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue) else {
            return nil
        }
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let data = context.data else { return nil }
        
        var src = vImage_Buffer(data: data, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
        var dest = vImage_Buffer(data: data, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: bytesPerRow)
        if vertical {
            vImageVerticalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill));
        }
        if horizontal {
            vImageHorizontalReflect_ARGB8888(&src, &dest, vImage_Flags(kvImageBackgroundColorFill));
        }
        guard let imgRef = context.makeImage() else { return nil }
        return UIImage(cgImage: imgRef, scale: self.scale, orientation: self.imageOrientation)
    }
}

// MARK: - Image Effect
public extension UIImage {
    public func tinting(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let rect = CGRect(origin: .zero, size: self.size)
        color.set()
        UIRectFill(rect)
        self.draw(at: .zero, blendMode: .destinationIn, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public var grayscale: UIImage? {
        return bluring(radius: 0, tintColor: nil)
    }

    public var blurSoft: UIImage? {
        return bluring(radius: 60, tintColor: UIColor(white: 0.84, alpha: 0.36), saturation: 1.8)
    }
    
    public var blurLight: UIImage? {
        return bluring(radius: 60, tintColor: UIColor(white: 1.0, alpha: 0.3), saturation: 1.8)
    }

    public var blurExtraLight: UIImage? {
        return bluring(radius: 40, tintColor: UIColor(white: 0.97, alpha: 0.82), saturation: 1.8)
    }

    public var blurDark: UIImage? {
        return bluring(radius: 40, tintColor: UIColor(white: 0.11, alpha: 0.73), saturation: 1.8)
    }

    public func bluring(tintColor: UIColor) -> UIImage? {
        let effectColorAlpha = CGFloat(0.6)
        var effectColor = tintColor.copy() as! UIColor
        let componentCount = tintColor.cgColor.numberOfComponents
        
        if componentCount == 2 {
            var w: CGFloat = 0
            if tintColor.getWhite(&w, alpha: nil) {
                effectColor = UIColor(white: w, alpha: effectColorAlpha)
            }
        } else {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            
            if tintColor.getRed(&r, green: &g, blue: &b, alpha: nil) {
                effectColor = UIColor(red: r, green: g, blue: b, alpha: effectColorAlpha)
            }
        }

        return bluring(radius: 20, tintColor: effectColor, blendMode: .normal, saturation: -1.0, maskImage: nil)
    }
    
    public func bluring(radius: CGFloat, tintColor: UIColor?, blendMode: CGBlendMode = .normal, saturation: CGFloat = 0, maskImage: UIImage? = nil) -> UIImage? {
        guard self.size.width >= 1 && self.size.height >= 1,
            let cgImage = self.cgImage,
            maskImage != nil && maskImage?.cgImage == nil else {
            return nil
        }
        
        let hasBlur = radius > CGFloat(FLT_EPSILON)
        let hasSaturation = fabs(saturation - 1.0) > CGFloat(FLT_EPSILON)
        
        let size = self.size
        let rect = CGRect(origin: .zero, size: size)
        let scale = self.scale
        let opaque = false
        
        if !hasBlur && !hasSaturation {
            return merging(effectCGImage: cgImage, tintColor: tintColor, tintBlendMode: blendMode, maskImage: maskImage, opaque: opaque)
        }
        
        var effect = vImage_Buffer()
        var scratch = vImage_Buffer()
        
        let bitmapInfo = CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue
        var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil, bitmapInfo: .init(rawValue: bitmapInfo), version: 0, decode: nil, renderingIntent: .defaultIntent)
        
        guard vImageBuffer_InitWithCGImage(&effect, &format, nil, cgImage, vImage_Flags(kvImagePrintDiagnosticsToConsole)) != kvImageNoError else {
            return nil
        }
        guard vImageBuffer_Init(&scratch, effect.height, effect.width, format.bitsPerPixel, vImage_Flags(kvImageNoFlags)) != kvImageNoError else {
            return nil
        }
        
//        var input = UnsafePointer<vImage_Buffer>.init(&effect)
//        input.pointee = effect
//        var output = vImage_Buffer()
//        input = &effect
//        output = &scratch
        
        var input = effect
        var output = scratch
        if hasBlur {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            var inputRadius = radius * scale;
            if inputRadius - 2.0 < CGFloat(FLT_EPSILON) {inputRadius = 2.0}
            var radiusValue = floor((inputRadius * 3.0 * CGFloat(sqrt(2.0 * M_PI)) / 4 + 0.5) / 2)
            if radiusValue.truncatingRemainder(dividingBy: 2.0) != 1.0 {
                radiusValue += 1.0 // force radius to be odd so that the three box-blur methodology works.
            }
            var iterations: Int = 0
            if radius * scale < 0.5 {
                iterations = 1
            } else if radius * scale < 1.5 {
                iterations = 2
            } else {
                iterations = 3
            }
            let tempSize = vImageBoxConvolve_ARGB8888(&input, &output, nil, 0, 0, UInt32(radiusValue), UInt32(radiusValue), nil, vImage_Flags(kvImageGetTempBufferSize | kvImageEdgeExtend));
            let temp = UnsafeMutableRawPointer.allocate(bytes: tempSize, alignedTo: 0)
            for _ in 0..<iterations {
                vImageBoxConvolve_ARGB8888(&input, &output, temp, 0, 0, UInt32(radiusValue), UInt32(radiusValue), nil, vImage_Flags(kvImageEdgeExtend))
                (input, output) = (output, input)
            }
            free(temp);
        }
        
        if hasSaturation {
            // These values appear in the W3C Filter Effects spec:
            // https://dvcs.w3.org/hg/FXTF/raw-file/default/filters/Publish.html#grayscaleEquivalent
            let s = saturation
            let matrixFloat: [CGFloat] = [
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,                    1,
            ]
            let divisor: Int32 = 256
            let matrixSize = MemoryLayout<[CGFloat]>.size(ofValue: matrixFloat) / MemoryLayout<CGFloat>.size(ofValue: matrixFloat[0])
            var matrix = [Int16](repeating: 0, count: matrixSize)
            for i in 0..<matrixSize {
                matrix[i] = Int16(round(matrixFloat[i] * CGFloat(divisor)))
            }
            vImageMatrixMultiply_ARGB8888(&input, &output, matrix, divisor, nil, nil, vImage_Flags(kvImageNoFlags))
            (input, output) = (output, input)
        }
        func callback(userData: UnsafeMutableRawPointer?, buf_data: UnsafeMutableRawPointer?) {
            free(buf_data)
        }
        
        var effectCGImage: CGImage!
        effectCGImage = vImageCreateCGImageFromBuffer(&input, &format, callback, nil, vImage_Flags(kvImageNoAllocate), nil) as! CGImage
        if effectCGImage == nil {
            effectCGImage = vImageCreateCGImageFromBuffer(&input, &format, nil, nil, vImage_Flags(kvImageNoFlags), nil) as! CGImage
            free(input.data)
        }
        free(output.data)
        return merging(effectCGImage: effectCGImage, tintColor: tintColor, tintBlendMode: blendMode, maskImage: maskImage, opaque: opaque)
    }
    
    public func merging(effectCGImage: CGImage, tintColor: UIColor?, tintBlendMode: CGBlendMode, maskImage: UIImage?, opaque: Bool) -> UIImage? {
        let hasTint = tintColor != nil && tintColor!.cgColor.alpha > CGFloat(FLT_EPSILON)
        let hasMask = maskImage != nil
        let size = self.size
        let rect = CGRect(origin: .zero, size: size)
        let scale = self.scale;
        
        if !hasTint && !hasMask {
            return UIImage(cgImage: effectCGImage)
        }
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0, y: -size.height)
        if hasMask {
            guard let cgImage = self.cgImage, let maskCGImage = maskImage?.cgImage else {
                return nil
            }
            context.draw(cgImage, in: rect)
            context.saveGState()
            context.clip(to: rect, mask: maskCGImage)
        }
        context.draw(effectCGImage, in: rect)
        if hasTint {
            guard let tintColor = tintColor else {
                return nil
            }
            context.saveGState()
            context.setBlendMode(tintBlendMode)
            context.setFillColor(tintColor.cgColor)
            context.fill(rect)
            context.restoreGState()
        }
        if hasMask {
            context.restoreGState()
        }
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
    
}

public extension CGImageSource {
    public func frameDurationAtIndex(_ index: Int) -> TimeInterval {
        let cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(self, index, nil)
        
        let frameProperties = cfFrameProperties as! NSDictionary;
        let gifProperties = frameProperties[kCGImagePropertyGIFDictionary] as! NSDictionary
        var frameDuration: TimeInterval = 0.1
        let delayTimeUnclampedProp = gifProperties[kCGImagePropertyGIFUnclampedDelayTime] as? NSNumber
        if let delay = delayTimeUnclampedProp {
            frameDuration = delay.doubleValue
        } else {
            if let delayTimeProp = gifProperties[kCGImagePropertyGIFDelayTime] as? NSNumber {
                frameDuration = delayTimeProp.doubleValue
            }
        }
        
        // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
        // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
        // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
        // for more information.
        
        if frameDuration < 0.011 {
            frameDuration = 0.100
        }
        return frameDuration;
    }
}

public extension CGRect {
    public static func renderRect(canvas: CGRect, renderSize: CGSize, mode: UIViewContentMode) -> CGRect {
        var rect = canvas.standardized
        var size = CGSize.zero
        size.width = fabs(renderSize.width)
        size.height = fabs(renderSize.height)
        let center = CGPoint(x: rect.midX, y: rect.minY)
        switch mode {
        case .scaleAspectFit, .scaleAspectFill:
            if rect.size.width < 0.01 || rect.size.height < 0.01 ||
                size.width < 0.01 || size.height < 0.01 {
                rect.origin = center
                rect.size = .zero
            } else {
                var scale: CGFloat = 0
                if mode == .scaleAspectFit {
                    if size.width / size.height < rect.size.width / rect.size.height {
                        scale = rect.size.height / size.height
                    } else {
                        scale = rect.size.width / size.width
                    }
                } else {
                    if size.width / size.height < rect.size.width / rect.size.height {
                        scale = rect.size.width / size.width
                    } else {
                        scale = rect.size.height / size.height
                    }
                }
                size.width *= scale
                size.height *= scale
                rect.size = size
                rect.origin = CGPoint(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5)
            }
        case .center:
            rect.size = size
            rect.origin = CGPoint(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5)
        case .top:
            rect.origin.x = center.x - size.width * 0.5
            rect.size = size
        case .bottom:
            rect.origin.x = center.x - size.width * 0.5
            rect.origin.y += rect.size.height - size.height
            rect.size = size
        case .left:
            rect.origin.y = center.y - size.height * 0.5
            rect.size = size
        case .right:
            rect.origin.y = center.y - size.height * 0.5
            rect.origin.x += rect.size.width - size.width
            rect.size = size
        case .topLeft:
            rect.size = size
        case .topRight:
            rect.origin.x += rect.size.width - size.width
            rect.size = size
        case .bottomLeft:
            rect.origin.y += rect.size.height - size.height
            rect.size = size
        case .bottomRight:
            rect.origin.x += rect.size.width - size.width
            rect.origin.y += rect.size.height - size.height
            rect.size = size
        case .scaleToFill, .redraw:
            break
        }
        return rect
    }
}

public extension Data {
    public var isAnimatedGIF: Bool {
        if self.count < 16 { return false }
        let pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: 4)
        self.copyBytes(to: pointer, count: 4)
        // http://www.w3.org/Graphics/GIF/spec-gif89a.txt
        guard pointer[0].isEqualTo(char: "G"),
        pointer[1].isEqualTo(char: "I"),
        pointer[2].isEqualTo(char: "F")
        else { return false}
        
        guard let source = CGImageSourceCreateWithData(self as CFData, nil) else {
            return false
        }
        return CGImageSourceGetCount(source) > 1
    }
}
