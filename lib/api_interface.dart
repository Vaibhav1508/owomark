import 'package:dio/dio.dart';

class ApiInterface {
  Response response;
  Dio dio;
  var options;
  Map<String, String> request2 = new Map();
  var baseUrl = "http://owomark.com/owomarkapp/api";

  ApiInterface() {
    dio = Dio();
    request2['ApiKey'] = "kom06z7krVBLOeMUG6SQZdDm4wkMdqGJ";
    request2['Content-Type'] = "application/json";

    options = Options(
      followRedirects: false,
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status < 500;
      },
      headers: request2,
    );
  }

  getNotification(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response = await dio.post(baseUrl + "/getDashboardPanel",
        data: data, options: options);
    return response;
  }

  getDashboardBooks(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response = await dio.post(baseUrl + "/getDashboardBooks",
        data: data, options: options);
    return response;
  }

  getDashboardEvents(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response =
        await dio.post(baseUrl + "/getEvents", data: data, options: options);
    return response;
  }

  getEvents(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response =
        await dio.post(baseUrl + "/getAllEvents", data: data, options: options);
    return response;
  }

  getSlider(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response =
        await dio.post(baseUrl + "/getOffers", data: data, options: options);
    return response;
  }

  makeOrder(String userId, String total, String type, String email, String name,
      String address, String phone, String pin, String dcharge) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    data['total'] = total;
    data['type'] = type;
    data['email'] = email;
    data['name'] = name;
    data['address'] = address;
    data['phone'] = phone;
    data['pin'] = pin;
    data['dcharge'] = dcharge;
    response =
        await dio.post(baseUrl + "/makeOrder", data: data, options: options);
    return response;
  }

  getOrder(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    response =
        await dio.post(baseUrl + "/getOrders", data: data, options: options);
    return response;
  }

  getSingleEvent(String userId) async {
    Map<String, dynamic> data = new Map();
    data['event_id'] = userId;
    response = await dio.post(baseUrl + "/getSingleEvent",
        data: data, options: options);
    return response;
  }

  getCompetition(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response = await dio.post(baseUrl + "/getCompetitions",
        data: data, options: options);
    return response;
  }

  getDeals(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response =
        await dio.post(baseUrl + "/getBestDeals", data: data, options: options);
    return response;
  }

  getProjects(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response =
        await dio.post(baseUrl + "/getProjects", data: data, options: options);
    return response;
  }

  getProfile(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    response = await dio.post(baseUrl + "/getUserProfile",
        data: data, options: options);
    return response;
  }

  getPayment(String userId, String weight, String total) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    data['weight'] = weight;
    data['total'] = total;
    response =
        await dio.post(baseUrl + "/getPayments", data: data, options: options);
    return response;
  }

  getAllProjects(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = 'id';
    response = await dio.post(baseUrl + "/getAllProjects",
        data: data, options: options);
    return response;
  }

  getInstituteByUser(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    response = await dio.post(baseUrl + "/getInstituteByUser",
        data: data, options: options);
    return response;
  }

  getSingleProject(String userId) async {
    Map<String, dynamic> data = new Map();
    data['p_id'] = userId;
    response = await dio.post(baseUrl + "/getProjectById",
        data: data, options: options);
    return response;
  }

  getInstitutes(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    response = await dio.post(baseUrl + "/getInstitutes",
        data: data, options: options);
    return response;
  }

  getTransactions(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    response = await dio.post(baseUrl + "/getUserTransaction",
        data: data, options: options);
    return response;
  }

  getCategory(String panelId) async {
    Map<String, dynamic> data = new Map();
    data['panel_id'] = panelId;
    response =
        await dio.post(baseUrl + "/getCategory", data: data, options: options);
    return response;
  }

  getSubCategory(String catId) async {
    Map<String, dynamic> data = new Map();
    data['cat_id'] = catId;
    response = await dio.post(baseUrl + "/getSubCategory",
        data: data, options: options);
    return response;
  }

  getProducts(String subId) async {
    Map<String, dynamic> data = new Map();
    data['sub_id'] = subId;
    response =
        await dio.post(baseUrl + "/getProducts", data: data, options: options);
    return response;
  }

  addToCart(String userId, String productId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    data['product_id'] = productId;
    response =
        await dio.post(baseUrl + "/addToCart", data: data, options: options);
    return response;
  }

  incrementItem(String subId, String item) async {
    Map<String, dynamic> data = new Map();
    data['cart_id'] = subId;
    data['qty'] = item;
    response = await dio.post(baseUrl + "/incrementItem",
        data: data, options: options);
    return response;
  }

  decrementItem(String subId, String item) async {
    Map<String, dynamic> data = new Map();
    data['cart_id'] = subId;
    data['qty'] = item;
    response = await dio.post(baseUrl + "/decrementItem",
        data: data, options: options);
    return response;
  }

  getSingleProduct(String subId) async {
    Map<String, dynamic> data = new Map();
    data['p_id'] = subId;
    response = await dio.post(baseUrl + "/getProductById",
        data: data, options: options);
    return response;
  }

  getCart(String subId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = subId;
    response =
        await dio.post(baseUrl + "/getUserCart", data: data, options: options);
    return response;
  }
}
