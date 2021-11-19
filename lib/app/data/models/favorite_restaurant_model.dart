class FavoriteRestaurant {
  String? id;
  String? pictureId;
  String? name;
  String? rating;
  String? city;

  FavoriteRestaurant({
    this.id,
    this.pictureId,
    this.name,
    this.rating,
    this.city,
  });

  Map<String, dynamic> toMap() => ({
        'id': id,
        'pictureId': pictureId,
        'name': name,
        'rating': rating,
        'city': city,
      });

  FavoriteRestaurant.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    pictureId = map['pictureId'];
    name = map['name'];
    rating = map['rating'];
    city = map['city'];
  }
}
