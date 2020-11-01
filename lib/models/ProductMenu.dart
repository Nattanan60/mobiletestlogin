class ProductMenu {
  var image, title, conship;
  var price, size, id;
  var color;
  var salotion;

  ProductMenu(
    this.id,
    this.image,
    this.title,
    this.price,
    this.color,
    this.size,
    this.conship,
    this.salotion,
  );
  ProductMenu.formMap(Map<dynamic, dynamic> map) {
    title = map['tiltile'];
    id = map['id'];
    image = map['PathImage'];
    conship = map['conship'];
    salotion = map['salotion'];
  }
}
