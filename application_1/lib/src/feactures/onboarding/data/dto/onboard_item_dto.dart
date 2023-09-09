/**
 * DTO for represent a element for onboard.
 */
class OnboardItemDTO {
  final String color;
  final String image;
  final String title;
  final String description;
  final bool skip;

  OnboardItemDTO({
    required this.color,
    required this.title,
    required this.description,
    required this.image,
    required this.skip,
  });
}
