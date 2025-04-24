import 'package:acrilc/constants/colors.dart';
import 'package:acrilc/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();

    // Fluttertoast.showToast(
    //   msg: "Hello, this is a toast!",
    //   toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    //   gravity: ToastGravity.BOTTOM, // TOP, CENTER, or BOTTOM
    //   backgroundColor: Colors.black,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        Input(
          searchController: TextEditingController(),
          onSearchChange: (String text) {
            print(text);
          },
        ),
        _heading(context),
        SizedBox(height: MediaQuery.of(context).size.height - 50, child: Themes()),
        // Text("Hello"),
      ],
    );
  }

  Widget _heading(BuildContext context) {
    TextStyle style = Theme.of(context)
    .textTheme
    .headlineLarge!
    .apply(color: AppColor.secondaryText);
    // LogService.debug("DATA");
    // print(AppColor.secondaryText);
    return Container(
      // color: Colors.blueAccent,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text("Trending Themes", style: style),
    );
  }

  }

class Themes extends StatelessWidget {
  final List<String> imageUrls = [
    "https://i.pinimg.com/474x/44/73/7f/44737f24b176d7a3a2ad68da2a9c4242.jpg",
    "https://i.pinimg.com/736x/70/47/a5/7047a5f036eb0344c3396ead26b46541.jpg",
    "https://i.pinimg.com/474x/c8/3b/28/c83b28ab71aef0dd4c8bcdec6039fca7.jpg",
    "https://i.pinimg.com/474x/b0/35/59/b03559ea1b59f2dad9499e41a46baeec.jpg",
    "https://i.pinimg.com/736x/f9/fd/a2/f9fda2dc68095891590ccf15646b65bd.jpg",
    "https://i.pinimg.com/474x/79/ae/00/79ae00de2a7127ca2b6f92b814b5fdb0.jpg",
    "https://i.pinimg.com/474x/bf/91/f0/bf91f083f6d50be1b5259e2335fc265f.jpg",
    "https://i.pinimg.com/474x/25/44/62/25446296a9e101763a410291dadb4005.jpg",
    "https://i.pinimg.com/474x/44/73/7f/44737f24b176d7a3a2ad68da2a9c4242.jpg",
    "https://i.pinimg.com/736x/70/47/a5/7047a5f036eb0344c3396ead26b46541.jpg",
    "https://i.pinimg.com/474x/c8/3b/28/c83b28ab71aef0dd4c8bcdec6039fca7.jpg",
    "https://i.pinimg.com/474x/b0/35/59/b03559ea1b59f2dad9499e41a46baeec.jpg",
    "https://i.pinimg.com/736x/f9/fd/a2/f9fda2dc68095891590ccf15646b65bd.jpg",
    "https://i.pinimg.com/474x/79/ae/00/79ae00de2a7127ca2b6f92b814b5fdb0.jpg",
    "https://i.pinimg.com/474x/bf/91/f0/bf91f083f6d50be1b5259e2335fc265f.jpg",
    "https://i.pinimg.com/474x/25/44/62/25446296a9e101763a410291dadb4005.jpg",
    "https://i.pinimg.com/474x/44/73/7f/44737f24b176d7a3a2ad68da2a9c4242.jpg",
    "https://i.pinimg.com/736x/70/47/a5/7047a5f036eb0344c3396ead26b46541.jpg",
    "https://i.pinimg.com/474x/c8/3b/28/c83b28ab71aef0dd4c8bcdec6039fca7.jpg",
    "https://i.pinimg.com/474x/b0/35/59/b03559ea1b59f2dad9499e41a46baeec.jpg",
    "https://i.pinimg.com/736x/f9/fd/a2/f9fda2dc68095891590ccf15646b65bd.jpg",
    "https://i.pinimg.com/474x/79/ae/00/79ae00de2a7127ca2b6f92b814b5fdb0.jpg",
    "https://i.pinimg.com/474x/bf/91/f0/bf91f083f6d50be1b5259e2335fc265f.jpg",
    "https://i.pinimg.com/474x/25/44/62/25446296a9e101763a410291dadb4005.jpg",
    "https://i.pinimg.com/474x/44/73/7f/44737f24b176d7a3a2ad68da2a9c4242.jpg",
    "https://i.pinimg.com/736x/70/47/a5/7047a5f036eb0344c3396ead26b46541.jpg",
    "https://i.pinimg.com/474x/c8/3b/28/c83b28ab71aef0dd4c8bcdec6039fca7.jpg",
    "https://i.pinimg.com/474x/b0/35/59/b03559ea1b59f2dad9499e41a46baeec.jpg",
    "https://i.pinimg.com/736x/f9/fd/a2/f9fda2dc68095891590ccf15646b65bd.jpg",
    "https://i.pinimg.com/474x/79/ae/00/79ae00de2a7127ca2b6f92b814b5fdb0.jpg",
    "https://i.pinimg.com/474x/bf/91/f0/bf91f083f6d50be1b5259e2335fc265f.jpg",
    "https://i.pinimg.com/474x/25/44/62/25446296a9e101763a410291dadb4005.jpg",
    "https://i.pinimg.com/474x/44/73/7f/44737f24b176d7a3a2ad68da2a9c4242.jpg",
    "https://i.pinimg.com/736x/70/47/a5/7047a5f036eb0344c3396ead26b46541.jpg",
    "https://i.pinimg.com/474x/c8/3b/28/c83b28ab71aef0dd4c8bcdec6039fca7.jpg",
    "https://i.pinimg.com/474x/b0/35/59/b03559ea1b59f2dad9499e41a46baeec.jpg",
    "https://i.pinimg.com/736x/f9/fd/a2/f9fda2dc68095891590ccf15646b65bd.jpg",
    "https://i.pinimg.com/474x/79/ae/00/79ae00de2a7127ca2b6f92b814b5fdb0.jpg",
    "https://i.pinimg.com/474x/bf/91/f0/bf91f083f6d50be1b5259e2335fc265f.jpg",
    "https://i.pinimg.com/474x/25/44/62/25446296a9e101763a410291dadb4005.jpg",
    "https://i.pinimg.com/474x/44/73/7f/44737f24b176d7a3a2ad68da2a9c4242.jpg",
    "https://i.pinimg.com/736x/70/47/a5/7047a5f036eb0344c3396ead26b46541.jpg",
    "https://i.pinimg.com/474x/c8/3b/28/c83b28ab71aef0dd4c8bcdec6039fca7.jpg",
    "https://i.pinimg.com/474x/b0/35/59/b03559ea1b59f2dad9499e41a46baeec.jpg",
    "https://i.pinimg.com/736x/f9/fd/a2/f9fda2dc68095891590ccf15646b65bd.jpg",
    "https://i.pinimg.com/474x/79/ae/00/79ae00de2a7127ca2b6f92b814b5fdb0.jpg",
    "https://i.pinimg.com/474x/bf/91/f0/bf91f083f6d50be1b5259e2335fc265f.jpg",
    "https://i.pinimg.com/474x/25/44/62/25446296a9e101763a410291dadb4005.jpg",
    "https://i.pinimg.com/474x/44/73/7f/44737f24b176d7a3a2ad68da2a9c4242.jpg",
    "https://i.pinimg.com/736x/70/47/a5/7047a5f036eb0344c3396ead26b46541.jpg",
    "https://i.pinimg.com/474x/c8/3b/28/c83b28ab71aef0dd4c8bcdec6039fca7.jpg",
    "https://i.pinimg.com/474x/b0/35/59/b03559ea1b59f2dad9499e41a46baeec.jpg",
    "https://i.pinimg.com/736x/f9/fd/a2/f9fda2dc68095891590ccf15646b65bd.jpg",
    "https://i.pinimg.com/474x/79/ae/00/79ae00de2a7127ca2b6f92b814b5fdb0.jpg",
    "https://i.pinimg.com/474x/bf/91/f0/bf91f083f6d50be1b5259e2335fc265f.jpg",
    "https://i.pinimg.com/474x/25/44/62/25446296a9e101763a410291dadb4005.jpg",
  ];

  Themes({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2, // Number of columns
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(10),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CeramicArtWorks(imageUrl: imageUrls[index]),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(imageUrls[index], fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}


class CeramicArtWorks extends StatelessWidget {
  const CeramicArtWorks({super.key, required String imageUrl});

  final List<String> imageUrls = const [
    'assets/images/pots1.jpg',
    'assets/images/sculpture1.jpg',
    'assets/images/pattern1.jpg',
    'assets/images/vases.jpg',
    'assets/images/statue1.jpg',
    'assets/images/group_statue.jpg',
    'assets/images/shop.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Goes back to DiscoverScreen
          },
        ),
        title: Text("Discover", style: Theme.of(context).textTheme.headlineLarge),
        actions: const [Padding(padding: EdgeInsets.all(8), child: Icon(Icons.search))],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ceramic Art Works", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
                children: imageUrls.map((image) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(image, fit: BoxFit.cover),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
