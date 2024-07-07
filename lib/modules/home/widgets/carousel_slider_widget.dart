import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CaroaselSlider extends StatelessWidget {
  CaroaselSlider({
    super.key,
  });
  // final HomeModel? homeModel;

  List<String> images = [
    'https://th.bing.com/th/id/R.fb8e247fa9972c80870202d048656ec1?rik=pN8w%2bqHfUj3yWw&riu=http%3a%2f%2fhowto.jasonsherman.org%2fwp-content%2fuploads%2f2014%2f12%2ftomlin-media-company-logos-4-14-13.jpg&ehk=ohpFEIG%2bI%2fdOPTpyadeFat12ZOoVbVMQi8P7vkVH0Co%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.1b0d812c0996126cc5d2b9bb5a72cbb2?rik=KUbvpKNuzUkwig&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2ff%2f5%2f3%2f765467-gorgerous-business-wallpapers-1920x1200.jpg&ehk=vrfLPsMSWkdd8ah2LgirHv7BYaiji%2f%2fTUZ8rBPjq%2bVk%3d&risl=&pid=ImgRaw&r=0'
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images.map((element) {
          return CachedNetworkImage(
            width: double.infinity,
            imageUrl: element,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child:
                  CircularProgressIndicator(value: downloadProgress.progress),
            ),
            errorWidget: (context, url, error) => const Image(
              image: NetworkImage(
                  'https://student.valuxapps.com/storage/uploads/banners/1689106805161JH.photo_2023-07-11_23-07-43.png'),
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            fit: BoxFit.cover,
          );
          //   Image(
          //   image: NetworkImage(element),
          //   width: double.infinity,
          //   fit: BoxFit.fill,
          //   errorBuilder: (context, error, stackTrace) {
          //     return const Image(
          //       image: NetworkImage(
          //           'https://student.valuxapps.com/storage/uploads/banners/1689106805161JH.photo_2023-07-11_23-07-43.png'),
          //       width: double.infinity,
          //       fit: BoxFit.fill,
          //     );
          //   },
          // );
        }).toList(),
        options: CarouselOptions(
          // height: 400,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 2),
          autoPlayAnimationDuration: const Duration(milliseconds: 730),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ));
  }
}
