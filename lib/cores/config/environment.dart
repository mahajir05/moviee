enum EFlavor { dev, prod }

class Environment {
  static EFlavor flavor = EFlavor.dev;

  static String baseUrlV3() {
    switch (flavor) {
      case EFlavor.dev:
        return 'https://api.themoviedb.org/3';
      case EFlavor.prod:
        return 'https://api.themoviedb.org/3';
      default:
        return 'https://api.themoviedb.org/3';
    }
  }

  static String apiKey() {
    switch (flavor) {
      case EFlavor.dev:
        return '5dc890d0bb4a188ae125469804d02828';
      case EFlavor.prod:
        return '5dc890d0bb4a188ae125469804d02828';
      default:
        return '5dc890d0bb4a188ae125469804d02828';
    }
  }
}
