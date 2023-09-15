import '../homeFlowModel/billListModel.dart';

class FollowModel {
  int? billId;
  String? billName;
  String? topicTag;
  String? status;
  List<BillListModel> billdetail;

  FollowModel({
    this.billId,
    this.billName,
    this.topicTag,
    this.status,
    required this.billdetail,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
    billId: json["billId"],
    billName: json["billName"],
    topicTag: json["topic_tag"],
    status: json["status"],
    billdetail: json["billdetail"] == null ? [] : List<BillListModel>.from(json["billdetail"]!.map((x) => BillListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "billId": billId,
    "billName": billName,
    "topic_tag": topicTag,
    "status": status,
    "billdetail": List<dynamic>.from(billdetail.map((x) => x.toJson())),
  };
  static List<FollowModel>? getListFromJson(List<dynamic> list) {
    List<FollowModel> unitList = [];
    for (var unit in list) {
      if (unit is String) {
      } else {
        unitList.add(FollowModel.fromJson(unit));
      }
    }
    return unitList;
  }
}