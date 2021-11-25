class Meal {
  final String mealId;
  final String mealCategory;
  final String title;
  final String imageUrl;
  final String description;
  final int price;
  final bool isAvailable;

  Meal({
    this.mealId,
    this.title,
    this.mealCategory = 'Makanan',
    this.imageUrl =
        'https://d1bpj0tv6vfxyp.cloudfront.net/articles/17935_11-11-2020_13-6-3.jpeg',
    this.description = '',
    this.price,
    this.isAvailable,
  });
}
