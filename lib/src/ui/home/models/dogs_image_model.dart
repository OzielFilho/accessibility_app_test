class DogsImageModel {
  final String image;

  DogsImageModel(this.image);

  factory DogsImageModel.fromJson(Map<String, dynamic> json) =>
      DogsImageModel(json['message']);
}
