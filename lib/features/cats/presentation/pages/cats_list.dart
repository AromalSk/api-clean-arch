import 'package:api_clean_arch/core/common/widgets/loader.dart';
import 'package:api_clean_arch/core/utils/show_snackbar.dart';
import 'package:api_clean_arch/features/auth/presentation/pages/login_page.dart';
import 'package:api_clean_arch/features/cats/presentation/bloc/cats_bloc.dart';
import 'package:api_clean_arch/features/cats/presentation/pages/cats_details.dart';
import 'package:api_clean_arch/features/cats/presentation/widgets/alert_dialogue.dart';
import 'package:api_clean_arch/features/cats/presentation/widgets/cat_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsGridPage extends StatefulWidget {
  @override
  State<CatsGridPage> createState() => _CatsGridPageState();
}

class _CatsGridPageState extends State<CatsGridPage> {
  @override
  void initState() {
    context.read<CatsBloc>().add(CallCats());
    super.initState();
  }

  final List<Map<String, String>> dogs = [
    {
      'name': 'Dog 1',
      'imageUrl':
          'https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg'
    },
    {
      'name': 'Dog 2',
      'imageUrl':
          'https://static.vecteezy.com/system/resources/thumbnails/005/857/332/small_2x/funny-portrait-of-cute-corgi-dog-outdoors-free-photo.jpg'
    },
    {
      'name': 'Dog 3',
      'imageUrl':
          'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2023/07/top-20-small-dog-breeds.jpeg.jpg'
    },
    {
      'name': 'Dog 4',
      'imageUrl':
          'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2023/07/top-20-small-dog-breeds.jpeg.jpg'
    },
    // Add more dog items here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cats'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            showSnackBar(context, "User has been logged out");
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                              builder: (context) {
                                return LoginPage();
                              },
                            ), (route) => false);
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<CatsBloc, CatsState>(
          listener: (context, state) {
            if (state is CatsFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is CatsLoading) {
              return Loader();
            }
            if (state is CatsSuccess) {
              final cats = state.catDetails;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: cats.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return BreedImagesScreen(
                            breedName: cats[index]?.breeds?[0]?.name ?? '',
                            breedImage: cats[index]!.url.toString(),
                            description:
                                cats[index]?.breeds?[0]?.description ?? '',
                            origin: cats[index]?.breeds?[0]?.origin ?? '',
                            lifeSpan: cats[index]?.breeds?[0]?.lifeSpan ?? '',
                          );
                        },
                      ));
                    },
                    child: CatItem(
                      name: cats[index]?.breeds?[0]?.name ?? '',
                      imageUrl: cats[index]!.url.toString(),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
