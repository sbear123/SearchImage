//
//  SearchImageDetailTests.swift
//  SearchImageTests
//
//  Created by 박지현 on 2021/06/28.
//

import XCTest
@testable import SearchImage

class SearchImageDetailTests: XCTestCase {
    
    var vc: DetailViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        vc = storyboard.instantiateViewController(identifier: "DetailViewController") as? DetailViewController
        
        vc.vm.document = Document(collection: "blog", thumbnail_url: "https://search2.kakaocdn.net/argon/130x130_85_c/IYv6Au3WK0", image_url: "http://postfiles6.naver.net/20111027_85/ihbaik100_1319716956661c0U9R_JPEG/%BE%C8%B3%E7%C7%CF%BC%BC%BF%E4.jpg?type=w2", width: 500, height: 332, display_sitename: "네이버블로그", datetime: "2008-08-13T17:43:02.000+09:00", doc_url: "http://blog.naver.com/ihbaik100/141601922")
        
        vc.loadView()
    }

    override func tearDownWithError() throws {
       vc = nil
    }
    
    func testSetLabels() {
        vc.table.reloadData()
        let cell = vc.table.cellForRow(at: IndexPath(row: 1, section: 0)) as? LabelCell
        XCTAssertEqual(cell!.siteName.text, "출처 : 네이버블로그", "Error) Label에 \"출처 : \"이 추가 되지 않음")
        XCTAssertEqual(cell!.date.text, "작성 시간 : 2008년 08월 13일 수요일", "Error) Label에 \"작성 시간 : \"이 추가 되지 않음")
    }
    
    func testImageHeight() {
        let height = vc.vm.getNewHeight(CGFloat(300))
        XCTAssertEqual(height,CGFloat(199.2),"Error) Height가 잘못 계산되고 있습니다.")
    }
    
    func testDateFormatter() {
        let date = vc.vm.stringConvertToDateTime()
        XCTAssertEqual(date,"2008년 08월 13일 수요일", "Error) 원하는 dateformat이 되지 않습니다.")
    }
}
