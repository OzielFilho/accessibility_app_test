import '../models/dogs_image_model.dart';

abstract class DogsImagesPresenterListener {
  void receiveImagesDogs(DogsImageModel dogsImageModel);
  void errorReceiveImageDogs(Exception exception);
}
