import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceInfo {
  final String imageUrl, name, desc, address, city, title;
  final int id;

  PlaceInfo({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.imageUrl,
    required this.desc,
    required this.title,
  });

  factory PlaceInfo.fromJson(Map<String, dynamic> json) {
    return PlaceInfo(
      title: json['title'] ?? '',
      id: json['TempleID'] ?? 0,
      name: json['Name'] ?? '',
      address: json['Address'] ?? '',
      city: json['City'] ?? '',
      imageUrl: json['ImageURL'] ?? '',
      desc: json['Description'] ?? '',
    );
  }
}

class PlacesService {
  // List<PlaceInfo> places = [];
  Future<List<PlaceInfo>> getTemples() async {
    List<PlaceInfo> temples = [];
    final String url = 'http://192.168.1.64/api/show_temple.php';

    var response = await http.get(Uri.parse(url));
    var results = jsonDecode(response.body);

    for (var result in results) {
      PlaceInfo place = PlaceInfo.fromJson(result);
      temples.add(place);
    }

    return temples;
  }

  Future<List<PlaceInfo>> getPonds() async {
    List<PlaceInfo> ponds = [];
    final String url = 'http://192.168.1.64/api/show_ponds.php';

    var response = await http.get(Uri.parse(url));
    var results1 = jsonDecode(response.body);

    for (var result in results1) {
      PlaceInfo place = PlaceInfo(
        title: result['title'],
        id: result['PondID'],
        name: result['Name'],
        address: result['Address'],
        city: result['City'],
        imageUrl: result['ImageURL'],
        desc: result['Description'],
      );
      ponds.add(place);
    }

    return ponds;
  }

  Future<List<PlaceInfo>> getchowks() async {
    List<PlaceInfo> chowks = [];
    final String url = 'http://192.168.1.64/api/show_chowks.php';

    var response = await http.get(Uri.parse(url));
    var results = jsonDecode(response.body);

    for (var result in results) {
      PlaceInfo place = PlaceInfo(
        title: result['title'],
        id: result['ChowkID'],
        name: result['Name'],
        address: result['Address'],
        city: result['City'],
        imageUrl: result['ImageURL'],
        desc: result['Description'],
      );
      chowks.add(place);
    }

    return chowks;
  }

  Future<List<PlaceInfo>> getmeseums() async {
    List<PlaceInfo> meseums = [];
    final String url = 'http://192.168.1.64/api/show_meseum.php';

    var response = await http.get(Uri.parse(url));
    var results2 = jsonDecode(response.body);

    for (var result in results2) {
      PlaceInfo place = PlaceInfo(
        title: result['title'],
        id: result['TMuseumID'],
        name: result['Name'],
        address: result['Address'],
        city: result['City'],
        imageUrl: result['ImageURL'],
        desc: result['Description'],
      );
      meseums.add(place);
    }

    return meseums;
  }

  Future<List<PlaceInfo>> getstatues() async {
    List<PlaceInfo> statues = [];
    final String url = 'http://192.168.1.64/api/show_statue.php';

    var response = await http.get(Uri.parse(url));
    var results1 = jsonDecode(response.body);

    for (var result in results1) {
      PlaceInfo place = PlaceInfo(
        title: result['title'],
        id: result['statueID'],
        name: result['Name'],
        address: result['Address'],
        city: result['City'],
        imageUrl: result['ImageURL'],
        desc: result['Description'],
      );
      statues.add(place);
    }

    return statues;
  }

  Future<List<PlaceInfo>> getAllEvents() async {
    List<PlaceInfo> events = [];
    final String url = 'http://192.168.1.64/api/show_event.php';

    var response = await http.get(Uri.parse(url));
    var results = jsonDecode(response.body);

    for (var result in results) {
      // Perform null checks for each property before assigning the values
      PlaceInfo event = PlaceInfo(
        title: result['title'] ?? '',
        id: result['EventID'] ?? 0,
        name: result['Name'] ?? '',
        address: 'bhaktapur',
        city: result['main_location'] ?? '',
        imageUrl: result['Image'] ?? '',
        desc: result['Description'] ?? '',
      );
      events.add(event);
    }

    return events;
  }

  Future<List<PlaceInfo>> getUpcomingEvents() async {
    List<PlaceInfo> upcomingEvents = [];
    final String url = 'http://192.168.1.64/api/show_upcoming_events.php';

    var response = await http.get(Uri.parse(url));
    var results = jsonDecode(response.body);

    for (var result in results) {
      // Perform null checks for each property before assigning the values
      PlaceInfo event = PlaceInfo(
        title: result['title'] ?? '',
        id: result['EventID'] ?? 0,
        name: result['Name'] ?? '',
        address: 'bhaktapur',
        city: result['main_location'] ?? '',
        imageUrl: result['Image'] ?? '',
        desc: result['Description'] ?? '',
      );
      upcomingEvents.add(event);
    }

    return upcomingEvents;
  }
}
