import 'package:flower_app/app/config/local_storage_processes/domain/token_repo_contract.dart';
import 'package:flower_app/app/config/local_storage_processes/domain/use_case/get_token_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_remember_me_use_case_test.mocks.dart';

void main() {
  late TokenRepoContract mockRepo;
  late GetTokenUseCase tokenUseCase;

  setUp(() {
    mockRepo = MockTokenRepoContract();
    tokenUseCase = GetTokenUseCase(mockRepo);
  });

  test('invoke should return value from repo', () async {
    // arrange
    when(
      mockRepo.getToken(),
    ).thenAnswer((realInvocation) => Future.value('token'));

    // act
    final result = await tokenUseCase.invoke();

    // assert
    verify(mockRepo.getToken()).called(1);
    expect(result, 'token');
  });

  test('invoke should return null if repo returns null', () async {
    // arrange
    when(
      mockRepo.getToken(),
    ).thenAnswer((realInvocation) => Future.value(null));

    // act
    final result = await tokenUseCase.invoke();

    // assert
    verify(mockRepo.getToken());
    expect(result, null);
  });
}
