/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class Video: NSObject {
    let url: URL
    let thumbURL: URL
    let title: String
    let creator: String
    let category: String
    
    init(url: URL, thumbURL: URL, title: String, creator: String, category:String) {
        self.url = url
        self.thumbURL = thumbURL
        self.title = title
        self.creator = creator
        self.category = category
        super.init()
    }
  
  class func localVideos() -> [Video] {
    var videos: [Video] = []
    let names = ["newYorkFlip", "bulletTrain", "monkey", "shark"]
    let titles = ["New York Flip", "Bullet Train Adventure", "Monkey Village", "Robot Battles"]

    
    for (index, name) in names.enumerated() {
        let urlPath = Bundle.main.path(forResource: name, ofType: "mp4")!
        let url = URL(fileURLWithPath: urlPath)
        
        let thumbURLPath = Bundle.main.path(forResource: name, ofType: "png")!
        let thumbURL = URL(fileURLWithPath: thumbURLPath)
        
        let video = Video(url: url, thumbURL: thumbURL, title: titles[index], creator: "Daniel", category: "sample")
      videos.append(video)
    }
    return videos
  }
  
  class func allVideos() -> [Video] {
    var videos = localVideos()
    let videoURLString = "https://firebasestorage.googleapis.com/v0/b/lipe-253f9.appspot.com/o/video1.mp4?alt=media&token=e1314bd2-8e14-4e96-9d4e-fdcfee40d6c5"

    // Add one remote video
    if let url = URL(string: videoURLString) {
      let thumbURLPath = Bundle.main.path(forResource: "foxVillage", ofType: "png")!
      let thumbURL = URL(fileURLWithPath: thumbURLPath)
      
        let remoteVideo = Video(url: url, thumbURL: thumbURL, title: "キツネ村", creator: "Daniel", category: "sample")
      videos.append(remoteVideo)
    }
    
    return videos
  }
}

