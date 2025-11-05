import 'package:flutter/material.dart';
import 'package:my_portfolio/features/home/presentation/widgets/hire_me_button.dart';
import 'package:provider/provider.dart';
import 'package:my_portfolio/core/utils/size_configs.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/theme_manager.dart';
import '../../../aboutme/presentation/pages/about_section.dart';
import '../../../contactme/presentation/pages/contact_section.dart';
import '../../../projects/presentation/pages/projects_section.dart';
import '../widgets/home_section.dart';
import '../widgets/portfolio_drawer.dart';

class PortfolioTabsView extends StatefulWidget {
  const PortfolioTabsView({Key? key}) : super(key: key);

  @override
  State<PortfolioTabsView> createState() => _PortfolioTabsViewState();
}

class _PortfolioTabsViewState extends State<PortfolioTabsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ["Home", "About me", "Portfolio", "Contact me"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context) || Responsive.isTablet(context)) {
      return _buildDesktopLayout(context);
    } else {
      return _buildMobileLayout(context);
    }
  }

  // 📱 Mobile Layout
  Widget _buildMobileLayout(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [Colors.blue, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
          child: const Icon(Icons.code, size: 40, color: Colors.white),
        ),
      ),
      drawer: PortfolioDrawer(tabController: _tabController, tabs: _tabs),
      body: _buildTabViews(),
    );
  }

  // 💻 Desktop / Tablet Layout
  Widget _buildDesktopLayout(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final color = Theme.of(context).primaryColor;

    final screenWidth = MediaQuery.of(context).size.width;

    // 📏 تحديد المسافات حسب نوع الجهاز
    final horizontalPadding =
        Responsive.isDesktop(context)
            ? 80.0
            : Responsive.isTablet(context)
            ? 40.0
            : 20.0;

    final tabSpacing =
        Responsive.isDesktop(context)
            ? 60.0 // مسافات واسعة على الديسكتوب
            : Responsive.isTablet(context)
            ? 30.0 // متوسطة على التابلت
            : 15.0; // أقل على الموبايل (لو استخدمناه)

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: 18,
            ),
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback:
                          (bounds) => const LinearGradient(
                            colors: [Colors.blue, Colors.deepPurpleAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                      child: const Icon(
                        Icons.code,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),

                    // 🧭 Tabs Navigation (Expanded + Wrap تمنع الـRenderFlex)
                    Expanded(
                      child: Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: tabSpacing,
                          runSpacing: 10,
                          children:
                              _tabs.map((t) {
                                final index = _tabs.indexOf(t);
                                final selected = _tabController.index == index;
                                return InkWell(
                                  onTap: () {
                                    _tabController.animateTo(index);
                                    setState(() {});
                                  },
                                  child: Text(
                                    t,
                                    style: TextStyle(
                                      fontSize:
                                          Responsive.isDesktop(context)
                                              ? 18
                                              : 16,
                                      fontWeight:
                                          selected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                      color: selected ? color : Colors.white70,
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),

                    // 🌈 Buttons + Theme Controls
                    Wrap(
                      spacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [HireMeButton()],
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(child: _buildTabViews()),
        ],
      ),
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      controller: _tabController,
      children: const [
        HomeSection(),
        AboutSection(),
        Projectssection(),
        ContactMeSection(),
      ],
    );
  }
}
