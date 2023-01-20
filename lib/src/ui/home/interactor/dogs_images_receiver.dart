abstract class DogsImagesReceiver {
  Future<void> receiveDogsImages(Map<String, dynamic> images);
  Future<void> handleErrorDogsImages(Exception exception);
}
