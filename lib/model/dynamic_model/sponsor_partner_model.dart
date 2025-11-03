class PartnerSponsorModel {
  Data? data;
  int? totalViews;
  int? clickAd;

  PartnerSponsorModel({this.data, this.totalViews, this.clickAd});

  PartnerSponsorModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    totalViews = json['total_views'];
    clickAd = json['click_ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['total_views'] = this.totalViews;
    data['click_ad'] = this.clickAd;
    return data;
  }
}

class Data {
  int? id;
  String? namePoster;
  String? posterDescription;
  String? posterImage;
  String? backgroundImage;
  String? companyImage;
  String? companyName;
  String? companyDescription;
  String? companyUrl;
  String? createdAt;
  String? updatedAt;
  String? promoted;
  bool? showNamePoster;
  bool? showPosterDescription;
  bool? showPosterImage;
  bool? showBackgroundImage;
  bool? showCompanyImage;
  bool? showCompanyName;
  bool? showCompanyDescription;
  bool? showCompanyUrl;
  int? viewCount;
  int? clickCount;
  String? region;

  Data(
      {this.id,
        this.namePoster,
        this.posterDescription,
        this.posterImage,
        this.backgroundImage,
        this.companyImage,
        this.companyName,
        this.companyDescription,
        this.companyUrl,
        this.createdAt,
        this.updatedAt,
        this.promoted,
        this.showNamePoster,
        this.showPosterDescription,
        this.showPosterImage,
        this.showBackgroundImage,
        this.showCompanyImage,
        this.showCompanyName,
        this.showCompanyDescription,
        this.showCompanyUrl,
        this.viewCount,
        this.clickCount,
        this.region});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namePoster = json['name_poster'];
    posterDescription = json['poster_description'];
    posterImage = json['poster_image'];
    backgroundImage = json['background_image'];
    companyImage = json['company_image'];
    companyName = json['company_name'];
    companyDescription = json['company_description'];
    companyUrl = json['company_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    promoted = json['promoted'];
    showNamePoster = json['show_name_poster'];
    showPosterDescription = json['show_poster_description'];
    showPosterImage = json['show_poster_image'];
    showBackgroundImage = json['show_background_image'];
    showCompanyImage = json['show_company_image'];
    showCompanyName = json['show_company_name'];
    showCompanyDescription = json['show_company_description'];
    showCompanyUrl = json['show_company_url'];
    viewCount = json['view_count'];
    clickCount = json['click_count'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_poster'] = this.namePoster;
    data['poster_description'] = this.posterDescription;
    data['poster_image'] = this.posterImage;
    data['background_image'] = this.backgroundImage;
    data['company_image'] = this.companyImage;
    data['company_name'] = this.companyName;
    data['company_description'] = this.companyDescription;
    data['company_url'] = this.companyUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['promoted'] = this.promoted;
    data['show_name_poster'] = this.showNamePoster;
    data['show_poster_description'] = this.showPosterDescription;
    data['show_poster_image'] = this.showPosterImage;
    data['show_background_image'] = this.showBackgroundImage;
    data['show_company_image'] = this.showCompanyImage;
    data['show_company_name'] = this.showCompanyName;
    data['show_company_description'] = this.showCompanyDescription;
    data['show_company_url'] = this.showCompanyUrl;
    data['view_count'] = this.viewCount;
    data['click_count'] = this.clickCount;
    data['region'] = this.region;
    return data;
  }
}