import '../../data/dto/onboard_item_dto.dart';

/**
 * Abstrac class for onboard operations.
 */
abstract class AbstractOnboardRepository {
  Future<List<OnboardItemDTO>> getItems();
}
