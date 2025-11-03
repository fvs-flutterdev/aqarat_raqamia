class AllRegionsModel {
  List<RegionData>? data;

  AllRegionsModel({this.data});

  AllRegionsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RegionData>[];
      json['data'].forEach((v) {
        data!.add(new RegionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RegionData {
  int? regionId;
  String? name;
  bool? istabbed;

  RegionData({this.regionId, this.name, this.istabbed});

  RegionData.fromJson(Map<String, dynamic> json) {
    regionId = json['region_id'];
    name = json['name'];
    istabbed = json['istabbed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region_id'] = this.regionId;
    data['name'] = this.name;
    data['istabbed'] = this.istabbed;
    return data;
  }
}