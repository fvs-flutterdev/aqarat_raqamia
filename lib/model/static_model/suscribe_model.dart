class SubscribeModel {
  int id;
  String title;
  bool isTabbed;

  SubscribeModel(
      {required this.id, required this.title, required this.isTabbed});
}

List<SubscribeModel> subscribeModel = [
  SubscribeModel(id: 0, title: "الدفع عبر المحفظة", isTabbed: false),
  SubscribeModel(
      id: 1, title: "الدفع عبر البطاقه الإلكترونية", isTabbed: false),
];
