class ImageName {
  static final ImageName _singleton = new ImageName._internal();

  factory ImageName() {
    return _singleton;
  }
  static final image_1 = "images/1.png";
  static final image_2 = "images/2.png";
  static final image_3 = "images/3.png";
  static final back = "images/back.png";
  static final google = "images/google.png";
  static final facebook = "images/facebook.png";

  ImageName._internal();
}
