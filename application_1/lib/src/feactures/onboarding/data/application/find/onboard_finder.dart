import '../../dto/onboard_item_dto.dart';
import '../../repository/onboard_repository.dart';

/**
 * Use case for find elements related to onboard screen.
 */
class OnboardFinder {
  OnboardFinder(this.repository);

  final OnboardRepository repository;

  Future<List<OnboardItemDTO>> getItems() async {
    return repository.getItems();
  }
}
