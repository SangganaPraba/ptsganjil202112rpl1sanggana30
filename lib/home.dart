import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ptsganjil202112rpl1sanggana30/detail.dart';
import 'package:ptsganjil202112rpl1sanggana30/hotel_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<HotelModel> list = [];
  late List<dynamic> data;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gethotels();
  }

  Future<void> gethotels() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> headers = {
      'x-rapidapi-host': 'booking-com.p.rapidapi.com',
      'x-rapidapi-key': '8212bea402mshf8c8cf2f96948dcp12675bjsna5f077d51c3d'
    };

    Map<String, String> queryParams = {
      'locale': 'en-gb',
      'room_number': '1',
      'checkout_date': '2021-11-26',
      'order_by': 'popularity',
      'units': 'metric',
      'adults_number': '1',
      'filter_by_currency': 'IDR',
      'checkin_date': '2021-11-25',
      'dest_type': 'city',
      'dest_id': '-553173'
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = 'https://booking-com.p.rapidapi.com/v1/hotels/search' + '?' + queryString;
    final response = await http.get(Uri.parse(requestUrl), headers: headers);

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var res = jsonDecode(response.body);
      setState(() {
        data = res['result'];
        for (int i = 0; i < data.length; i++) {
          list.add(new HotelModel(
              data[i]['hotel_name'],
              data[i]['country_trans'],
              data[i]['city'],
              data[i]['address'],
              data[i]['review_score'],
              data[i]['max_photo_url'],
              data[i]['url']));
        }
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load hotels');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hotel App')),
      body: isLoading
          ? Center(
          child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildList(list)
                ],
              )),
        ),
      ),
    );
  }

  Widget buildList(List<HotelModel> list) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        HotelModel hotel = list[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 3),
          child: Card(
            elevation: 10,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Detail(hotel: hotel);
                }));
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(hotel.imageUrl),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(hotel.hotelName, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange),
                              SizedBox(width: 5),
                              Text('${hotel.reviewScore}/10')
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: list.length,
    );
  }
}
