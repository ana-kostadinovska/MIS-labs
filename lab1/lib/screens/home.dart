import 'package:flutter/material.dart';
import '../models/clothes_model.dart';
import '../widgets/clothes/clothes_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Clothes> clothes = [
    Clothes(id: 1, name: "cardigan", image: 'https://static.zara.net/assets/public/8824/7ec1/78ab483e9888/cc27e972b5b9/04192133401-e1/04192133401-e1.jpg?ts=1732035160916&w=563', description: "Blazer featuring a lapel collar and long sleeves with shoulder pads. Featuring front pockets with flaps and double-breasted front fastening with textured buttons.", price: 3290.00),
    Clothes(id: 2, name: "sweater", image: 'https://static.zara.net/assets/public/4725/7c70/64d64262add7/42d4bf91e15c/05536200712-e1/05536200712-e1.jpg?ts=1730820681023&w=563', description: "Round neck sweater with long sleeves, ribbed trims and side vents at the hem.", price: 1590.00),
    Clothes(id: 3, name: "straight jeans", image: 'https://static.zara.net/assets/public/38f3/6271/1e4840a1a124/fe8aa44e5493/06147053802-e1/06147053802-e1.jpg?ts=1732020594616&w=563', description: "High-waist jeans with five pockets. Faded effect. Straight, long leg. Zip fly and button fastening.", price: 1990.00),
    Clothes(id: 4, name: "coat", image: 'https://static.zara.net/assets/public/34a7/ef0a/e04c40e5b43e/79f768d1b4ff/08372289706-e1/08372289706-e1.jpg?ts=1726817741367&w=563', description: "Short coat with a lapel collar and long sleeves. Featuring front welt pockets and double-breasted button fastening.", price: 2590.00),
    Clothes(id: 5, name: "blazer", image: 'https://static.zara.net/assets/public/c90d/5f18/10fa4b709634/5704be1a26ce/08634970801-e1/08634970801-e1.jpg?ts=1731672165497&w=563', description: "Blazer featuring a lapel collar and long sleeves with shoulder pads. Featuring front pockets with flaps and double-breasted front fastening with textured buttons.", price: 3290.00),
    Clothes(id: 6, name: "mom-fit jeans", image: 'https://static.zara.net/assets/public/e530/d526/87f24fcaa1c6/d92a87a5ab74/07223222406-e1/07223222406-e1.jpg?ts=1726999438500&w=563', description: "High-waist cropped jeans with five pockets. Faded effect. Front zip and button fastening.", price: 1590.00),
    Clothes(id: 7, name: "soft coat", image: 'https://static.zara.net/assets/public/cba4/c080/d6d2431f9608/d458984cbac1/08073259704-015-e1/08073259704-015-e1.jpg?ts=1729848468717&w=563', description: "Long sleeve coat with a lapel collar. Featuring front welt pockets and front button fastening.", price: 2590.00),
    Clothes(id: 8, name: "knit top", image: 'https://static.zara.net/assets/public/0f3c/274f/6d924c22a7b9/c176251ef66a/04192100606-e1/04192100606-e1.jpg?ts=1730894295224&w=563',description: "Plain knit waistcoat top with a round neck and sleeveless design. Features a front vent at the hem and a gold-tone button fastening.", price: 1590.00),
    Clothes(id: 9, name: "knit cardigan", image: 'https://static.zara.net/assets/public/f3de/f03f/4e4c408ca048/e8f2ec21ca43/01822106070-e1/01822106070-e1.jpg?ts=1723104655314&w=563', description: "Cardigan with a round neck and long sleeves. False front welt pockets. Raised golden button fastening at the front.", price: 1990.00),
    Clothes(id: 10, name: "trousers", image: 'https://static.zara.net/assets/public/0d5a/3aa4/b37d4dc3884a/d70017ce1099/08959199605-e1/08959199605-e1.jpg?ts=1730994855771&w=563', description: "High-waist trousers with belt loops. Side pockets and welt pockets on the back. Straight leg. Zip fly and metal hook and button fastening.", price: 2290.00),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        leading: IconButton(onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.white, size: 24,)),
        title: const Text(
            "211006",
            style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.white, size: 24))
        ],
      ),
      backgroundColor: Colors.white,
      body: ClothesGrid(clothes: clothes),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Share',
        backgroundColor: Colors.pink[100],
        child: const Icon(Icons.share_rounded),
      ),
    );
  }
}
