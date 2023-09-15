class ChooseTopicModel {
  String topicName;
  bool isFollow;

  ChooseTopicModel({
    required this.topicName,
    required this.isFollow,
  });

  factory ChooseTopicModel.fromJson(Map<String, dynamic> json) => ChooseTopicModel(
    topicName: json["topicName"],
    isFollow: json["isFollow"],
  );

  Map<String, dynamic> toJson() => {
    "topicName": topicName,
    "isFollow": isFollow,
  };
}
