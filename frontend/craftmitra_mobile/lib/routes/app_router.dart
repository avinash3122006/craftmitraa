import 'package:flutter/material.dart';
import '../providers/ai_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import '../screens/artisan/ai_preview.dart';
import '../screens/artisan/ai_processing.dart';
import '../screens/artisan/artisan_home.dart';
import '../screens/artisan/capture_product.dart';
import '../screens/artisan/voice_input.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/auth/splash_screen.dart';
import '../screens/common/notifications.dart';
import '../screens/common/settings.dart';
import '../screens/customer/cart.dart';
import '../screens/customer/customer_home.dart';
import '../screens/customer/marketplace.dart';
import '../screens/customer/order_tracking.dart';

class AppRoutes {
  static const String splash = '/';
  static const String roleSelection = '/role-selection';
  static const String login = '/login';
  static const String customerHome = '/customer-home';
  static const String marketplace = '/marketplace';
  static const String cart = '/cart';
  static const String orderTracking = '/order-tracking';
  static const String artisanHome = '/artisan-home';
  static const String captureProduct = '/capture-product';
  static const String voiceInput = '/voice-input';
  static const String aiProcessing = '/ai-processing';
  static const String aiPreview = '/ai-preview';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
}

class AppRouter {
  static final ProductProvider sharedProductProvider = ProductProvider();
  static final CartProvider sharedCartProvider = CartProvider();
  static final OrderProvider sharedOrderProvider = OrderProvider();
  static final AIProvider sharedAIProvider = AIProvider();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen(), settings: settings);

      case AppRoutes.roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen(), settings: settings);

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen(), settings: settings);

      case AppRoutes.customerHome:
        return MaterialPageRoute(builder: (_) => const CustomerHomeScreen(), settings: settings);

      case AppRoutes.marketplace:
        return MaterialPageRoute(
          builder: (_) => MarketplaceScreen(
            productProvider: sharedProductProvider,
            cartProvider: sharedCartProvider,
          ),
          settings: settings,
        );

      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (_) => CartScreen(
            cartProvider: sharedCartProvider,
            orderProvider: sharedOrderProvider,
          ),
          settings: settings,
        );

      case AppRoutes.orderTracking:
        return MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(orderProvider: sharedOrderProvider),
          settings: settings,
        );

      case AppRoutes.artisanHome:
        return MaterialPageRoute(builder: (_) => const ArtisanHomeScreen(), settings: settings);

      case AppRoutes.captureProduct:
        return MaterialPageRoute(
          builder: (_) => CaptureProductScreen(
            productProvider: sharedProductProvider,
            aiProvider: sharedAIProvider,
          ),
          settings: settings,
        );

      case AppRoutes.voiceInput:
        return MaterialPageRoute(
          builder: (_) => VoiceInputScreen(
            productProvider: sharedProductProvider,
            aiProvider: sharedAIProvider,
          ),
          settings: settings,
        );

      case AppRoutes.aiProcessing:
        return MaterialPageRoute(
          builder: (_) => AIProcessingScreen(
            productProvider: sharedProductProvider,
            aiProvider: sharedAIProvider,
          ),
          settings: settings,
        );

      case AppRoutes.aiPreview:
        return MaterialPageRoute(
          builder: (_) => AIPreviewScreen(
            productProvider: sharedProductProvider,
            aiProvider: sharedAIProvider,
          ),
          settings: settings,
        );

      case AppRoutes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen(), settings: settings);

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen(), settings: settings);

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
    }
  }
}
