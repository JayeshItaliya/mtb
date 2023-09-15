
class RelatedBillModel {
  List<RelatedBillName>? relatedBillName;

  RelatedBillModel({
    this.relatedBillName,
  });

  factory RelatedBillModel.fromJson(Map<String, dynamic> json) => RelatedBillModel(
    relatedBillName: json["related_bill_name"] == null ? [] : List<RelatedBillName>.from(json["related_bill_name"]!.map((x) => RelatedBillName.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "related_bill_name": relatedBillName == null ? [] : List<dynamic>.from(relatedBillName!.map((x) => x.toJson())),
  };
}

class RelatedBillName {
  String? billname;
  String? topicSimplified;

  RelatedBillName({
    this.billname,
    this.topicSimplified,
  });

  factory RelatedBillName.fromJson(Map<String, dynamic> json) => RelatedBillName(
    billname: json["billname"],
    topicSimplified: json["topic_simplified"],
  );

  Map<String, dynamic> toJson() => {
    "billname": billname,
    "topic_simplified": topicSimplified,
  };
}
