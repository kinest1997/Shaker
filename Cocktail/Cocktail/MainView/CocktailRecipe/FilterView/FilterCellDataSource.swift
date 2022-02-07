//
//  FilterCellDataSource.swift
//  Cocktail
//
//  Created by 강희성 on 2022/02/03.
//

import Foundation
import RxDataSources
import Differentiator

// 섹션에 들어가는 정보: 여기선 셀의 정보와 헤더의 이름

struct FilterCellData {
    var name: String
    var selected: Bool
}

struct SectionOfFilterCell {
    var header: String
    var items: [FilterCellData]
}

extension SectionOfFilterCell: SectionModelType {

    typealias Item = FilterCellData

    init(original: SectionOfFilterCell, items: [Item]) {
        self = original
        self.items = items
    }
}
