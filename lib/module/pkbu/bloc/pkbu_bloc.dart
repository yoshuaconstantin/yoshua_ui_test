import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:yoshua_ui_test/api/endpoint/PKBU/pkbu_response.dart';

import '../../../api/api_manager.dart';
import '../../../api/endpoint/PKBU/pkbu_request.dart';
import '../../../api/endpoint/PKBU/pkbu_response_data.dart';
import '../../../helper/constant.dart';
import '../../../helper/preferences.dart';

part 'pkbu_event.dart';
part 'pkbu_state.dart';

class PkbuBloc extends Bloc<PkbuEvent, PkbuState> {
  PkbuBloc() : super(PkbuInitial()) {
    on<PkbuEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<onGetCompanyData>(_getData);
  }

  FutureOr<void> _getData(onGetCompanyData event, Emitter<PkbuState> emit) async {
    try {
      emit(onGetDataLoading());

      PkbuRequest pkbuRequest = PkbuRequest(
         filter_search_company: [],
        kode_kantor: Preferences.getInstance().getString(SharedPreferenceKey.COMPANY_CODE)!,
        kode_pembina: Preferences.getInstance().getString(SharedPreferenceKey.USER_CODE)!,
        order_search_company: [],
        pageNumber: event.index.toString(),
        pageSize: "10"
      );

      // DO PAGINATION

      Response response = await ApiManager().getPKBUData(
          pkbuRequest: pkbuRequest
      );

      if (response.statusCode == 200) {
        int nextIndex = event.index + 1;

        PkbuResponse pkbuResponse = PkbuResponse.fromJson(response.data);

        emit(onGetDataSuccess(data: pkbuResponse, nextIndex: nextIndex));
      } else {
        emit(onGetDataFailed(message: "Ada sesuatu yang salah!"));
      }

    }catch(e) {
      String message = e.toString();
      emit(onGetDataFailed(message: message));

    }finally {

      emit(onGetDataFinished());

    }
  }
}
