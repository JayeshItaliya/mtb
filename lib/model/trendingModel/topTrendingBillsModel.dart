
import '../homeFlowModel/billListModel.dart';

class TopTrendingBillsModel {
  BillListModel? newBill;
  BillListModel? oldBill;

  TopTrendingBillsModel({
    this.newBill,
    this.oldBill,
  });

  factory TopTrendingBillsModel.fromJson(Map<String, dynamic> json) => TopTrendingBillsModel(
    newBill: json["new_bill"] == null ? null : BillListModel.fromJson(json["new_bill"]),
    oldBill: json["old_bill"] == null ? null : BillListModel.fromJson(json["old_bill"]),
  );

  Map<String, dynamic> toJson() => {
    "new_bill": newBill?.toJson(),
    "old_bill": oldBill?.toJson(),
  };
}

