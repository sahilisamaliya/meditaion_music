class MusicResponseModel {
  MusicResponseModel({
    this.status,
    this.basics,
    this.relaxation,
    this.recommended,
  });

  MusicResponseModel.fromJson(dynamic json) {
    status = json['status'];
    basics = json['basics'] != null ? Basics.fromJson(json['basics']) : null;
    relaxation = json['relaxation'] != null
        ? Relaxation.fromJson(json['relaxation'])
        : null;
    if (json['recommended'] != null) {
      recommended = [];
      json['recommended'].forEach((v) {
        recommended?.add(Recommended.fromJson(v));
      });
    }
  }

  String? status;
  Basics? basics;
  Relaxation? relaxation;
  List<Recommended>? recommended;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (basics != null) {
      map['basics'] = basics?.toJson();
    }
    if (relaxation != null) {
      map['relaxation'] = relaxation?.toJson();
    }
    if (recommended != null) {
      map['recommended'] = recommended?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Recommended {
  Recommended({
    this.id,
    this.title,
    this.image,
    this.musicData,
  });

  Recommended.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    if (json['musicData'] != null) {
      musicData = [];
      json['musicData'].forEach((v) {
        musicData?.add(MusicData.fromJson(v));
      });
    }
  }

  String? id;
  String? title;
  String? image;
  List<MusicData>? musicData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    if (musicData != null) {
      map['musicData'] = musicData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class MusicData {
  MusicData({this.musicUrl, this.musicName, this.isPlay, this.id});

  MusicData.fromJson(dynamic json) {
    id = json['id'];
    musicUrl = json['musicUrl'];
    musicName = json['musicName'];
  }

  String? musicUrl;
  String? musicName;
  String? id;
  bool? isPlay;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['musicUrl'] = musicUrl;
    map['id'] = id;
    map['musicName'] = musicName;
    return map;
  }
}

class Relaxation {
  Relaxation({
    this.id,
    this.musicUrl,
    this.musicLength,
  });

  Relaxation.fromJson(dynamic json) {
    id = json['id'];
    musicUrl = json['musicUrl'];
    musicLength = json['musicLength'];
  }

  String? id;
  String? musicUrl;
  String? musicLength;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['musicUrl'] = musicUrl;
    map['musicLength'] = musicLength;
    return map;
  }
}

class Basics {
  Basics({
    this.id,
    this.musicUrl,
    this.musicLength,
  });

  Basics.fromJson(dynamic json) {
    id = json['id'];
    musicUrl = json['musicUrl'];
    musicLength = json['musicLength'];
  }

  String? id;
  String? musicUrl;
  String? musicLength;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['musicUrl'] = musicUrl;
    map['musicLength'] = musicLength;
    return map;
  }
}
