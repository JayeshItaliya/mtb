
class RelatedBillModel {
  String? billname;
  String? topicSimplified;

  RelatedBillModel({
    this.billname,
    this.topicSimplified,
  });

  factory RelatedBillModel.fromJson(Map<String, dynamic> json) => RelatedBillModel(
    billname: json["billname"],
    topicSimplified: json["topic_simplified"],
  );

  Map<String, dynamic> toJson() => {
    "billname": billname,
    "topic_simplified": topicSimplified,
  };
}
