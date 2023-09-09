import '../../domain/repository/onboard_repository.dart';
import '../dto/onboard_item_dto.dart';

/**
 * Implements of repository for onboard screen.
 */
class OnboardRepository extends AbstractOnboardRepository {
  @override
  Future<List<OnboardItemDTO>> getItems() async {
    List<OnboardItemDTO> items = [
      OnboardItemDTO(
        color: '#ffe24e',
        title: 'Test #1',
        image: 'assets/images/onboarding/onboarding0.svg',
        description: "Description for test #1.",
        skip: true,
      ),
      OnboardItemDTO(
        color: '#a3e4f1',
        title: 'Test #2',
        image: 'assets/images/onboarding/onboarding1.svg',
        description: "Description for test #2.",
        skip: true,
      ),
      OnboardItemDTO(
        color: '#31b77a',
        title: 'Test #3',
        image: 'assets/images/onboarding/onboarding2.svg',
        description: "Description for test #3.",
        skip: false,
      ),
    ];

    return items;
  }
}
