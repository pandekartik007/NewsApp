import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../helper/data.dart';
import '../helper/widgets.dart';
import '../models/categories_model.dart';
import './categories_news.dart';
import '../helper/news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _loading;
  var newslist;

  List<CategoryModel> categories = List<CategoryModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(

        child: _loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Container(
            color: Colors.grey,
            child: Column(
              children: <Widget>[

                /// News Article
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: ListView.builder(
                      itemCount: newslist.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return NewsTile(
                          imgUrl: newslist[index].urlToImage ?? "",
                          title: newslist[index].title ?? "",
                          desc: newslist[index].description ?? "",
                          content: newslist[index].content ?? "",
                          posturl: newslist[index].articleUrl ?? "",
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              newsCategory: categoryName.toLowerCase(),
            )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}