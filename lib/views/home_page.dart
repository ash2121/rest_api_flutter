import 'package:flutter/material.dart';
import 'package:rest_api_flutter/models/post.dart';
import 'package:rest_api_flutter/services/remote_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  // to keep a track if api response has loaded or not
  bool hasLoaded = false;
  @override
  void initState() {
    super.initState();
    // since we want to load data when the page initialises
    // we dont want to initialise the data on every build
    getData();
  }

  void getData() async {
    posts = await RemoteServices().getPosts();
    setState(() {
      if (posts != null) {
        hasLoaded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts")),
      body: Visibility(
        visible: hasLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(posts![index].title),
              subtitle: Text(posts![index].body, maxLines: 2),
              contentPadding: const EdgeInsets.all(6),
              leading: const CircleAvatar(backgroundColor: Colors.blue),
            );
          },
          itemCount: posts?.length,
        ),
      ),
    );
  }
}
