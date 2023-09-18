
class TopIssuesModel {
  String? topissues;
  String? secondaryTopIssues;
  String? bottomIssue;

  TopIssuesModel({
    this.topissues,
    this.secondaryTopIssues,
    this.bottomIssue,
  });

  factory TopIssuesModel.fromJson(Map<String, dynamic> json) => TopIssuesModel(
    topissues: json["topissues"],
    secondaryTopIssues: json["secondaryTopIssues"],
    bottomIssue: json["bottomIssue"],
  );

  Map<String, dynamic> toJson() => {
    "topissues": topissues,
    "secondaryTopIssues": secondaryTopIssues,
    "bottomIssue": bottomIssue,
  };
}
