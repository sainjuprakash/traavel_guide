import 'dart:convert';

import 'package:http/http.dart' as http;

class PlaceInfo {
  final String imageUrl, name, desc, address, city;
  final int id;

  PlaceInfo({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.imageUrl,
    required this.desc,
  });
}

class PlacesService {
  // List<PlaceInfo> places = [];

  Future<List<PlaceInfo>> getTemples() async {
    List<PlaceInfo> temples = [];
    final String url = 'http://192.168.1.91/phpapi/show_temple.php';

    var response = await http.get(Uri.parse(url));
    var results = jsonDecode(response.body);

    for (var result in results) {
      PlaceInfo place = PlaceInfo(
        id: result['TempleID'],
        name: result['Name'],
        address: result['Address'],
        city: result['City'],
        imageUrl: result['ImageURL'],
        desc: result['Description'],
      );
      temples.add(place);
    }

    return temples;
  }

  Future<List<PlaceInfo>> getPonds() async {
    List<PlaceInfo> ponds = [];
    final String url = 'http://192.168.1.91/phpapi/show_ponds.php';

    var response = await http.get(Uri.parse(url));
    var results1 = jsonDecode(response.body);

    for (var result in results1) {
      PlaceInfo place = PlaceInfo(
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
    final String url = 'http://192.168.1.91/phpapi/show_chowks.php';

    var response = await http.get(Uri.parse(url));
    var results = jsonDecode(response.body);

    for (var result in results) {
      PlaceInfo place = PlaceInfo(
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
    final String url = 'http://192.168.1.91/phpapi/show_meseum.php';

    var response = await http.get(Uri.parse(url));
    var results2 = jsonDecode(response.body);

    for (var result in results2) {
      PlaceInfo place = PlaceInfo(
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
    final String url = 'http://192.168.1.91/phpapi/show_statue.php';

    var response = await http.get(Uri.parse(url));
    var results1 = jsonDecode(response.body);

    for (var result in results1) {
      PlaceInfo place = PlaceInfo(
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
}
