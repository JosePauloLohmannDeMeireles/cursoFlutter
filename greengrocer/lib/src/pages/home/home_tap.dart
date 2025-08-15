import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/home/componets/category_tile.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;
import 'package:greengrocer/src/pages/home/componets/item_tile.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({super.key});

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {



  String selectCategory = 'Frutas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: 'Green', style: TextStyle(color: CustomColors.customSwatchColor)),
              TextSpan(text: 'grocer', style: TextStyle(color: CustomColors.customContrastColor)),
            ],
          )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15, 
              right: 15
            ),
            child: GestureDetector(
              onTap: () {
            
              },
              
              child: Badge(
                backgroundColor: CustomColors.customContrastColor,
                label: Text(
                  '2',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwatchColor,
                ),
              ),
            ),
          )
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquise aqui...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14,
                ),
                prefixIcon: Icon(Icons.search, color: CustomColors.customContrastColor, size: 21),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  )
                )
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              
              itemBuilder: (_, index) {
                return CategoryTile(
                  onPressed: () {
                    setState(() {
                      selectCategory = app_data.categories[index];
                    });
                  },
                  category: app_data.categories[index],
                  isSelected: selectCategory == app_data.categories[index],
            
                );
              }, 
              separatorBuilder: (_,index) => const SizedBox(width: 10), 
              itemCount: app_data.categories.length
            ),
          ),
        
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10, 
                childAspectRatio: 9 / 11.5
              ), 

              itemCount: app_data.items.length,
              itemBuilder: (_, index) {
                return ItemTile(
                  item: app_data.items[index]
                );
              }
            ),
          )
        ],
      ),
    );
  }
}