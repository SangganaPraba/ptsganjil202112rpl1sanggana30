import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl1sanggana30/hotel_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatelessWidget {
  final HotelModel hotel;

  const Detail({Key? key, required this.hotel}) : super(key: key);

  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.hotelName, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(hotel.imageUrl),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  Text(hotel.hotelName),
                  SizedBox(height: 10),
                  Text('Country', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  Text(hotel.countryTrans),
                  SizedBox(height: 10),
                  Text('City', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  Text(hotel.city),
                  SizedBox(height: 10),
                  Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  Text(hotel.address),
                  SizedBox(height: 10),
                  Text('Review Score', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 3),
                  Text('${hotel.reviewScore}/10'),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: () {
                    print(hotel.bookingUrl);
                    _launchURL(hotel.bookingUrl);
                  }, child: Text('Book Hotel'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
