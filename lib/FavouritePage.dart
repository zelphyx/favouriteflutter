import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugas_feature/ControllerListAnime.dart';
import 'package:tugas_feature/drawer.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});



  @override
  Widget build(BuildContext context) {


    Future<bool> showconfirmationdelete() async {
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Are you sure you want to Delete this Anime from your Favourite List?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {

                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Delete'),
              ),
            ],
          );
        },
      );
    }


    double cardWidth = MediaQuery.of(context).size.width * 0.9;
    double imageWidth = cardWidth * 0.25;
    return Scaffold(
      appBar: AppBar(
          title:  Text("Your Favourite",style: TextStyle(
              fontWeight: FontWeight.bold
          ))
      ),
    drawer: MyDrawer(),
      body: Consumer<ControllerListAnime>(
        builder: (context,ControllerListAnime,child) {
          return ControllerListAnime.isLoading
              ? const CircularProgressIndicator()
              : ListView.builder(
                itemCount: ControllerListAnime.favData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: imageWidth,
                            height: imageWidth,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Image.memory(
                                ControllerListAnime.favData[index].image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16), // Adjust the spacing as needed
                          Expanded(
                            child: Center(
                              child: Text(
                                ControllerListAnime.favData[index].title!,
                                style: TextStyle(fontFamily: 'LibreCaslonText', fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          IconButton(onPressed: () async{
                            bool confirmDelete = await showconfirmationdelete();
                            if (confirmDelete) {
                              ControllerListAnime.delete(ControllerListAnime.favData[index].title!);
                            }

                          }, icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                },
              );
        }
    )
    );
  }
}
