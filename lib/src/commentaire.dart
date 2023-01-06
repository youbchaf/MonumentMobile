class Commentaire {
  String? contenu;
  Pk? pk;
  bool? vote;

  Commentaire({this.contenu, this.pk, this.vote});

  Commentaire.fromJson(Map<String, dynamic> json) {
    contenu = json['contenu'];
    pk = json['pk'] != null ? new Pk.fromJson(json['pk']) : null;
    vote = json['vote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contenu'] = this.contenu;
    if (this.pk != null) {
      data['pk'] = this.pk!.toJson();
    }
    data['vote'] = this.vote;
    return data;
  }
}

class Pk {
  String? date;
  int? monument;
  int? user;

  Pk({this.date, this.monument, this.user});

  Pk.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    monument = json['monument'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['monument'] = this.monument;
    data['user'] = this.user;
    return data;
  }
}
