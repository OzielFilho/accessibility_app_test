import 'package:flutter_app/src/utils/services/http_service.dart';
import 'package:flutter_app/src/ui/home/interactor/dogs_images_provider.dart';
import 'package:flutter_app/src/ui/home/interactor/dogs_images_receiver.dart';
import 'package:flutter_app/src/ui/home/models/dogs_image_model.dart';

import '../presenter/dogs_images_presenter_listener.dart';
import '../repository/dogs_images_repository.dart';

class ObtainImageDogsExecutor
    implements DogsImagesReceiver, DogsImagesProvider {
  late final HttpService? _httpService;
  late final DogsImagesPresenterListener? _listener;

  ObtainImageDogsExecutor({DogsImagesPresenterListener? listener}) {
    _listener = listener;
    _httpService = HttpServiceClient();
  }

  @override
  Future<void> handleErrorDogsImages(Exception exception) async {
    _listener!.errorReceiveImageDogs(exception);
  }

  @override
  Future<void> obtainImageDogs() async {
    final repository = DogsImagesRepository(_httpService!, this);
    await repository.execute();
  }

  @override
  Future<void> receiveDogsImages(Map<String, dynamic> images) async {
    _listener!.receiveImagesDogs(DogsImageModel.fromJson(images));
  }
}
