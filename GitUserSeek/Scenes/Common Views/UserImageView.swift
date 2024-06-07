import SwiftUI

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
