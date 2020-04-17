//
//  ViewController.swift
//  Scatter and Gather
//
//  Created by Thomas Dye on 2020-04-10.
//  Copyright © 2019 Thomas Dye. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var isScattered: Bool = false
    
    private var logoImageView = UIImageView()
    private var letterLabelsToScatter = [UILabel]()
    
    private var logoHorizontalInset: CGFloat = 40
    private var logoInsets = CGSize(width: 40, height: 100)
    private var lambdaLetterConstraints = [NSLayoutConstraint]()
    private var letterLabelOrigins = [CGPoint]()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLambdaLogo()
        setUpLettersToScatter()
    }
    
    // MARK: - Subview Setup
    
    private func setUpLambdaLogo() {
        logoImageView = UIImageView(image: UIImage(named: "lambdaLogo"))
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: logoInsets.width),
            logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -logoInsets.width),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: logoInsets.height),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 2000 / 558)
        ])
    }
    
    private func setUpLettersToScatter() {
        let wordToScatter = "Lambda"
        let wordInset = CGSize(width: 40, height: 100)
        let letterSpacing: CGFloat = 2
        
        let lettersToScatter = Array(wordToScatter)
        let screenWidth = view.bounds.width
        let letterWidth = ((screenWidth - (2 * wordInset.width)) / CGFloat(wordToScatter.count)) - letterSpacing
        let letterHeight = wordInset.height * 2
        
        var letterLabels = [UILabel]()
        
        // set up each letter's label individually
        
        for letterIndex in 0 ..< wordToScatter.count {
            let letterLabel = UILabel(frame: CGRect(
                x: 0, y: 0, width: letterWidth, height: letterHeight
            ))
            letterLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(letterLabel)
            
            // set up label text
            
            letterLabel.font = UIFont.monospacedSystemFont(ofSize: 200, weight: .bold)
            letterLabel.adjustsFontSizeToFitWidth = true
            letterLabel.minimumScaleFactor = 0.05
            letterLabel.textAlignment = .center
            letterLabel.baselineAdjustment = .alignCenters
            
            letterLabel.text = String(lettersToScatter[letterIndex])
            
            // set up letter label's constraints
            
            let widthConstraint = letterLabel.widthAnchor.constraint(equalToConstant: letterWidth)
            widthConstraint.priority -= 1
            let heightConstraint = letterLabel.heightAnchor.constraint(equalToConstant: letterHeight)
            heightConstraint.priority -= 1
            NSLayoutConstraint.activate([
                widthConstraint,
                heightConstraint
            ])
            
            let leadingConstraint: NSLayoutConstraint
            if letterIndex == 0 {
                leadingConstraint = letterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: wordInset.width)
            } else {
                leadingConstraint = letterLabel.leadingAnchor.constraint(equalTo: letterLabels[letterIndex - 1].trailingAnchor, constant: letterSpacing)
            }
            
            var trailingConstraint: NSLayoutConstraint? = nil
            if letterIndex == wordToScatter.count - 1 {
                trailingConstraint = letterLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -wordInset.width)
            }
            
            var constraintsForThisLetter = [
                leadingConstraint,
                letterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: letterSpacing),
                letterLabel.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: letterSpacing)
            ]
            if let trailingConstraint = trailingConstraint {
                constraintsForThisLetter.append(trailingConstraint)
            }
            
            NSLayoutConstraint.activate(constraintsForThisLetter)
            lambdaLetterConstraints.append(contentsOf: constraintsForThisLetter)
            
            letterLabels.append(letterLabel)
        }
        
        self.letterLabelsToScatter = letterLabels
    }
    
    // MARK: - IB Actions

    @IBAction func toggleButtonTapped(_ sender: UIBarButtonItem) {
        if isScattered { gather() } else { scatter() }
    }
    
    // MARK: - Animations
    
    private func scatter() {
        letterLabelOrigins = letterLabelsToScatter.map { (label) -> CGPoint in
            return label.center
        }
        let animationBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.logoImageView.alpha = 0
            }
            
            let bounds = self.view.safeAreaLayoutGuide.layoutFrame
            for letterIndex in 0 ..< self.letterLabelsToScatter.count {
                let thisLabel = self.letterLabelsToScatter[letterIndex]
                let goToRandomLocation = {
                    thisLabel.center = CGPoint(
                        x: CGFloat.random(in: bounds.minX ... bounds.maxX),
                        y: CGFloat.random(in: bounds.minY ... bounds.maxY)
                    )
                }
                let randomSpin = {
                    thisLabel.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: 0 ..< 2 * CGFloat.pi))
                }
                
                // bounces
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.125, animations: goToRandomLocation)
                UIView.addKeyframe(withRelativeStartTime: 0.125, relativeDuration: 0.25) {
                    thisLabel.textColor = UIColor(cgColor: CGColor.random())
                    goToRandomLocation()
                }
                UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.5, animations: goToRandomLocation)
                
                // spins
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.125, animations: randomSpin)
                UIView.addKeyframe(withRelativeStartTime: 0.125, relativeDuration: 0.25, animations: randomSpin)
                UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.5, animations: randomSpin)
                UIView.addKeyframe(withRelativeStartTime: 0.875, relativeDuration: 0.125) {
                    thisLabel.transform = thisLabel.transform.rotated(by: CGFloat.random(in: -CGFloat.pi/4 ..< CGFloat.pi/4))
                }
                
                // randomize colors
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5) {
                    thisLabel.layer.backgroundColor = CGColor.random()
                }
            }
        }
        UIView.animateKeyframes(withDuration: 3.0, delay: 0, options: [.calculationModeLinear], animations: animationBlock) { _ in
            self.isScattered = true
        }
    }
    
    private func gather() {
        isScattered = false
        let animationBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.logoImageView.alpha = 1
            }
            for letterIndex in 0 ..< self.letterLabelsToScatter.count {
                let thisLabel = self.letterLabelsToScatter[letterIndex]
                let timeConstant = Double(letterIndex) / Double(self.letterLabelsToScatter.count) / 2.0
                UIView.addKeyframe(
                    withRelativeStartTime: timeConstant,
                    relativeDuration: 0.25
                ) {
                    thisLabel.transform = .identity
                    thisLabel.center = self.letterLabelOrigins[letterIndex]
                }
                UIView.addKeyframe(
                    withRelativeStartTime: 0.25 + timeConstant,
                    relativeDuration: 0.25
                ) {
                    thisLabel.textColor = .label
                    thisLabel.layer.backgroundColor = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 0)
                }
            }
        }
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animationBlock) { _ in
            self.isScattered = false
        }
    }
}

