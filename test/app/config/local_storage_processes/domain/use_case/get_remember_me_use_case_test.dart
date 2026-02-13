import 'package:flower_app/app/config/local_storage_processes/domain/token_repo_contract.dart';
import 'package:flower_app/app/config/local_storage_processes/domain/use_case/get_remember_me_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_remember_me_use_case_test.mocks.dart';

@GenerateMocks([TokenRepoContract])
void main() {
  late TokenRepoContract mockRepo;
  late GetRememberMeUseCase useCase;

  setUp(() {
    mockRepo = MockTokenRepoContract();
    useCase = GetRememberMeUseCase(mockRepo);
  });

  test('invoke should return value from repo', () {
    // arrange
    when(mockRepo.getRememberMe()).thenReturn(true);

    // act
    final result = useCase.invoke();

    // assert
    verify(mockRepo.getRememberMe()).called(1);
    expect(result, true);
  });

  test('invoke should return null if repo returns null', () {
    // arrange
    when(mockRepo.getRememberMe()).thenReturn(null);

    // act
    final result = useCase.invoke();

    // assert
    verify(mockRepo.getRememberMe());
    expect(result, null);
  });
}
