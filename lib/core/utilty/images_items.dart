enum ImageItem {
  image,
}

String defaultValue = "assets/images";

extension ImageItems on ImageItem {
  String str() {
    return switch (this) {
      ImageItem.image => "$defaultValue/image.png",
    };
  }
}
