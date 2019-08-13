//
//  VideoOrganizer.swift
//  Pipe
//
//  Created by Daniel Kim on 8/13/19.
//  Copyright © 2019 Daniel Kim. All rights reserved.
//

import Foundation

class VideoOrganizer  {
    init() {
        
    }
    
    func sortByCreator(videos: [Video]) -> [String:[Video]] {
        var targetDict = [String:[Video]]()
        for video in videos {
            let creator = video.creator

            if (targetDict.keys.contains(creator)) {
                targetDict[creator]?.append(video)
            } else {
                targetDict[creator] = [video]
            }
        }
        return targetDict
    }
    
    func sortByCategory(videos: [Video]) -> [String:[Video]] {
        var targetDict = [String:[Video]]()
        for video in videos {
            let category = video.category
            
            if (targetDict.keys.contains(category)) {
                targetDict[category]?.append(video)
            } else {
                targetDict[category] = [video]
            }
        }
        return targetDict
    }
}

