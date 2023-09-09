import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/dto/onboard_item_dto.dart';
import 'bloc/bloc_export.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late List<OnboardItemDTO> _pages;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color:
        isActive ? const Color.fromARGB(255, 97, 179, 242) : Colors.black45,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final Size size = mediaQueryData.size;

    return Scaffold(
      body: BlocConsumer<OnboardBloc, OnboardState>(listener: (
          context,
          state,
          ) {
        if (state is LoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Loading"),
            ),
          );
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FailureState) {
          return const Center(
            child: Text("Something went wrong"),
          );
        } else if (state is SuccessState) {
          _pages = state.response;
          return Scaffold(
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.4, 0.7, 0.9],
                    colors: [
                      Color.fromARGB(255, 239, 244, 248),
                      Color.fromARGB(255, 232, 232, 233),
                      Color.fromARGB(255, 249, 249, 252),
                      Color.fromARGB(255, 251, 250, 253),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 600.0,
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: _pageController,
                              itemCount: _pages.length,
                              onPageChanged: (int page) {
                                setState(() {
                                  _currentPage = page;
                                });
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(40.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                        child: SvgPicture.asset(
                                          _pages[index].image,
                                          height: 300.0,
                                          width: 300.0,
                                        ),
                                      ),
                                      const SizedBox(height: 30.0),
                                      Text(
                                        _pages[index].title,
                                      ),
                                      const SizedBox(height: 15.0),
                                      Text(
                                        _pages[index].description,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: _currentPage == _numPages - 1
                ? InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("OnTap event."),
                  ),
                );
              },
              child: Container(
                height: Platform.isIOS ? 70 : 60,
                color: const Color.fromARGB(255, 97, 179, 242),
                alignment: Alignment.center,
                child: Text(
                  "Iniciar",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Platform.isIOS
                      ? 70
                      : Platform.isAndroid
                      ? 60
                      : 60,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(_pages.length - 1);
                    },
                    child: Text(
                      "Saltar",
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Platform.isIOS ? 70 : 60,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.ease,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Siguiente",
                          style: const TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.black45,
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
