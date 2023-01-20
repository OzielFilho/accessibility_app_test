import 'package:flutter_app/src/utils/endpoints/endpoints.dart';
import 'package:flutter_app/src/utils/enum/http_methods.dart';
import 'package:flutter_app/src/ui/home/repository/dogs_images_executor.dart';

import '../../../utils/params/http_params.dart';
import '../../../utils/services/http_service.dart';
import '../interactor/dogs_images_receiver.dart';

class DogsImagesRepository implements DogsImagesExecutor {
  final HttpService _httpService;
  final DogsImagesReceiver _receiver;
  DogsImagesRepository(HttpService httpService, DogsImagesReceiver receiver)
      : _httpService = httpService,
        _receiver = receiver;

  @override
  Future<void> execute() async {
    try {
      final endpoint = EndPoints.randomImageDog;
      const method = HttpMethods.get;
      HttpParams params = HttpParams(url: endpoint, method: method, null, {});
      final result = await _httpService.execute(params);
      _receiver.receiveDogsImages(result);
    } on Exception catch (exception) {
      _receiver.handleErrorDogsImages(exception);
    }
  }
}
