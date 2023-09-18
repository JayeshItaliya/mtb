
class ForYouModel {
  List<String>? topicTags;
  List<String>? topIssues;
  List<bool>? isFollow;

  ForYouModel({
    this.topicTags,
    this.topIssues,
    this.isFollow,
  });

  factory ForYouModel.fromJson(Map<String, dynamic> json) => ForYouModel(
    topicTags: json["topic_name"] == null ? [] : List<String>.from(json["topic_name"]!.map((x) => x)),
    topIssues: json["topissues"] == null ? [] : List<String>.from(json["topissues"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "topicTags": topicTags == null ? [] : List<dynamic>.from(topicTags!.map((x) => x)),
    "topissues": topIssues == null ? [] : List<dynamic>.from(topIssues!.map((x) => x)),
  };
}
