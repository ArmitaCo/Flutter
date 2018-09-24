class PackageModel {
  final int id;
  final int categoryId;
  final String title;
  final String imageUrl;
  final String coverUrl;
  final String description;

  PackageModel({this.categoryId,
    this.coverUrl,
    this.description,
    this.id,
    this.imageUrl,
    this.title,
    });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
        title:  json['Title'],
        categoryId:  json['CategoryId'],
        coverUrl:  json['CoverUrl'],
        description:  json['Description'],
        id:  json['Id'],
        imageUrl:  json['ImageUrl'],
    );
  }
}

