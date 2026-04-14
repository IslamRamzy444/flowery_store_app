abstract class AppEndPoint {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";

  // Authentication Endpoints
  static const String changePassword = '/auth/change-password';
  static const String login = "/auth/signin";
  static const String signUp = '/auth/signup';
  static const String forgetPassword = '/auth/forgotPassword';
  static const String verifyOtp = '/auth/verifyResetCode';
  static const String resetPassword = '/auth/resetPassword';
  //tabs end points
  static const String home = '/home';
  static const String products = "/products";
  // Tabs Endpoints
  

  // Occasion Endpoints
  static const String occasions = '/occasions';
  static const String allOccasions = '/occasions';
  static String occasionById(String id) => '/occasions/$id';

  // Product Endpoints
  static const String productsList = '/products';
  static String productsByOccasion(String occasionId) =>
      '/products?occasion=$occasionId';

  // Orders Endpoints
  static const String orders = '/orders';
  static const String createCashOrder = '/orders';
  static const String checkoutSession = '/orders/checkout';

  // Profile Endpoints
  static const String profile = '/auth/profile-data';
  static const String updateProfile = '/auth/editProfile';
  static const String uploadPhoto = '/auth/upload-photo';

  // Cart Endpoints
  static const String cart = "/cart";
  static const String updateCart = "/cart/{productId}";

  // Address Endpoints
  static const String addAddresses = '/addresses';
  static const String updateAddresses = '/addresses/{addressId}';
  static const String address = "/addresses";

  // Best Seller Endpoint
  static const String bestSeller = "/best-seller";

  // Checkout Endpoints
  static const String cashOnDelivery = '/orders';
  static const String creditCard = '/orders/checkout?url=http://localhost:3000';

  // Categories Endpoint
  // Address endpoint
  
  //this end point used for checkout page, ether cash on delivery or Credit card
  static const String allCategories = '/categories';

  // Notifications endpoints
  static const String getNotifications = '/notifications/user';
  static const String getUnreadCount = '/notifications/unread-count';
  static const String markNotificationsRead = '/notifications/mark-read';
  static const String markAllNotificationsRead = '/notifications/mark-all-read';
  static const String clearAllNotifications = '/notifications/clear-all';
}
