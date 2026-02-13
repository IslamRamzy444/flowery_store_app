import 'package:flower_app/app/config/base_response/base_response.dart';
import 'package:flower_app/app/config/local_storage_processes/data/token_repo_impl.dart';
import 'package:flower_app/app/config/local_storage_processes/domain/storage_data_source_contract.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'token_repo_impl_test.mocks.dart';

@GenerateMocks([StorageDataSourceContract])
void main() {
  late StorageDataSourceContract mockDataSource;
  late TokenRepoImpl repo;

  setUp(() {
    mockDataSource = MockStorageDataSourceContract();
    repo = TokenRepoImpl(mockDataSource);
  });

  // ---------------- clearToken ----------------
  test('clearToken should delegate to data source', () async {
    // arrange
    provideDummy<BaseResponse<bool>>(SuccessResponse(data: true));
    when(
      mockDataSource.clearToken(),
    ).thenAnswer((_) async => SuccessResponse(data: true));
    when(
      mockDataSource.clearRememberMe(),
    ).thenAnswer((_) async => SuccessResponse(data: true));
    // act
    final result = await repo.clearToken() as SuccessResponse<bool>;

    // assert
    expect(result, isA<SuccessResponse<bool>>());
    expect(result.data, true);
    verify(mockDataSource.clearToken());
    verify(mockDataSource.clearRememberMe());
  });

  // ---------------- getRememberMe ----------------
  test('getRememberMe should delegate to data source', () {
    // arrange
    when(mockDataSource.getRememberMe()).thenReturn(true);

    // act
    final result = repo.getRememberMe();

    // assert
    verify(mockDataSource.getRememberMe());
    expect(result, true);
  });
  // ---------------- getToken ----------------
  test('gettoken should delegate to data source', () async {
    // arrange
    when(
      mockDataSource.getToken(),
    ).thenAnswer((realInvocation) => Future.value('token'));

    // act
    final result = await repo.getToken();

    // assert
    verify(mockDataSource.getToken());
    expect(result, 'token');
  });
}
