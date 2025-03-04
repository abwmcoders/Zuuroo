import 'package:zuuro/presentation/view/vtu/model/biller_model.dart';
import 'package:zuuro/presentation/view/vtu/model/operator_model.dart';

import '../presentation/view/home/model/home_model.dart';
import '../presentation/view/home/model/loan_model.dart';
import '../presentation/view/vtu/model/cable_model.dart';
import '../presentation/view/vtu/model/cable_plan_model.dart';
import '../presentation/view/vtu/model/country_model.dart';
import '../presentation/view/vtu/model/data_cat_model.dart';

class AppConstants {
  static HomeModel? homeModel;
  static List<CountryModel>? countryModel = [];
  static List<LoanLimit>? loanModel = [];
  static List<CableData>? cableModel = [];
  static List<BillerData>? billerModel = [];
  static List<DataCategory>? dataCategoryModel = [];
  static List<OperatorModel>? operatorModel = [];
  static List<CablePlan>? cablePlanModel = [];
  static const currencySymbol = '₦';
}