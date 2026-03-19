import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../services/ad_service.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  final AdService _adService = AdService();
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    _adService.loadBannerAd(
      onAdLoaded: () {
        if (mounted) {
          setState(() {
            _isAdLoaded = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _adService.disposeBannerAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        if (settings.adsRemoved || !_isAdLoaded || _adService.bannerAd == null) {
          return const SizedBox.shrink();
        }

        return Container(
          alignment: Alignment.center,
          width: _adService.bannerAd!.size.width.toDouble(),
          height: _adService.bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _adService.bannerAd!),
        );
      },
    );
  }
}

class AdBannerContainer extends StatelessWidget {
  final Widget child;
  final bool showAtBottom;

  const AdBannerContainer({
    super.key,
    required this.child,
    this.showAtBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        if (settings.adsRemoved) {
          return child;
        }

        return Column(
          children: [
            if (!showAtBottom) const AdBannerWidget(),
            Expanded(child: child),
            if (showAtBottom) const AdBannerWidget(),
          ],
        );
      },
    );
  }
}
