import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tugas_feature/ControllerListAnime.dart';
import 'package:tugas_feature/drawer.dart';


class ListPage extends StatelessWidget {

  ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: MyDrawer(),
    appBar: AppBar(
        title:  Text("Animepedia",style: TextStyle(
          fontWeight: FontWeight.bold
        ))
    ),
      body: Center(
        child: Consumer<ControllerListAnime>(
          builder: (context,ControllerListAnime,child) {
            return ControllerListAnime.isLoading
                ? const CircularProgressIndicator()
                : Column(
              children: [
                Expanded(
                  child: GridView.builder(

                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount:
                      ControllerListAnime.animemodelctr.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = ControllerListAnime
                            .animemodelctr[index];

                        bool isFav = ControllerListAnime.favData.any(
                              (favProduct) => favProduct.title == product.title,
                        );
                        return Container(
                          margin: const EdgeInsets.all(10),
                          child: Card(

                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Image.network(
                                      product.thumbnail,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  product.title,
                                  style: TextStyle(fontSize: 14,fontFamily: 'LibreCaslonText'),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                IconButton(
                                  icon:Icon(Icons.star),
                                  color: isFav ? Colors.yellow : Colors.grey,
                                  onPressed: () async{
                                    var image = await get(Uri.parse(product.thumbnail));
                                    var bytes = image.bodyBytes;
                                    isFav ?
                                    ControllerListAnime.delete(product.title)
                                        :
                                    await ControllerListAnime.insert({
                                      'title': product.title,
                                      'image': bytes,
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  ),
                )
              ],
            );
          },
        ),
    ),
    );
  }
}
