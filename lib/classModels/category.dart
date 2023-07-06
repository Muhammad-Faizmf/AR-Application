class Category {
  String iconPath;
  String title;

  Category({required this.iconPath, required this.title});
}

final List<Category> category = [
  Category(iconPath: "images/chair.svg", title: "Chair"),
  Category(iconPath: "images/bed.svg", title: "Bed"),
  Category(iconPath: "images/table.svg", title: "Table"),
  Category(iconPath: "images/sofa.svg", title: "Sofa"),
  Category(iconPath: "images/wardrobe.svg", title: "Wardrobe"),
  Category(iconPath: "images/desk.svg", title: "Desk"),
];
