import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/feature/success_page_flowery_app/presentation/view/screen/success_page_flowery_app_screen.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(){
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SuccessPageFloweryAppScreen(),
    );
  }
  testWidgets('checking success page flowery app screen renders its elements successfully', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    final l10n = AppLocalizations.of(tester.element(find.byType(SuccessPageFloweryAppScreen)));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
    final iconButton = tester.widget<IconButton>(find.byType(IconButton));
    expect((iconButton.icon as Icon).color, AppColors.blackColor);
    expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);
    final ElevatedButton button = tester.widget(buttonFinder);
    expect((button.child as Text).data, l10n!.track_order);
    expect(find.byType(Text), findsNWidgets(3));
    expect(find.text(l10n.track_order), findsNWidgets(2));
    expect(find.text(l10n.success_placing_order), findsOneWidget);
  });
}