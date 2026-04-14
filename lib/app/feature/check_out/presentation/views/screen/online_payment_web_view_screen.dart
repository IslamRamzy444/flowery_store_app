import 'package:flower_app/app/core/resources/app_colors.dart';
import 'package:flower_app/app/core/routes/app_route.dart';
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
  bool _paymentCompleted = false;
  // ignore: prefer_final_fields
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeWebView();
    });
  }

  void _initializeWebView() {
    final link = url;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (pageUrl) {
            setState(() => _isLoading = false);
            _checkPaymentSuccess(pageUrl);
          },
          onUrlChange: (change) {
            if (change.url != null) {
              _checkPaymentSuccess(change.url!);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(link));
    
    setState(() {});
  }

  void _checkPaymentSuccess(String pageUrl) {
    if (pageUrl.contains('success') || 
        pageUrl.contains('approved') || 
        pageUrl.contains('thankyou') ||
        pageUrl.contains('allOrders') ||
        pageUrl.contains('localhost:3000/allOrders')) {
      
      if (!_paymentCompleted) {
        _paymentCompleted = true;
        _navigateToSuccess();
      }
    }
  }

  void _navigateToSuccess() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.successPage,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    url = ModalRoute.of(context)?.settings.arguments as String;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _canGoBack() ? _showPaymentConfirmationDialog : null,
          icon: Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
        ),
        title: Text(
          AppLocalizations.of(context)!.online_payment_window,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: _controller == null 
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                WebViewWidget(controller: _controller!),
                if (_isLoading) 
                  Center(child: CircularProgressIndicator()),
              ],
            ),
    );
  }

  bool _canGoBack() {
    return !_isVerifying && !_paymentCompleted;
  }

  void _showPaymentConfirmationDialog() {
    if (_isVerifying) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.payment_confirmation),
        content: Text(AppLocalizations.of(context)!.was_payment_successful),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.no),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              
              if (_paymentCompleted) {
                _navigateToSuccess();
              } else {
                _showPaymentFailedDialog();
              }
            },
            child: Text(AppLocalizations.of(context)!.yes),
          ),
        ],
      ),
    );
  }

  void _showPaymentFailedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.payment_failed_title),
        content: Text(AppLocalizations.of(context)!.payment_failed_message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.continue_payment),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
        ],
      ),
    );
  }
}