import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/app/config/local_storage_processes/domain/use_case/get_token_use_case.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/app_tab.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_intent.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_states.dart';
import 'package:flower_app/app/feature/home/presentation/view_model/home_view_model.dart';
import 'package:flower_app/app/feature/home/presentation/views/tabs/cart/presentation/view_model/cart_screen_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'home_view_model_test.mocks.dart';

@GenerateMocks([GetTokenUseCase,CartScreenViewModel])
void main() {
  late GetTokenUseCase getTokenUseCase;
  late CartScreenViewModel cartScreenViewModel;
  late HomeViewModel homeViewModel;
  setUp(() {
    GetIt.I.reset();
    cartScreenViewModel=MockCartScreenViewModel();
    GetIt.I.registerSingleton<CartScreenViewModel>(cartScreenViewModel);
    getTokenUseCase = MockGetTokenUseCase();
    homeViewModel = HomeViewModel(getTokenUseCase);
  },);
  tearDownAll(() {
    GetIt.I.reset();
  },);
  group('test cases of home view model',() {
    test('checking that initial state is home tab)',(){
      expect(homeViewModel.state.currAppTab, AppTab.home);
      expect(homeViewModel.state.currAppTab.index, isZero);
    });
    test('checking switching to any tab', () {
      homeViewModel.doIntent(ChangeCurrentTabAction(AppTab.cart));
      expect(homeViewModel.state.currAppTab, AppTab.cart);
      expect(homeViewModel.state.currAppTab.index, equals(2));
    },);
    test('checking switching between multiple tabs', () {
      homeViewModel.doIntent(ChangeCurrentTabAction(AppTab.categories));
      expect(homeViewModel.state.currAppTab, AppTab.categories);
      expect(homeViewModel.state.currAppTab.index, equals(1));
      homeViewModel.doIntent(ChangeCurrentTabAction(AppTab.profile));
      expect(homeViewModel.state.currAppTab, AppTab.profile);
      expect(homeViewModel.state.currAppTab.index, equals(3));
    },);
    test('checking that pressing the same tab twice is handled properly', () {
      homeViewModel.doIntent(ChangeCurrentTabAction(AppTab.categories));
      homeViewModel.doIntent(ChangeCurrentTabAction(AppTab.categories));
      expect(homeViewModel.state.currAppTab, AppTab.categories);
      expect(homeViewModel.state.currAppTab.index, equals(1));
    },);
  },);
  blocTest(
    'when calling do intent with get token action it must emit correct state',
    setUp: () {
      provideDummy<String?>('token');
      when(getTokenUseCase.invoke()).thenAnswer((realInvocation) =>
          Future.value('token'));
    },
    build: () => homeViewModel,
    act: (bloc) => bloc.doIntent(GetTokenAction()),
    expect: () {
      var state = HomeStates(isLoggedIn: false, currAppTab: AppTab.home);
      return [
        state.copyWith(isLoggedIn: true),
      ];
    },);
  blocTest(
    'when calling do intent with get token action and token is null it must emit correct state',
    setUp: () {
      provideDummy<String?>(null);
      when(getTokenUseCase.invoke()).thenAnswer((realInvocation) =>
          Future.value(null));
    },
    build: () => homeViewModel,
    act: (bloc) => bloc.doIntent(GetTokenAction()),
    expect: () {
      var state = HomeStates(isLoggedIn: false, currAppTab: AppTab.home);
      return [
        state.copyWith(isLoggedIn: false),
      ];
    },);


}