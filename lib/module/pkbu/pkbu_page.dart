import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yoshua_ui_test/module/pkbu/bloc/pkbu_bloc.dart';
import 'package:yoshua_ui_test/widget/FlushBar.dart';
import 'package:yoshua_ui_test/widget/custom_app_bar.dart';

import '../../api/endpoint/PKBU/pkbu_response.dart';
import '../../api/endpoint/PKBU/pkbu_response_data.dart';
import '../../helper/constant.dart';
import '../../helper/custom_size.dart';
import '../../helper/preferences.dart';
import '../../util/NoOverScrollGlow.dart';
import '../../widget/navigators.dart';

class PkbuPage extends StatefulWidget {
  const PkbuPage({Key? key}) : super(key: key);

  @override
  State<PkbuPage> createState() => _PkbuPageState();
}

class _PkbuPageState extends State<PkbuPage> {
  final TextEditingController _searchInput = TextEditingController();

  PkbuResponse? data;

  int pageNumber = 0;

  PagingController<int, PkbuResponseData> pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pagingController.addPageRequestListener((pageKey) => fetch(pageKey));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PkbuBloc, PkbuState>(
      listener: (context, state) {
        // TODO: implement listener
        if(state is onGetDataSuccess){
          setState(() {
            pageNumber = 0;
          });
          PkbuResponse pkbuResponse = state.data;

          if (pkbuResponse.get_company_response.length < 10) {
            pagingController.appendLastPage(pkbuResponse.get_company_response);
          } else {
            pagingController.appendPage(pkbuResponse.get_company_response, state.nextIndex);
          }
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Lihat PK/BU',
          arrowBackTapped: () {
            Preferences.getInstance().remove(SharedPreferenceKey.IS_LOGIN);
            Navigators.pop(context);
          },
          flexibleSpace: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Image.asset(
                "assets/image/bg_appbar_smile.png",
                fit: BoxFit.fill,
              )),
        ),
        body: RefreshIndicator(
          color: Colors.black,
          onRefresh: () async {
            pagingController.refresh();
          },
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: Cmdof().custH(0.01, context),
                ),
                headerSearch(),
                SizedBox(height: 20,),
                BodyData(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerSearch() {
    return Container(
      height: Cmdof().custH(0.07, context),
      width: Cmdof().custW(1, context),
      child: Row(
        children: [
          Container(
              width: Cmdof().custW(0.75, context),
              padding: EdgeInsets.only(right: 10),
              child: TextField(
                  controller: _searchInput,
                  textInputAction: TextInputAction.search,
                  autofocus: false,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1))),
                      hintText: 'Cari Perusahaan',
                      hintStyle:
                      const TextStyle(fontWeight: FontWeight.w500),
                      prefixIcon: Icon(Icons.search)),
                  onEditingComplete: () {
                    if (_searchInput.text.isNotEmpty) {
                      FocusScope.of(context).unfocus();
                    }
                  })),
          Expanded(
            child: Container(
              height: Cmdof().custH(0.07, context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.6))),
              child: Icon(
                MdiIcons.tuneVariant,
                color: Colors.black,
                size: 23,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget BodyData() {
    return Expanded(
        child: ScrollConfiguration(
          behavior: NoOverscrollBehavior(),
          child: PagedListView<int, PkbuResponseData>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<PkbuResponseData>(
            itemBuilder: (context, item, index) {
              return Card(
                elevation: 0,
                child: ListTile(
                  onTap: (){
                  // do something
                  },
                  title: Text( item.npp, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19, color: Color(0xFF8D919A)),),
                  subtitle: Text(item.namaPerusahaan, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
                  trailing: Icon(Icons.navigate_next, color: Color(0xFF4DBB6C),),
                ),
              );
            },
              newPageProgressIndicatorBuilder: (context) => shimmer(),
              newPageErrorIndicatorBuilder: (context) {
                return Container(
                    color: Colors.grey.shade50,
                    height: 500,
                    child: const Center(
                        child: Text("Gagal memuat data.")
                    )
                );
              },
              firstPageProgressIndicatorBuilder: (context) => shimmer(),
              firstPageErrorIndicatorBuilder: (context) {
                return Container(
                    color: Colors.grey.shade50,
                    height: 500,
                    child: const Center(
                        child: Text("Gagal memuat data.")
                    )
                );
              },
              noItemsFoundIndicatorBuilder: (context) {
                return const SizedBox();
              }
            )
          ),
        ),
      );
  }

  void fetch(int index) {
    context.read<PkbuBloc>().add(onGetCompanyData(index: index));
  }

  Widget shimmer(){
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: Cmdof().custH(0.5, context),
        child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder:(context, index) {
              return const Card(
                elevation: 0,
                child: ListTile(
                  title: Text( "  ", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19, color: Color(0xFF8D919A)),),
                  subtitle: Text("   ", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black)),
                  trailing: Icon(Icons.navigate_next, color: Color(0xFF4DBB6C),),
                ),
              );
            },
        ),
      ),
    );
  }
}
