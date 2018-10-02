//
//  local.swift
//  snsTest
//
//  Created by estgames on 2018. 9. 19..
//  Copyright © 2018년 estgames. All rights reserved.
//

import Foundation

extension String {
    func localized() ->String {
        let defaultLang = UserDefaults.standard.string(forKey: "i18n_language")
        let lang:String?
        
        if (defaultLang == nil) {
            lang = Locale.current.languageCode
        } else {
            lang = defaultLang
        }
        
        let bundle:Bundle? = Bundle(identifier: "org.cocoapods.estgames-common-framework")
        var path = bundle?.path(forResource: lang, ofType: "lproj")//Bundle.main.path(forResource: lang, ofType: "lproj")
        
        if path == nil {
            path = bundle?.path(forResource: "en", ofType: "lproj")
        }
        
        if let p = path {
            let b = Bundle(path: p)
            if let d = b {
                return NSLocalizedString(self, tableName: nil, bundle: d, value: "", comment: "")
            } else {
                return NSLocalizedString(self, comment: "");
            }
        } else {
            return NSLocalizedString(self, comment: "");
        }
        
    }
}
