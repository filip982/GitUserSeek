import SwiftUI

/// Helper Common view for loading images and cropping them in circle
/// Parameters: we can change height and width of the image but aspect ratio stays fitting image
struct UserImageView: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        
        AsyncImage(url: url) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
        } placeholder: {
            ProgressView()
                .frame(width: width, height: height)
        }
        .clipShape(Circle())
    }
}

#Preview {
    UserImageView(url: URL(string: "www.example.com"), width: 50, height: 50)
}
