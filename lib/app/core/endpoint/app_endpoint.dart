abstract class AppEndPoint {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";

  // Authentication Endpoints
  static const String changePassword = '/auth/change-password';
  static const String login = "/auth/signin";
  static const String signUp = '/auth/signup';

  // Tabs / auth flows
  static const String home = '/home';
  static const String forgetPassword = '/auth/forgotPassword';
  static const String verifyOtp = '/auth/verifyResetCode';
  static const String resetPassword = '/auth/resetPassword';

  // Occasion Endpoints
  static const String occasions = '/occasions';
  static String occasionById(String id) => '/occasions/$id';

  // Product Endpoints
  // Detail endpoint from develop branch
  static const String products = "/products/{productId}";
  // List endpoint used for general product listing
  static const String productsList = '/products';
  static String productsByOccasion(String occasionId) =>
      '/products?occasion=$occasionId';

  // Profile
  static const String profile = '/auth/profile-data';
  static const String updateProfile = '/auth/editProfile';
  static const String uploadPhoto = '/auth/upload-photo';

  // Cart endpoints
  // Used for adding products to cart AND to get logged user cart
  static const String cart = "/cart";
  // Used for updating cart quantity and deleting cart items
  static const String updateCart = "/cart/{productId}";

  // addresses end points
  static const String addAddresses = '/addresses';
  static const String updateAddresses = '/addresses/{addressId}';
  // Best Seller endpoint
  static const String bestSeller = "/best-seller";
  
  // Address endpoint
  static const String address = "/addresses";
  //this end point used for checkout page, ether cash on delivery or Credit card
  static const String cashOnDelivery='/orders';
  static const String creditCard ='/orders/checkout?url=http://localhost:3000';
}
