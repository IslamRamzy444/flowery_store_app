abstract class AppEndPoint {
  static const String baseUrl = "https://flower.elevateegy.com/api/v1";
  // Authentication Endpoints
  static const String changePassword = '/auth/change-password';
  static const String login = "/auth/signin";
  static const String signUp = '/auth/signup';
  //tabs end points
  static const String home='/home';
  static const String forgetPassword='/auth/forgotPassword';
  static const String verifyOtp='/auth/verifyResetCode';
  static const String resetPassword='/auth/resetPassword';
  static const String products = "/products";

  // profile
  static const String profile = '/auth/profile-data';
  static const String updateProfile = '/auth/editProfile';
  static const String uploadPhoto = '/auth/upload-photo';
  //cart end points

  // this end point used for adding products to cart AND to get logged user cart
  static const String cart = "/cart";

  //this end point used for updateing cart quantity (letting the server know that the quantity is increased)
  //and to delete item cart
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
  static const String allOccasions = '/occasions';
  static const String allCategories = '/categories';
}
