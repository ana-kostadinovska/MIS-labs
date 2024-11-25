import 'package:flutter/material.dart';
import '../models/clothes_model.dart';
import '../widgets/details/back_button_details.dart';
import '../widgets/details/data_details.dart';
import '../widgets/details/image_details.dart';
import '../widgets/details/title_details.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Clothes;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ImageDetails(
                image: arguments.image),
            TitleDetails(
                id: arguments.id, name: arguments.name),
            DataDetails(
                id: arguments.id,
                description: arguments.description,
                price: arguments.price
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: const BackButtonDetails(),
    );
  }
}
