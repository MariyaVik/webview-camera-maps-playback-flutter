import 'dart:io';

import 'package:cameraa/images.dart';
import 'package:flutter/material.dart';

class GalleryView extends StatelessWidget {
  const GalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.isEmpty
        ? const Center(child: Text('Нет фотографий'))
        : ListView.builder(
            itemCount: images.length,
            itemBuilder: (contex, index) {
              return Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.red)),
                height: 300,
                child: Image.file(
                  File(images[index].path),
                  fit: BoxFit.fitWidth,
                ),
              );
            });
  }
}
