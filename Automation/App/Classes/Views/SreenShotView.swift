import SwiftUI
import CoreImage
import Vision

struct ScreenShotView: View {
    @State private var image: NSImage?
    @State private var highlightedImage: NSImage?

    var body: some View {
        VStack {
            Button("Capture From Clipboard") {
                fetchImageFromClipboard()
            }
            .padding()

            if let image = highlightedImage {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No Image")
            }
        }
    }

    private func fetchImageFromClipboard() {
        if let clipboardData = NSPasteboard.general.data(forType: .tiff),
           let image = NSImage(data: clipboardData) {
            self.image = image
            highlightObjectsInImage(image)
        }
    }

    private func highlightObjectsInImage(_ image: NSImage) {
        guard let ciImage = CIImage(data: image.tiffRepresentation!) else {
            return
        }

        // Create a Vision request for rectangle detection
        let request = VNDetectRectanglesRequest { request, error in
            guard let observations = request.results as? [VNRectangleObservation] else {
                return
            }

            // Draw bounding boxes around the detected rectangles
            let outputImage = image.copy() as! NSImage
            let imageSize = image.size
            let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -imageSize.height)

            for observation in observations {
                let boundingBox = observation.boundingBox
                let transformedBoundingBox = boundingBox.applying(transform)

                let highlightedImage = outputImage.imageWithBoundingBox(transformedBoundingBox)
                self.highlightedImage = highlightedImage
            }
        }

        // Perform rectangle detection on the CIImage
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        do {
            try handler.perform([request])
        } catch {
            print("Error performing rectangle detection: \(error)")
        }
    }
}

extension NSImage {
    func imageWithBoundingBox(_ boundingBox: CGRect) -> NSImage {
        let imageSize = self.size
        let imageRect = NSRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)

        let highlightedImage = NSImage(size: imageSize)
        highlightedImage.lockFocus()

        // Draw the original image
        self.draw(in: imageRect)

        // Draw the bounding box
        NSColor.red.setStroke()
        NSBezierPath(rect: boundingBox).stroke()

        highlightedImage.unlockFocus()

        return highlightedImage
    }
}
