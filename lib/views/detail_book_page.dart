import 'dart:convert';
import 'package:bookapps/models/books_detail_respons.dart';
import 'package:bookapps/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({Key? key, required this.Isbn}) : super(key: key);
  final String Isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookDetailResponse? detailBook;

  fetchDetailBookApi() async {
    print(widget.Isbn);
    var url = Uri.parse('https://api.itbook.store/1.0/books/${widget.Isbn}');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDetailBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: detailBook == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImageViewScreen(ImageUrl: detailBook!.image!),
                          ),
                        );
                      },
                      child: Image.network(
                        detailBook!.image!,
                        height: 100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(detailBook!.title!),
                          Text(detailBook!.authors!),
                          Text(detailBook!.subtitle!),
                          Text(detailBook!.price!),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          //fixedSize: Size(double.infinity, 50)
                          ),
                      onPressed: () {},
                      child: Text("Buy")),
                ),
                Text(detailBook!.isbn10!),
                Text(detailBook!.isbn13!),
                Text(detailBook!.pages!),
                Text(detailBook!.desc!),
                Text(detailBook!.publisher!),
                Text(detailBook!.rating!),
              ]),
            ),
    );
  }
}
