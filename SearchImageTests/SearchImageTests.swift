//
//  SearchImageTests.swift
//  SearchImageTests
//
//  Created by 박지현 on 2021/06/24.
//

import XCTest
@testable import SearchImage

class SearchImageTests: XCTestCase {
    
    var vc: MainViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        vc = storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController
        
        vc.loadView()
    }

    override func tearDownWithError() throws {
        
    }

    func testSearchPlaceholder() {
        XCTAssertEqual(vc.search.placeholder, "검색어를 입력하세요.", "Error) placeholder가 \"검색어를 입력하세요\"가 아닙니다.")
    }
    
    func test30Items() {
        vc.vm.getNewData(search: "안녕하세요"){ success in
            if success {
                XCTAssertEqual(self.vc.vm.countImages(), 30, "Error) 불러온 이미지가 30개가 아닙니다.")
            }
        }
    }
    
    func testFetchData() {
        vc.vm.fetchData{ success in
            if success {
                XCTAssertEqual(self.vc.vm.countImages(), 60, "Error) 추가로 불러온 이미지가 60개가 아닙니다.")
            }
        }
    }
    
    func testError() {
        vc.vm.getNewData(search: "") { success in
            XCTAssertEqual(success, false, "Error) 빈 검색어가 검색이 되어 오류가 발생한다.")
        }
    }
    
    func testEmptySearch() {
        vc.vm.getNewData(search: "ㅏㅁㅇ홈댜ㅐㅓㅐㅠ뎌ㅠㅎ매ㅗㄷㄹ") { success in
            if success {
                XCTAssertEqual(self.vc.vm.countImages(), 0, "Error) 없는 데이터값인데 데이터가 존재합니다.")
                XCTAssertEqual(self.vc.vm.getIsEnd(), false, "Error) 다음 값이 없는데 있다고 뜹니다.")
            }
        }
    }

}
