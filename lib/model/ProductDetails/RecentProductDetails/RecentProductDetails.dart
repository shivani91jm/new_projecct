class RecentProductsDetails {
  String? iD;
  String? postTitle;
  String? price;
  String? imageId;
  String? imageUrl;

  RecentProductsDetails({this.iD, this.postTitle, this.price, this.imageId, this.imageUrl});

  RecentProductsDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    postTitle = json['post_title'];
    price = json['price'];
    imageId = json['image_id'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['post_title'] = this.postTitle;
    data['price'] = this.price;
    data['image_id'] = this.imageId;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
