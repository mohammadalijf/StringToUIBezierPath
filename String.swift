//
//  String.swift
//  
//
//  Created by Mohammad Ali Jafarian on 10/6/17.
//

import UIKit

extension String {
    func bezierPath(with font: UIFont) -> UIBezierPath {
        let ctFont = CTFontCreateWithName(font.fontName as CFString,
                                          font.pointSize, nil)
        let letters = CGMutablePath()
        let attrString = NSAttributedString(string: self,
                                            attributes: [.font: font])
        let line = CTLineCreateWithAttributedString(attrString)
        let runs = CTLineGetGlyphRuns(line) as! [CTRun]
        for run in runs {
            let gylphCount = CTRunGetGlyphCount(run)
            for i in 0 ..< gylphCount {
                let range = CFRangeMake(i, 1)
                var gylphs = [CGGlyph](repeating: 0,
                                       count: range.length)
                var position = CGPoint()
                CTRunGetGlyphs(run,
                               range,
                               &gylphs)
                CTRunGetPositions(run,
                                  range,
                                  &position)
                for gylph in gylphs {
                    if let letter = CTFontCreatePathForGlyph(ctFont, gylph, nil) {
                        let translation = CGAffineTransform(translationX: position.x,
                                                            y: position.y)
                        letters.addPath(letter,
                                        transform: translation)
                    }
                }

            }
        }
        let bezier = UIBezierPath(cgPath: letters)
        return bezier
    }
}
