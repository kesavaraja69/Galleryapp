import 'package:flutter/material.dart';
import 'package:galleryapp/app/constants/constants.dart';
import 'package:galleryapp/app/constants/sizeconfig.dart';
import 'package:galleryapp/core/model/fetchimages.data.dart';
import 'package:galleryapp/core/notifier/fetchimages.notifier.dart';
import 'package:galleryapp/meta/screens/listofimages/list_of_images.dart';
import 'package:provider/provider.dart';

class GalleryHomeScreen extends StatefulWidget {
  final BoxConstraints constraints;
  const GalleryHomeScreen({super.key, required this.constraints});

  @override
  State<GalleryHomeScreen> createState() => _GalleryHomeScreenState();
}

class _GalleryHomeScreenState extends State<GalleryHomeScreen> {
  late Future<Fetchimagesdata> fetchimagedata;
  int noofpage = 1;
  int perpage = 10;
  late TextEditingController _searchtext;
  bool isSearchdata = false;
  bool loading = false;
  List<Fetchimagesdatamodel?>? items = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _searchtext = TextEditingController();
    fetchimagedata = loaddata();
    _scrollController.addListener(() {
      //! Check if the scroll position has reached or exceeded the maximum scroll extent (bottom of the list)
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        //! Ensure no loading is happening currently
        noofpage++; //! Increment the page count to load more data
        mockfetch();
      }
    });
    super.initState();
  }

  //! Check for duplicate items before adding them to the list
  void addUniqueItems(List<Fetchimagesdatamodel?>? newItems) {
    for (var newItem in newItems!) {
      //! Assuming each item has a unique 'id' or similar field to identify it
      bool isDuplicate = items!.any((item) => item!.id == newItem!.id);
      if (!isDuplicate) {
        items!.add(newItem);
      }
    }
  }

  mockfetch() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    setState(() {
      fetchimagedata = loaddata().whenComplete(() {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      });
    });
  }

  Future<Fetchimagesdata> loaddata() async {
    //! Get the FetchimageNotifier provider without listening to changes
    final fetchimageprovider =
        Provider.of<FetchimageNotifier>(context, listen: false);

    //! Fetch image data from the provider and add unique items to the list
    final Fetchimagesdata fetchdata = await fetchimageprovider
        .fetchImage(context, noofpage, search: _searchtext.text);
    addUniqueItems(fetchdata.hits);
    return fetchdata;
  }

  @override
  void dispose() {
    _searchtext
        .dispose(); //! Dispose of the TextEditingController to free up resources and avoid memory leaks
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(
        context); //! Initialize the SizeConfig utility class to set screen dimensions for responsive design

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: BConstantColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //! Search field
            Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 12, right: 12),
              child: searchImage(
                  controller: _searchtext,
                  text: "search here",
                  onclik: () {
                    if (_searchtext.text.isNotEmpty) {
                      items!.clear();
                      setState(() {
                        isSearchdata = true;
                        fetchimagedata = loaddata();
                      });
                    }
                  }),
            ),
            SizedBox(
              height: SizeConfig.screenHeight! * 0.81,
              child: FutureBuilder(
                  // future: fetchimageprovider.fetchImage(context, 2),
                  future: fetchimagedata,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      var snapshotdata = snapshot.data as Fetchimagesdata;

                      if (snapshotdata.hits!.isEmpty) {
                        return Center(
                          child: Text(
                            "No data",
                            style: kPopinsMedium.copyWith(
                                fontSize: SizeConfig.blockSizeHorizontal! * 3),
                          ),
                        );
                      }
                      //! list of grid images
                      return ListOfImages(
                        data: items,
                        controller: _scrollController,
                        loading: loading,
                        constraints: widget.constraints,
                      );
                    }
                    return Center(
                      child: Text(
                        "something went wrong try again",
                        style: kPopinsMedium.copyWith(
                            fontSize: SizeConfig.blockSizeHorizontal! * 3),
                      ),
                    );
                  }),
            ),
            loading == true
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, bottom: 7),
                      child: Text(
                        "Loading more....",
                        style: kPopinsMedium.copyWith(
                            fontSize: widget.constraints.maxWidth > 950
                                ? SizeConfig.blockSizeHorizontal! * 1
                                : widget.constraints.maxWidth > 600
                                    ? SizeConfig.blockSizeHorizontal! * 2
                                    : SizeConfig.blockSizeHorizontal! * 3,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget searchImage({required text, required controller, required onclik}) {
    return Container(
      width: widget.constraints.maxWidth > 950
          ? SizeConfig.screenWidth! * 0.4
          : widget.constraints.maxWidth > 600
              ? SizeConfig.screenWidth! * 0.5
              : SizeConfig.screenWidth!,
      height: SizeConfig.screenHeight! * 0.05,
      decoration: BoxDecoration(
          color: BConstantColors.whiteColor,
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Center(
          child: TextField(
            controller: controller,
            maxLines: 1,
            onChanged: (value) {
              if (_searchtext.text.isNotEmpty) {
                isSearchdata = true;
              }
              if (value.isEmpty) {
                setState(() {
                  items!.clear();
                  isSearchdata = false;
                  fetchimagedata = loaddata();
                });
              }
            },
            onSubmitted: (value) {
              //! the "Enter" key is pressed in a TextField or TextFormField by using the onSubmitted or onEditingComplete callback.

              setState(() {
                items!.clear();
                isSearchdata = false;
                fetchimagedata = loaddata();
              });
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: text,
                suffixIcon: InkWell(
                  onTap: onclik,
                  child: const Icon(
                    Icons.search_outlined,
                    size: 26,
                    color: BConstantColors.txt1Color,
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
