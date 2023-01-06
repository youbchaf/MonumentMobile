import 'package:http/http.dart' as http;
import 'dart:convert';

class mp {
  Creator? creator;
  String? dateCreation;
  String? description;
  String? heureClose;
  String? heureOpen;
  int? id;
  double? latitude;
  double? longitude;
  String? nom;
  Type? type;
  String? url;
  bool? week;
  Zone? zone;

  mp(
      {this.creator,
        this.dateCreation,
        this.description,
        this.heureClose,
        this.heureOpen,
        this.id,
        this.latitude,
        this.longitude,
        this.nom,
        this.type,
        this.url,
        this.week,
        this.zone});

  mp.fromJson(Map<String, dynamic> json) {
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    dateCreation = json['dateCreation'];
    description = json['description'];
    heureClose = json['heure_close'];
    heureOpen = json['heure_open'];
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    nom = json['nom'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    url = json['url'];
    week = json['week'];
    zone = json['zone'] != null ? new Zone.fromJson(json['zone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['dateCreation'] = this.dateCreation;
    data['description'] = this.description;
    data['heure_close'] = this.heureClose;
    data['heure_open'] = this.heureOpen;
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['nom'] = this.nom;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    data['url'] = this.url;
    data['week'] = this.week;
    if (this.zone != null) {
      data['zone'] = this.zone!.toJson();
    }
    return data;
  }
}

class Creator {
  String? dateDebut;
  String? dateFin;
  String? description;
  int? id;
  String? nom;

  Creator({this.dateDebut, this.dateFin, this.description, this.id, this.nom});

  Creator.fromJson(Map<String, dynamic> json) {
    dateDebut = json['dateDebut'];
    dateFin = json['dateFin'];
    description = json['description'];
    id = json['id'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateDebut'] = this.dateDebut;
    data['dateFin'] = this.dateFin;
    data['description'] = this.description;
    data['id'] = this.id;
    data['nom'] = this.nom;
    return data;
  }
}

class Type {
  int? id;
  String? libelle;

  Type({this.id, this.libelle});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['libelle'] = this.libelle;
    return data;
  }
}

class Zone {
  int? id;
  String? nom;
  Ville? ville;

  Zone({this.id, this.nom, this.ville});

  Zone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    ville = json['ville'] != null ? new Ville.fromJson(json['ville']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    if (this.ville != null) {
      data['ville'] = this.ville!.toJson();
    }
    return data;
  }
}

class Ville {
  int? id;
  String? nom;

  Ville({this.id, this.nom});

  Ville.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    return data;
  }
}

Future<List<mp>> fetchMonumentsP() async {
  final response = await http
      .get(Uri.parse('http://127.0.0.1:8080/MonumentProjetWS'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print('Hi');
    List<mp> objs = jsonDecode(response.body).map<mp>((roomJson)
    => mp.fromJson(roomJson)).toList();
    return objs;

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
