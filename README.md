# Scatter and Gather Animations

Your project scatters the letters of the word "Lambda" by animating them to new locations.

After completing the lesson material and this project, you'll be able to animate a number of `UIView` and `CALayer` properties.

[Preview your project](https://youtu.be/w8zJVBPrmnY)

## Set up the project

Follow these steps to set up your project skeleton:

1. Create a new single-view project. 
2. Embed the view controller in a navigation controller in the `Main.storyboard` (be sure to move the initial view controller arrow as well)

## Create a bar button that calls back to your main view controller

These steps enable you to run your animation with a single tap:

1. Create a new bar button item in your view controller's navigation bar (drag to left or right side).
2. Name it `toggle`
3. Connect it to your view controller with an `IBAction` and name it `toggle(_:)`.
4. Create a boolean property variable called `isScrambled` that you can toggle back and forth. You'll animate your views to either scramble them or gather them together when the toggle button is tapped and this boolean will help you decide which state you're in (scrambled or gathered).

## Create views

Build the items you want to animate, either by hand or in Interface Builder. You'll need six labels (one for each letter) and one image view (for the Lambda logo). Look for the logo file in this repo.

Create `IBOutlet`'s for these views in your view controller so they can be animated by your `toggle(_:)` method.

## Animate

When scattering:

* Fade out your logo view (meaning the logo should disappear over the length of the animation)
* Move your letters to random locations
* Assign them a random background color and text color
* Use a custom transform to rotate the views (`letter.transform = CGAffineTransform(rotationAngle: random_angle`)
* Incorporate as many other custom animations as you like.
* Your animation should take between 2 and 4 seconds.

When gathering:

* Fade in your logo view (meaning it should gradually reappear as the gather animation runs)
* Reset all the custom properties you previously assigned to the letters (meaning they should appear as they did at the start of the app).
* Animate the letters back to their starting position, either as a line or however you have them set up by default.

## Stretch

Here are some stretch goals to investigate:

* Add 3-D transforms to your layers instead of a simple 2D rotation.
* Animate shadows onto and away from your views.
* Add keyframe sequences to perform multiple tasks when scattering your views.

## References

Here are some helpful resources for your project:

* `UIView` reference (Xcode, [also this Apple Doc article](https://developer.apple.com/documentation/uikit/uiview). See the `Animations` section for a list of animatable properties.
* [`CALayer` animatable properties](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html)
* [Core animation](https://developer.apple.com/documentation/quartzcore)
* Affine Transforms in iOS:
    * see Xcode docs for `CGAffineTransform` and `CATransform3D`, [Quartz 2D](https://developer.apple.com/library/archive/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_affine/dq_affine.html)
    * [Wolfram](http://mathworld.wolfram.com/AffineTransformation.html)
    * [Wikipedia](https://en.wikipedia.org/wiki/Affine_transformation)
    * [University of Texas](https://www.cs.utexas.edu/users/fussell/courses/cs384g-fall2011/lectures/lecture07-Affine.pdf)
* [Apple Doc on the random function of the `Int` type](https://developer.apple.com/documentation/swift/int/2995646-random)