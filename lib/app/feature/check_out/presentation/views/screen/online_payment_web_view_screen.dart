import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnlinePaymentWebViewScreen extends StatefulWidget {
  const OnlinePaymentWebViewScreen({super.key});

  @override
  State<OnlinePaymentWebViewScreen> createState() => _OnlinePaymentWebViewScreenState();
}

class _OnlinePaymentWebViewScreenState extends State<OnlinePaymentWebViewScreen> {
  WebViewController? _controller;
  late String url;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final link=url;
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate( 
            onPageFinished: (_) {
              setState(() => _isLoading = false);
            },
          ),
        )
        ..loadRequest(Uri.parse(link));
        setState(() {});
    },);
  }
  @override
  Widget build(BuildContext context) {
    url=ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back_ios,color: AppColors.blackColor,)
        ),
        title: Text(AppLocalizations.of(context)!.online_payment_window,style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body:_controller==null?Center(child: CircularProgressIndicator()):
      Stack(
        children: [
          WebViewWidget(controller: _controller!,),
          if(_isLoading)Center(child: CircularProgressIndicator(),)
        ],
      ) ,
    );
  }
}