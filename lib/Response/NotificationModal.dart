class NotificationModal {
  String? id;
  String? serviceId;
  String? date;

  NotificationModal({this.id, this.serviceId, this.date});

  NotificationModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    date = json['dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['dates'] = this.date;
    return data;
  }
}
