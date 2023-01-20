import 'package:flutter_app/src/ui/home/presenter/dogs_images_presenter.dart';
import 'package:flutter_app/src/ui/home/presenter/dogs_images_presenter_provider.dart';
import 'package:flutter/material.dart';

import 'models/dogs_image_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DogsImagesPresenterProvider _presenterProvider;
  late PageController _pageController;
  static dynamic _currentPageValue = 0.0;

  void get _pageControllerConfigs {
    _pageController = PageController(viewportFraction: 0.95);
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page;
      });

      if (_pageController.position.pixels ==
          _pageController.position.maxScrollExtent) {
        _obtainImagesDog();
      }
    });
  }

  final String _subtitle =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque est felis, hendrerit ac elementum quis, consequat et arcu. Praesent imperdiet sit amet nunc tristique finibus. Aenean elementum tincidunt eros, sit amet euismod mauris molestie sit amet. Suspendisse scelerisque urna sit amet ipsum suscipit interdum. Nam risus elit, interdum ut euismod eget, bibendum ut odio. Nulla cursus ut neque quis auctor. Integer tincidunt vehicula nulla, eget malesuada arcu congue quis. Donec et consectetur massa, sed venenatis eros. Duis vehicula nisl vehicula, consectetur ex et, consectetur purus. Morbi vel arcu laoreet, molestie dolor imperdiet, semper odio. Nunc dolor mauris, fringilla in hendrerit quis, volutpat sit amet dui. Phasellus pharetra purus sed maximus tincidunt. In metus massa, laoreet eget augue non, volutpat laoreet magna. Quisque magna lacus, fermentum vel cursus sit amet, ultricies ac ipsum. Aliquam eu justo elementum, feugiat lorem quis, feugiat dui. Aliquam faucibus pharetra maximus. Pellentesque quis tristique velit. Praesent sed gravida sem, sed tincidunt nunc. Nam ante erat, venenatis ac nunc nec, convallis feugiat urna. Duis molestie felis ac odio mollis, non semper nisl gravida. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nec augue eu eros efficitur rhoncus eget non elit. Curabitur lobortis nunc dictum, maximus metus sed, feugiat odio. Nam consequat ligula eu venenatis bibendum. Duis ex tortor, aliquam et metus vitae, euismod malesuada mi. Nam vitae dolor nec lectus pretium aliquam nec ut eros. Nunc cursus mauris id magna sodales viverra. Integer at ex molestie diam sagittis bibendum. Donec consectetur odio eu massa ultricies, quis feugiat odio lobortis. Etiam ac sodales lectus. Vestibulum at velit lobortis, volutpat eros in, vulputate nulla. Sed aliquam tortor non mi dignissim, nec tincidunt tellus aliquam. Sed fringilla nisl sem, in egestas enim ultrices in. Proin commodo risus sed posuere aliquam. Duis id leo id turpis ultricies dignissim. Vestibulum egestas sit amet nulla vel laoreet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam blandit commodo neque, eu porta purus rutrum ac. Nulla facilisi. Pellentesque sit amet ex dapibus, pellentesque velit tincidunt, pulvinar lectus. Pellentesque id erat quis justo viverra convallis sed sit amet ante. In lobortis vehicula consectetur. Integer aliquet eleifend diam eget ullamcorper. In hac habitasse platea dictumst. Morbi id lorem id arcu accumsan semper. Praesent pretium, est at tempor rutrum, lectus sapien euismod velit, in tincidunt massa erat sit amet magna. Vivamus a feugiat tellus, non elementum risus. Nunc dapibus mi vel sem semper pellentesque. Maecenas eu metus neque. Vestibulum ac risus vestibulum, ullamcorper orci venenatis, semper tortor. Aliquam eget cursus sapien. Quisque vulputate tellus ac dui mollis, a sagittis tellus laoreet. Vivamus sit amet dolor in turpis bibendum suscipit. Aenean mattis purus semper, aliquet arcu eu, rutrum mauris. Maecenas finibus sit amet erat vitae venenatis. Curabitur vel vulputate purus, quis laoreet tortor. Donec feugiat pulvinar finibus. Aenean vehicula aliquet augue vel tempus.';

  @override
  void initState() {
    super.initState();
    _pageControllerConfigs;
    _presenterProvider = DogsImagesPresenter();
    _obtainImagesDog();
  }

  _obtainImagesDog() async {
    await _presenterProvider.obtainImagesDog();
  }

  _openDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          semanticLabel: 'Alert Dialog Aberto',
          content: Text('Bem Vindo ao Teste de Acessibilidade'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Título qualquer para o teste',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  semanticsLabel:
                      'Título da Página : Título qualquer para o teste',
                ),
                MaterialButton(
                  color: Colors.white,
                  onPressed: () => _openDialog(),
                  child: const Text('Botão Teste Clique'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _subtitle,
                    semanticsLabel: 'Subtítulo da Página $_subtitle',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ),
                StreamBuilder<Object>(
                  stream: _presenterProvider.outController,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData ||
                        (snapshot.hasData &&
                            snapshot.data! is bool &&
                            !(snapshot.data as bool))) {
                      return const CircularProgressIndicator(
                          semanticsLabel: 'Carregando as imagens da Página',
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white));
                    }
                    if (snapshot.data is Exception) {
                      return const Text(
                        'Error',
                        semanticsLabel: 'Error ao pegar as imagens da página',
                      );
                    }
                    final dogs = snapshot.data as List<DogsImageModel>;
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                          controller: _pageController,
                          itemCount: dogs.length,
                          padEnds: true,
                          allowImplicitScrolling: true,
                          pageSnapping: true,
                          itemBuilder: (context, pagePosition) => Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateX(_currentPageValue - pagePosition),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.all(5.0),
                                  child: Image.network(
                                    dogs[pagePosition].image,
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    width: MediaQuery.of(context).size.width,
                                    semanticLabel: 'Cachorro $pagePosition',
                                    color: Colors.black.withOpacity(0.3),
                                    colorBlendMode: BlendMode.darken,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
