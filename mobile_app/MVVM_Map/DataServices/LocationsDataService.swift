//
//

import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "薄扶林牧場",
            cityName: "香港",
            coordinates: CLLocationCoordinate2D(latitude: 22.2740, longitude: 114.2110),
            description: "薄扶林牧場建於1887年，原為牛奶公司的高級職員宿舍，現已轉型為博物館，展示牛奶公司的文物及薄扶林的歷史文化。",
            imageNames: [
                "pokfulam-farm",
            ],
            link: "https://www.pokfulamfarm.org.hk/"
        ),

        Location(
            name: "藍屋建築群",
            cityName: "灣仔",
            coordinates: CLLocationCoordinate2D(latitude: 22.2794, longitude: 114.1736),
            description: "藍屋建築群建於1920年代，是香港少數保存完好的舊式唐樓之一，曾是社區的中心，現在經過修復後成為文化和藝術空間。",
            imageNames: [
                "blue-house",
            ],
            link: "https://zh.wikipedia.org/wiki/%E8%97%8D%E5%B1%8B"
        ),

        Location(
            name: "大澳文物酒店",
            cityName: "大澳",
            coordinates: CLLocationCoordinate2D(latitude: 22.2424, longitude: 113.8685),
            description: "大澳文物酒店位於大澳海傍的石仔埗街，前身為1902年建成的舊大澳警署，經過活化成為酒店。該建築被評選為二級歷史建築，並於2013年獲得UNESCO亞太區文化遺產保護獎，是大嶼山大澳漁村中的文化地標。",
            imageNames: [
                "tai-o-heritage-hotel",
            ],
            link: "https://zh.wikipedia.org/wiki/%E5%A4%A7%E6%BE%B3%E6%96%87%E7%89%A9%E9%85%92%E5%BA%97"
        ),

        Location(
            name: "大館",
            cityName: "中環",
            coordinates: CLLocationCoordinate2D(latitude: 22.2819, longitude: 114.1587),
            description: "大館是一個歷史悠久的地標，由多座古蹟建築組成，展示了香港的歷史與文化。這裡定期舉辦藝術展覽和文化活動。",
            imageNames: [
                "tai-kwun",
            ],
            link: "https://zh.wikipedia.org/wiki/%E5%A4%A7%E9%A4%A8"
        ),

        Location(
            name: "牛棚藝術村",
            cityName: "九龍",
            coordinates: CLLocationCoordinate2D(latitude: 22.3081, longitude: 114.2247),
            description: "牛棚藝術村建於1908年，前身為馬頭角牲畜檢疫站，是本港碩果僅存的戰前牛隻屠房。現在是本地藝術工作者的聚集地。",
            imageNames: [
                "np-art-village",
            ],
            link: "https://zh.wikipedia.org/wiki/%E7%89%9B%E6%A3%9A%E8%97%9D%E8%A1%93%E6%9D%91"
        ),

        Location(
            name: "饒宗頤文化館",
            cityName: "九龍",
            coordinates: CLLocationCoordinate2D(latitude: 22.2980, longitude: 114.1730),
            description: "饒宗頤文化館是以著名學者饒宗頤命名的文化機構，致力於推廣中國傳統文化和藝術。館內經常舉辦各類展覽和活動。",
            imageNames: [
                "yau-chung-yip-cultural-center",
            ],
            link: "https://www.jtia.hk/"
        ),

        Location(
           name:"綠匯學苑",
           cityName:"大埔",
           coordinates : CLLocationCoordinate2D(latitude :22.4530 ,longitude :114.1750),
           description:"綠匯學苑是新界現存歷史最久的警署，曾在日佔時期被搶掠一空，現在活化為綠匯學苑，推廣永續生活。",
           imageNames : ["greenhub"],
           link : "https://www.greenhub.hk/tc/"
        ),

        Location(
           name:"石屋家園",
           cityName:"香港",
           coordinates : CLLocationCoordinate2D(latitude :22.2834 ,longitude :114.2264),
           description:"石屋家園是一個展示香港早期農村生活的博物館，由多座傳統石屋組成，提供參觀者了解香港農村歷史的機會。",
           imageNames : ["stone-house"],
           link : "https://www.stonehouses.org/zh/%E4%B8%BB%E9%A0%81"
        ),

        Location(
            name: "1881 Heritage",
            cityName: "尖沙咀",
            coordinates: CLLocationCoordinate2D(latitude: 22.2955, longitude: 114.1700),
            description: "1881 Heritage前身為水警總區總部，建於1884年，是香港現存最古老的政府建築之一。該建築於1994年被列為法定古蹟，並在2009年完成活化工程，現為文化、旅遊及購物的地標。",
            imageNames: [
                "1881-heritage",
            ],
            link: "https://zh.wikipedia.org/wiki/1881"
        )



    ]
    
}
