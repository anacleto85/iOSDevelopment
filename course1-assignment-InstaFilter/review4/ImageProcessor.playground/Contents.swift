/*
Course Name: Swift Programming
HomeWork 1: InstaFilter Processor
Auther: Liangyi Fan
Email: fanliangyi1985@gmail.com
Country: USA
Date: 02/07/2016
*/

import UIKit
//*********** myImage class which can produce sample image instance ***********
public class myImage {
    var myRGBA :RGBAImage = RGBAImage(image: UIImage(named: "sample")!)!;
    var avgRed = 0;
    var avgGreen = 0;
    var avgBlue = 0;
    var avgAlpha = 0;
    
    init() {
        calculateAverage(myRGBA);
    }
   
    func calculateAverage(myRGBA:RGBAImage) {
        
        var totalRed = 0;
        var totalGreen = 0;
        var totalBlue = 0;
        
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x;
                var pixel = myRGBA.pixels[index];
                totalRed += Int(pixel.red);
                totalGreen += Int(pixel.green);
                totalBlue += Int(pixel.blue);
            }
        }
        
        let count = myRGBA.height * myRGBA.width;
        self.avgRed = totalRed/count;
        self.avgGreen = totalGreen/count;
        self.avgBlue = totalBlue/count;
    }
}

//***************** Image Filter struct ********************
public class ImageFilter {
      //Image Red Filter, increase Red part of the image;
      func ImageRedFilter(inout img:myImage, level: Int) -> UIImage {
        let myRGBA = img.myRGBA;
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x;
                var pixel = myRGBA.pixels[index];
                let redDiff = Int(pixel.red) - img.avgRed;
                if(redDiff > 0){
                    pixel.red = UInt8(max(0,min(255,img.avgRed + redDiff*level)));
                    myRGBA.pixels[index] = pixel;
                }
            }
        }
        return myRGBA.toUIImage()!;
    }
    
     //Image Blue Filter, increase Blue part of the image;
     func ImageBlueFilter(inout img:myImage, level: Int) -> UIImage {
        let myRGBA = img.myRGBA;
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x;
                var pixel = myRGBA.pixels[index];
                let blueDiff = Int(pixel.blue) - img.avgBlue;
                if(blueDiff > 0){
                    pixel.blue = UInt8(max(0,min(255,img.avgBlue + blueDiff*level)));
                    myRGBA.pixels[index] = pixel;
                }
            }
        }
        return myRGBA.toUIImage()!;
    }
    
    //Image Green Filter, increase Green part of the image;
     func ImageGreenFilter(inout img:myImage, level: Int) -> UIImage {
        let myRGBA = img.myRGBA;
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x;
                var pixel = myRGBA.pixels[index];
                let greenDiff = Int(pixel.green) - img.avgGreen;
                if(greenDiff > 0){
                    pixel.green = UInt8(max(0,min(255,img.avgGreen + greenDiff*level)));
                    myRGBA.pixels[index] = pixel;
                }
            }
        }
        return myRGBA.toUIImage()!;
    }
    
    // Image Alpha Filter,
    func ImageAlphaFilter(inout img:myImage, level: Int) -> UIImage {
        let myRGBA = img.myRGBA;
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x;
                var pixel = myRGBA.pixels[index];
                let redDiff = Int(pixel.red) - img.avgRed;
                if(redDiff > 0){
                    pixel.alpha = 0;
                    myRGBA.pixels[index] = pixel;
                }
            }
        }
        return myRGBA.toUIImage()!;
    }
    
    // Image contrast Filter
    func ImageContrastFilter(inout img:myImage, level: Int) -> UIImage {
        let myRGBA = img.myRGBA;
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x;
                var pixel = myRGBA.pixels[index];
                let redDiff = Int(pixel.red) - img.avgRed;
                if(redDiff > 0){
                    pixel.red = UInt8(max(0,min(255,img.avgRed + redDiff*level)));
    
                }
                
                let blueDiff = Int(pixel.blue) - img.avgBlue;
                if(blueDiff > 0){
                    pixel.blue = UInt8(max(0,min(255,img.avgBlue + blueDiff*level)));
                }
                
                let greenDiff = Int(pixel.green) - img.avgGreen;
                if(blueDiff > 0){
                    pixel.green = UInt8(max(0,min(255,img.avgGreen + greenDiff*level)));
                }
                myRGBA.pixels[index] = pixel;
            }
        }
        return myRGBA.toUIImage()!;
    }

}


//************ ImageProcessing Class ************
public class ImageProcessor {
    var myImageFilter = ImageFilter();
    
    public enum TypeofFilter :String {
        case RedFilter
        case BlueFilter
        case GreenFilter
        case AlphaFilter
        case ContrastFilter
        case PipeLineFilter
    }
    
    var inputImg : myImage;
    var whichFilter: TypeofFilter;
    var level : Int;
    
    init (inputImg : myImage, whichFilter: TypeofFilter, level: Int) {
        self.inputImg = inputImg;
        self.whichFilter = whichFilter;
        self.level = level;
    }
    
    func applyImageFilter() ->UIImage {
        switch self.whichFilter {
            case TypeofFilter.RedFilter:
                return myImageFilter.ImageRedFilter(&inputImg,level: self.level);
            case TypeofFilter.BlueFilter:
                return myImageFilter.ImageBlueFilter(&inputImg,level: self.level);
            case TypeofFilter.GreenFilter:
                return myImageFilter.ImageGreenFilter(&inputImg, level: self.level);
            case TypeofFilter.AlphaFilter:
                return myImageFilter.ImageAlphaFilter(&inputImg, level: self.level);
            case TypeofFilter.ContrastFilter:
                return myImageFilter.ImageContrastFilter(&inputImg, level: self.level);
            default:
                return applyPipeLineFilter();
        }
    }
    
    // apply predefined pipeline of filter;
    func applyPipeLineFilter () ->UIImage {
          myImageFilter.ImageRedFilter(&inputImg, level: self.level);
          myImageFilter.ImageBlueFilter(&inputImg, level: self.level);
          myImageFilter.ImageGreenFilter(&inputImg, level: self.level);
          myImageFilter.ImageAlphaFilter(&inputImg, level: self.level);
          return myImageFilter.ImageContrastFilter(&inputImg, level: self.level);
        
    }

}

//Red Filter Process;
var inputImgRed = myImage();
var imageRedProcessor = ImageProcessor(inputImg: inputImgRed, whichFilter: ImageProcessor.TypeofFilter.RedFilter, level: 2);
var outRedImg = imageRedProcessor.applyImageFilter();

//Blue Filter Process;
var inputImgBlue = myImage();
var imageBlueProcessor = ImageProcessor(inputImg: inputImgBlue, whichFilter: ImageProcessor.TypeofFilter.BlueFilter, level: 3);
var outBlueImg = imageBlueProcessor.applyImageFilter();

//Green Filter Process;
var inputImgGreen = myImage();
var imageGreenProcessor = ImageProcessor(inputImg: inputImgGreen, whichFilter: ImageProcessor.TypeofFilter.GreenFilter, level: 5);
var outGreenImg = imageGreenProcessor.applyImageFilter();


// Alpha Filter Process;
var inputImgAlpha = myImage();
var imageProcessorAlpha = ImageProcessor(inputImg: inputImgAlpha, whichFilter: ImageProcessor.TypeofFilter.AlphaFilter, level: 4);
var outAlphaImg = imageProcessorAlpha.applyImageFilter();


// Contrast Filter Process;
var inputImgContrast = myImage();
var imageProcessorContrast = ImageProcessor(inputImg: inputImgContrast, whichFilter: ImageProcessor.TypeofFilter.ContrastFilter, level: 4);
var outContrastImg = imageProcessorContrast.applyImageFilter();

// Pipeline Image Filter Process; RedFilter --> BlueFilter --> GreenFilter --> AlphaFilter --> ContrastFilter
var inputImgPipeLine = myImage();
var imagePipeLineProcessor = ImageProcessor(inputImg: inputImgPipeLine, whichFilter: ImageProcessor.TypeofFilter.PipeLineFilter, level:5);
var pipelineImg = imagePipeLineProcessor.applyImageFilter();







