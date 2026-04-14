const String imagePath = "assets/images";
const String iconsPath = "assets/icons";
const String svgPath = "assets/svg";
const String filesPath="assets/files";
abstract class AssetsImage {
  static const String flower='$imagePath/Flower.png';
  static const String user='$imagePath/user.jpg';
  static const String successLogo='$imagePath/success-logo.png';

}

abstract class AssetsIcons {
  static const String logo = '$iconsPath/flower_logo.png';
  static const String dropIcon='$iconsPath/drop -down icon.png';
  static const String homeIcon='$iconsPath/home-icon.png';
}

abstract class AssetsSvg {
  static const String logoSvg = '$svgPath/flower_logo.svg';
  static const String carSvg = '$svgPath/Car.svg';
  static const String homeSvg='$iconsPath/home-icon.svg';
}
abstract class AssetsFiles{
  static const String aboutAppFile='$filesPath/Flowery About Section JSON with Expanded Content.json';
  static const String termsFile='$filesPath/Flowery Terms and Conditions JSON with Arabic and English.json';
}