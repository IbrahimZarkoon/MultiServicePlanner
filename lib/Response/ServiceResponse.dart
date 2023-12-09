class ServiceResponse {
  String? id;
  String? bannerImg;
  String? priceRangeStart;
  String? priceRangeEnd;
  String? capacity;
  String? timings;
  String? venueName;
  String? venueMapLink;
  String? about;
  String? location;
  String? webLink;
  String? serviceId;
  String? userId;
  List<String>? relatedImg;
  List<String>? tags;

  ServiceResponse(
      {this.id,
        this.bannerImg,
        this.priceRangeStart,
        this.priceRangeEnd,
        this.capacity,
        this.timings,
        this.venueName,
        this.venueMapLink,
        this.about,
        this.location,
        this.webLink,
        this.serviceId,
        this.userId,
        this.relatedImg,
        this.tags, required data});

  ServiceResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImg = json['bannerImg'];
    priceRangeStart = json['priceRangeStart'];
    priceRangeEnd = json['priceRangeEnd'];
    capacity = json['capacity'];
    timings = json['timings'];
    venueName = json['venueName'];
    venueMapLink = json['venueMapLink'];
    about = json['about'];
    location = json['location'];
    webLink = json['webLink'];
    serviceId = json['service_id'];
    userId = json['user_id'];
    relatedImg = json['related_img'].cast<String>();
    tags = json['tags'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bannerImg'] = this.bannerImg;
    data['priceRangeStart'] = this.priceRangeStart;
    data['priceRangeEnd'] = this.priceRangeEnd;
    data['capacity'] = this.capacity;
    data['timings'] = this.timings;
    data['venueName'] = this.venueName;
    data['venueMapLink'] = this.venueMapLink;
    data['about'] = this.about;
    data['location'] = this.location;
    data['webLink'] = this.webLink;
    data['service_id'] = this.serviceId;
    data['user_id'] = this.userId;
    data['related_img'] = this.relatedImg;
    data['tags'] = this.tags;
    return data;
  }
}
