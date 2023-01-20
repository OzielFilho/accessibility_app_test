import 'dart:async';

import 'package:flutter_app/src/ui/home/models/dogs_image_model.dart';
import 'package:flutter_app/src/ui/home/presenter/dogs_images_presenter_listener.dart';
import 'package:flutter_app/src/ui/home/presenter/dogs_images_presenter_provider.dart';
import 'package:flutter/material.dart';

import '../interactor/dogs_images_provider.dart';
import '../interactor/obtain_image_dogs_executor.dart';

class DogsImagesPresenter extends ChangeNotifier
    implements DogsImagesPresenterListener, DogsImagesPresenterProvider {
  final _controller = StreamController<Object>();

  final List<DogsImageModel> _dogs = [];

  late DogsImagesProvider _provider;

  DogsImagesPresenter() {
    _provider = ObtainImageDogsExecutor(listener: this);
  }

  @override
  void errorReceiveImageDogs(Exception exception) {
    _controller.sink.add(exception);
  }

  @override
  Future<void> obtainImagesDog() async {
    await _provider.obtainImageDogs();
  }

  @override
  Stream<Object> get outController => _controller.stream;

  @override
  void receiveImagesDogs(DogsImageModel dogsImageModel) {
    _dogs.add(dogsImageModel);
    if (_dogs.length == 1) {
      obtainImagesDog();
    }
    _controller.sink.add(_dogs);
  }
}
