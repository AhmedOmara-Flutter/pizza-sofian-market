import '../../../../core/cubit/product_cubit/product_cubit.dart';
import '../../../../core/models/category_model.dart';
import '../../../../core/utils/app_imports.dart';
import 'tap_bar_view_body.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs>
    with SingleTickerProviderStateMixin {
  final List<CategoryModel> categories = const [
    CategoryModel(
      id: 'فطير شرقي',
      name: 'فطير شرقي',
      sizes: ['صغير', 'وسط', 'كبير'],
    ),
    CategoryModel(
      id: 'ميكسات فطير',
      name: 'ميكسات فطير',
      sizes: ['صغير', 'وسط', 'كبير'],
    ),
    CategoryModel(
      id: 'فطائر حلو',
      name: 'فطائر حلو',
      sizes: ['صغير', 'وسط', 'كبير'],
    ),
    CategoryModel(
      id: 'بيتزا ايطالي',
      name: 'بيتزا ايطالي',
      sizes: ['صغير', 'وسط', 'كبير','XL'],
    ),
    CategoryModel(
      id: 'ميكسات بيتزا',
      name: 'ميكسات بيتزا',
      sizes: ['صغير', 'وسط', 'كبير','XL'],
    ),
    CategoryModel(
      id: 'فطائر صاروخ',
      name: 'فطائر صاروخ',
      sizes: [],
    ),
    CategoryModel(
      id: 'فطائر تركيه',
      name: 'فطائر تركيه',
      sizes: [],
    ),
    CategoryModel(
      id: 'باستا نجرسكو وايت صوص',
      name: 'باستا نجرسكو وايت صوص',
      sizes: ['وسط', 'كبير'],
    ),
    CategoryModel(
      id: 'كاليزوني ايطالي',
      name: 'كاليزوني ايطالي',
      sizes: ['صغير', 'وسط', 'كبير'],
    ),
    CategoryModel(
      id: 'مقبلات سفيانو',
      name: 'مقبلات سفيانو',
      sizes: ['صغير', 'كبير'],
    ),
    CategoryModel(
      id: 'كريب الجبن',
      name: 'كريب الجبن',
      sizes: ['عادي', 'رول', 'كونو'],
    ),
    CategoryModel(
      id: 'كريب الفراخ',
      name: 'كريب الفراخ',
      sizes: ['عادي', 'رول', 'كونو'],
    ),
    CategoryModel(
      id: 'كريب اللحوم',
      name: 'كريب اللحوم',
      sizes: ['عادي', 'رول', 'كونو'],
    ),
    CategoryModel(
      id: 'كريب السي فود',
      name: 'كريب السي فود',
      sizes: ['عادي', 'رول', 'كونو'],
    ),
    CategoryModel(
      id: 'ميكسات كريب سفيانو',
      name: 'ميكسات كريب سفيانو',
      sizes: ['عادي', 'رول', 'كونو'],
    ),
    CategoryModel(
      id: 'كريب حلو',
      name: 'كريب حلو',
      sizes: ['كريب', 'رول'],
    ),
    CategoryModel(
      id: 'فطير مشلتت مخصوص',
      name: 'فطير مشلتت مخصوص',
      sizes: ['صغير', 'وسط', 'كبير'],
    ),
    CategoryModel(
      id: 'وجبه عربي فطير',
      name: 'وجبه عربي فطير',
      sizes: [],
    ),
    CategoryModel(
      id: 'اكسترا سفيانو',
      name: 'اكسترا سفيانو',
      sizes: ['صغير', 'وسط', 'كبير','XL'],
    ),
    CategoryModel(
      id: 'المشروبات',
      name: 'المشروبات',
      sizes: [],
    ),
    CategoryModel(
      id: 'المعجنات',
      name: 'المعجنات',
      sizes: ['صغير', 'وسط', 'كبير','XL','عيش كريب'],
    ),
    CategoryModel(
      id: 'الوجبات',
      name: 'الوجبات',
      sizes: [],
    ),
    CategoryModel(
      id: 'سندويتشات سوري',
      name: 'سندويتشات سوري',
      sizes: ['صغير', 'وسط', 'كبير'],
    ),
    CategoryModel(
      id: 'سندويتشات فرنساوي',
      name: 'سندويتشات فرنساوي',
      sizes: ['صغير', 'وسط', 'كبير'],
    ),
    CategoryModel(
      id: 'سندويتشات برجر',
      name: 'سندويتشات برجر',
      sizes: ['سنجل','دابل'],
    ),
  ];

  late final TabController _tabController;

  int selectedCategoryIndex = 0;

  final Map<String, String?> selectedSizes = {};

  CategoryModel get selectedCategory =>
      categories[selectedCategoryIndex];

  String? get selectedSize =>
      selectedSizes[selectedCategory.name];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: categories.length,
      vsync: this,
    );

    for (final category in categories) {
      if (category.sizes.isNotEmpty) {
        selectedSizes[category.name] = category.sizes.first;
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filterProducts();
    });

    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;

    setState(() {
      selectedCategoryIndex = _tabController.index;
    });

    _filterProducts();
  }

  void _filterProducts() {
    context.read<ProductCubit>().filterProducts(
      selectedCategory.name,
      size: selectedSize,
    );
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52.h,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          child: TabBar(
            splashFactory: NoSplash.splashFactory,
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicator: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: BorderRadius.circular(25.r),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: AppColor.textSecondary,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(
              Colors.transparent,
            ),
            splashBorderRadius: BorderRadius.circular(25.r),
            tabs: categories.map((category) {
              return Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  child: Text(category.name),
                ),
              );
            }).toList(),
          ),
        ),

        if (selectedCategory.sizes.isNotEmpty) ...[
          SizedBox(height: 10.h),
          _buildSizes(),
        ],

        SizedBox(height: 10.h),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: categories.map((category) {
              return TapBarViewBody(
                category: category.name,
                size: category.name == selectedCategory.name
                    ? selectedSize
                    : null,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSizes() {
    final sizes = selectedCategory.sizes;

    if (sizes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 55.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.straighten_outlined,
                size: 20.sp,
                color: AppColor.mainColor,
              ),
              SizedBox(width: 7.w),
              Text(
                'الحجم',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: sizes.map((size) {
              final isSelected =
                  selectedSizes[selectedCategory.name] == size;

              return Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: () {
                    setState(() {
                      selectedSizes[selectedCategory.name] = size;
                    });

                    _filterProducts();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 45.w,
                    height: 45.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.mainColor
                          : AppColor.card,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColor.mainColor
                            : AppColor.border,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      size,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColor.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}