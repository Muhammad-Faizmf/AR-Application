class Furniture {
  // String id;
  String name;
  String image;
  String description;
  int price;
  String category;
  bool isTrending;
  String render_image;

  Furniture(
      {
      // required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.price,
      required this.category,
      required this.isTrending,
      required this.render_image});
}

final List<Furniture> furniture_list = [
  //   Furniture(name: "Lowpoly Chair", description: "chair is a type of seat, typically designed for one person and consisting of one or more legs, a flat or slightly angled seat and a back-rest.", price: 4000, category: "chair", isTrending: false, image: "images/chair1.jpg", render_image: "3d_images/chair1.glb"),

  //   Furniture(name: "Old Wooden Table", description: "The table is a basic piece of household furniture. It generally consists of a flat top that is supported by either a set of legs, pillars, or trestles.", price: 5000, category: "table", isTrending: false, image: "images/table1.jpg", render_image: "3d_images/table1.glb"),

  //   Furniture(name: " Sculpt Viking Bed for home", description: "The Lay Double Bed represents modesty and vogue. It is a low-profile bed and looks magnificent in your room.", price: 20000, category: "bed", isTrending: false, image: "images/bed1.jpg", render_image: "3d_images/bed1.glb"),

  //   Furniture(name: "Wooden Bed", description: "The Lay Double Bed represents modesty and vogue. It is a low-profile bed and looks magnificent in your room.", price: 10000, category: "bed", isTrending: true, image: "images/bed2.jpg", render_image: "3d_images/bed2.glb"),

  //   Furniture(name: "Simple Bed", description: "The Lay Double Bed represents modesty and vogue. It is a low-profile bed and looks magnificent in your room.", price: 8000, category: "bed", isTrending: false, image: "images/bed3.jpg", render_image: "3d_images/bed3.glb"),

  //   Furniture(name: "Soft Arm Chair", description: "chair is a type of seat, typically designed for one person and consisting of one or more legs, a flat or slightly angled seat and a back-rest.", price: 3000, category: "chair", isTrending: true, image: "images/chair2.jpg", render_image: "3d_images/chair2.glb"),

  //   Furniture(name: "Compouned Bed", description: "The bed is a piece of furniture which is used as a place to sleep or relax. that consist of a soft, cushioned mattress on a bed frame.", price: 5000, category: "bed", isTrending: false, image: "images/bed4.jpg", render_image: "3d_images/bed4.glb"),

  //   Furniture(name: "Living Room Sofa", description: "When it comes to shopping for your new chesterfield sofa, the first thing that will usually catch your attention is an attractive design. Finding a piece with a striking look can often be a case of love at first sight.", price: 15000, category: "sofa", isTrending: true, image: "images/sofa1.jpg",render_image: "3d_images/sofa1.glb"),

  //   Furniture(name: "Plain Old Chair", description: "chair is a type of seat, typically designed for one person and consisting of one or more legs, a flat or slightly angled seat and a back-rest.", price: 2000, category: "chair", isTrending: false, image: "images/chair3.jpg", render_image: "3d_images/chair3.glb"),

  //   Furniture(name: "Kitchen Table", description: "The table is a basic piece of household furniture. It generally consists of a flat top that is supported by either a set of legs, pillars, or trestles.", price: 7000, category: "table", isTrending: true, image: "images/table2.jpg", render_image: "3d_images/table2.glb"),

  //   Furniture(name: "Wooden Chair", description: "chair is a type of seat, typically designed for one person and consisting of one or more legs, a flat or slightly angled seat and a back-rest.", price: 2500, category: "chair", isTrending: false, image: "images/chair4.jpg", render_image: "3d_images/chair4.glb"),

  //   Furniture(name: "Coffee Table", description: "The table is a basic piece of household furniture. It generally consists of a flat top that is supported by either a set of legs, pillars, or trestles.", price: 6000, category: "table", isTrending: false, image: "images/table3.jpg", render_image: "3d_images/table3.glb"),

  //   Furniture(name: "Antique Table", description: "The table is a basic piece of household furniture. It generally consists of a flat top that is supported by either a set of legs, pillars, or trestles.", price: 5000, category: "table", isTrending: false, image: "images/table4.jpg", render_image: "3d_images/table4.glb"),

  //   Furniture(name: "Single Sofa", description: "When it comes to shopping for your new chesterfield sofa, the first thing that will usually catch your attention is an attractive design. Finding a piece with a striking look can often be a case of love at first sight.", price: 3000, category: "sofa", isTrending: false, image: "images/sofa4.jpg", render_image: "3d_images/sofa4.glb"),

  //   Furniture(name: "European Sofa", description: "When it comes to shopping for your new chesterfield sofa, the first thing that will usually catch your attention is an attractive design. Finding a piece with a striking look can often be a case of love at first sight.", price: 12000, category: "sofa", isTrending: false, image: "images/sofa3.jpg", render_image: "3d_images/sofa3.glb"),

  //   Furniture(name: "Patricia Sofa", description: "When it comes to shopping for your new chesterfield sofa, the first thing that will usually catch your attention is an attractive design. Finding a piece with a striking look can often be a case of love at first sight.", price: 17000, category: "sofa", isTrending: false, image: "images/sofa2.jpg", render_image: "3d_images/sofa2.glb"),

  //   Furniture(name: "Wardrobe 1", description: "The most frequently used furniture piece in your bedroom is your wardrobe. It holds your hand-knitted sweaters, high-prized shoes, ripped jeans, classic leather belts, long-sleeve shirts, work pants, shorts and all the accessories that you cart from your favourite fashion store.", price: 4000, category: "wardrobe", isTrending: false, image: "images/wardrobe1.jpg", render_image: "3d_images/wardrobe1.glb"),

  //   Furniture(name: "Wardrobe 2", description: "The most frequently used furniture piece in your bedroom is your wardrobe. It holds your hand-knitted sweaters, high-prized shoes, ripped jeans, classic leather belts, long-sleeve shirts, work pants, shorts and all the accessories that you cart from your favourite fashion store.", price: 9000, category: "wardrobe", isTrending: false, image: "images/wardrobe2.jpg", render_image: "3d_images/wardrobe2.glb"),

  //   Furniture(name: "Wardrobe 3", description: "The most frequently used furniture piece in your bedroom is your wardrobe. It holds your hand-knitted sweaters, high-prized shoes, ripped jeans, classic leather belts, long-sleeve shirts, work pants, shorts and all the accessories that you cart from your favourite fashion store.", price: 15000, category: "wardrobe", isTrending: false, image: "images/wardrobe3.jpg", render_image: "3d_images/wardrobe3.glb"),

  //   Furniture(name: "Wardrobe 4", description: "The most frequently used furniture piece in your bedroom is your wardrobe. It holds your hand-knitted sweaters, high-prized shoes, ripped jeans, classic leather belts, long-sleeve shirts, work pants, shorts and all the accessories that you cart from your favourite fashion store.", price: 5000, category: "wardrobe", isTrending: false, image: "images/wardrobe4.jpg", render_image: "3d_images/wardrobe4.glb"),

  //   Furniture(name: "Desk 1", description: "It is a kind of furniture with a flat or sloping surface and typically with drawers, at which one can read, write, or do other work.", price: 8000, category: "desk", isTrending: false, image: "images/desk1.jpg", render_image: "3d_images/desk1.glb"),

  //   Furniture(name: "Desk 2", description: "It is a kind of furniture with a flat or sloping surface and typically with drawers, at which one can read, write, or do other work.", price: 5000, category: "desk", isTrending: false, image: "images/desk2.jpg", render_image: "3d_images/desk2.glb"),

  //   Furniture(name: "Desk 3", description: "It is a kind of furniture with a flat or sloping surface and typically with drawers, at which one can read, write, or do other work.", price: 3000, category: "desk", isTrending: false, image: "images/desk3.jpg", render_image: "3d_images/desk3.glb"),

  //   Furniture(name: "School Desk", description: "It is a kind of furniture with a flat or sloping surface and typically with drawers, at which one can read, write, or do other work.", price: 2000, category: "desk", isTrending: false, image: "images/desk4.jpg", render_image: "3d_images/desk4.glb"),
];
