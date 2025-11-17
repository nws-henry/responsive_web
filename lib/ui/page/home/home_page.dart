import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_web/common/app_dimens.dart';
import 'package:responsive_web/common/app_images.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.COLUMN,
        rowMainAxisAlignment: MainAxisAlignment.center,
        columnMainAxisAlignment: MainAxisAlignment.start,
        children: [ResponsiveRowColumnItem(child: Header())],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveRowColumnItem(
      child: Stack(
        children: [
          _createHeaderBackground(context),
          _createActions(context),
          _createInfo(context),
        ],
      ),
    );
  }

  Widget _createHeaderBackground(BuildContext context) {
    double height = ResponsiveValue(
      context,
      defaultValue: AppDimens.desktopHeaderHeight,
      conditionalValues: [
        Condition.smallerThan(
          name: DESKTOP,
          value: AppDimens.tabletHeaderHeight,
        ),
        Condition.smallerThan(
          name: TABLET,
          value: AppDimens.mobileHeaderHeight,
        ),
      ],
    ).value;
    BoxFit boxFit = ResponsiveValue(
      context,
      defaultValue: BoxFit.cover,
      conditionalValues: [
        Condition.smallerThan(name: "XL", value: BoxFit.cover),
        Condition.largerThan(name: "XL", value: BoxFit.fill),
      ],
    ).value;
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Image.asset(
        fit: boxFit,
        AppImages.imgHeader,
        alignment: Alignment.bottomRight,
      ),
    );
  }

  Widget _createActions(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;

    double right = ResponsiveValue<double>(
      context,
      conditionalValues: [
        Condition.smallerThan(name: DESKTOP, value: 40),
        Condition.equals(name: MOBILE, value: 20),
      ],
      defaultValue: 122,
    ).value;

    double? left = ResponsiveValue<double?>(
      context,
      defaultValue: null,
      conditionalValues: [Condition.equals(name: MOBILE, value: 20)],
    ).value;

    Widget createLoginButton() {
      return OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("İletişim", style: TextStyle(color: Colors.white)),
      );
    }

    Widget createMobileActionButtons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          createLoginButton(),
        ],
      );
    }

    Widget createActionButtons() {
      return Row(
        spacing: 40,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 200,
            ),
            child: Wrap(
              spacing: 40,
              runSpacing: 16,
              alignment: WrapAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text("Çözüm ve Hizmetler"),
                ),
                GestureDetector(onTap: () {}, child: Text("Ürünler")),
                GestureDetector(onTap: () {}, child: Text("Teknolojiler")),
                GestureDetector(onTap: () {}, child: Text("İnsan Kaynakları")),
                GestureDetector(onTap: () {}, child: Text("Kurumsal")),
              ],
            ),
          ),
          createLoginButton(),
        ],
      );
    }

    return Positioned(
      top: 45,
      left: left,
      right: right,
      child: isMobile ? createMobileActionButtons() : createActionButtons(),
    );
  }

  Widget _createInfo(BuildContext context) {
    return Positioned(
      left: 84,
      bottom: 124,
      child: SizedBox(
        width: 665,
        height: 359,
        child: ResponsiveRowColumn(
          layout: ResponsiveRowColumnType.COLUMN,
          children: [
            ResponsiveRowColumnItem(
              child: Text(
                "Bilgi Teknolojilerinde 23 Yıllık Tecrübe",
                style: TextStyle(fontSize: 56, fontWeight: FontWeight.w700),
              ),
            ),
            ResponsiveRowColumnItem(
              child: Text(
                "Müşterilerimizin yüksek kalite seviyelerini koruyabilmeleri için farklı sektörlerde tecrübe kazanmış uzman kadrolarımızla Proje Yönetimi, İş Analizi ve Test Yönetimi hizmetleri sunmaktayız.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            ResponsiveRowColumnItem(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(),
                  suffixIcon: OutlinedButton(
                    style: OutlinedButton.styleFrom(backgroundColor: Colors.red, ),
                    onPressed: () {},
                    child: Text("Kayıt Ol"),
                  ),
                  hint: Text("Mail bültenimize kayıt ol"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
