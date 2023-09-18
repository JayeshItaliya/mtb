
class BillListModel {
  int? id;
  String? billName;
  String? topicSimplified;
  String? proposedDate;
  String? statusInCongress;
  String? tags;
  String? type;
  int? number;
  String? billText;
  bool? isFollow;
  int? isTrending;

  BillListModel({
    this.id,
    this.billName,
    this.topicSimplified,
    this.proposedDate,
    this.statusInCongress,
    this.tags,
    this.type,
    this.number,
    this.billText,
    this.isFollow,
    this.isTrending,
  });

  factory BillListModel.fromJson(Map<String, dynamic> json) => BillListModel(
    id: json["id"],
    billName: json["bill_name"],
    topicSimplified: json["topic_simplified"],
    proposedDate: json["proposed_date"],
    statusInCongress: json["status_in_congress"],
    tags: json["tags"],
    type: json["type"],
    number: json["number"],
    billText: json["bill_text"],
    isFollow: json["isFollow"],
    isTrending: json["isTrending"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bill_name": billName,
    "topic_simplified": topicSimplified,
    "proposed_date": proposedDate,
    "status_in_congress": statusInCongress,
    "tags": tags,
    "type": type,
    "number": number,
    "bill_text": billText,
    "isFollow": isFollow,
    "isTrending": isTrending,
  };


  @override
  String toString() {
    return 'BillListModel{id: $id, billName: $billName, topicSimplified: $topicSimplified, proposedDate: $proposedDate, statusInCongress: $statusInCongress, tags: $tags, type: $type, number: $number, billText: $billText, isFollow: $isFollow, isTrending: $isTrending}';
  }

  static List<BillListModel>? getListFromJson(List<dynamic> list) {
    List<BillListModel> unitList = [];
    for (var unit in list) {
      if (unit is String) {
      } else {
        unitList.add(BillListModel.fromJson(unit));
      }
    }
    return unitList;
  }
}
