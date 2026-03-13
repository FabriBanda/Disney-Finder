//
//  MockJSON.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 08/03/26.
//

import Foundation

struct MockJSON{
    static let mockJson:String = """
                {
                  "info": {
                    "count": 2,
                    "totalPages": 1,
                    "previousPage": null,
                    "nextPage": null
                  },
                  "data": [
                    {
                      "_id": 3942,
                      "name": "Lion (Mickey Mouse Works)",
                      "imageUrl": "https://example.com/lion.jpg",
                      "films": []
                    },
                    {
                      "_id": 4703,
                      "name": "Fantasia",
                      "imageUrl": "https://example.com/fantasia.jpg",
                      "films": ["Fantasia"]
                    }
                  ]
                }
        """
    
}
