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

  getRecentChats(String userId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    response = await dio.post(baseUrl + "/getRecentChats",
        data: data, options: options);
    return response;
  }

  getMessages(String userId, String sender) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    data['sender'] = sender;
    response =
        await dio.post(baseUrl + "/getMessages", data: data, options: options);
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

  addNews(String userId, String compId, String image, String url) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    data['comp_id'] = compId;
    data['image'] = image;
    data['imageurl'] = url;

    response =
        await dio.post(baseUrl + "/addNews", data: data, options: options);
    return response;
  }

  getNewsFeed(String userId, String compId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    data['comp_id'] = compId;
    response =
        await dio.post(baseUrl + "/getNewsFeed", data: data, options: options);
    return response;
  }

  likePost(String userId, String compId) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    data['post_id'] = compId;
    response =
        await dio.post(baseUrl + "/likePost", data: data, options: options);
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

  getSingleBook(String userId) async {
    Map<String, dynamic> data = new Map();
    data['book_id'] = userId;
    response = await dio.post(baseUrl + "/getSingleBook",
        data: data, options: options);
    return response;
  }

  getInstByCategory(String userId) async {
    Map<String, dynamic> data = new Map();
    data['cat_id'] = userId;
    response = await dio.post(baseUrl + "/getInstituteByCategory",
        data: data, options: options);
    return response;
  }

  getInstituteById(String userId) async {
    Map<String, dynamic> data = new Map();
    data['institute_id'] = userId;
    response = await dio.post(baseUrl + "/getSingleInstitute",
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

  getInstCategory(String panelId) async {
    Map<String, dynamic> data = new Map();
    data['type'] = panelId;
    response = await dio.post(baseUrl + "/getInstituteCategory",
        data: data, options: options);
    return response;
  }

  getOwoCategory(String panelId) async {
    Map<String, dynamic> data = new Map();
    data['panel_id'] = panelId;
    response = await dio.post(baseUrl + "/getOwoCategory",
        data: data, options: options);
    return response;
  }

  getOwoselleBook(String city, String deptId) async {
    Map<String, dynamic> data = new Map();
    data['city'] = city;
    data['dept_id'] = deptId;
    response = await dio.post(baseUrl + "/getOwosellBook",
        data: data, options: options);
    return response;
  }

  getMyBook(String user) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = user;
    response =
        await dio.post(baseUrl + "/getMyBook", data: data, options: options);
    return response;
  }

  removeMyBook(String user) async {
    Map<String, dynamic> data = new Map();
    data['book_id'] = user;
    response =
        await dio.post(baseUrl + "/removeMyBook", data: data, options: options);
    return response;
  }

  removeInstitute(String user) async {
    Map<String, dynamic> data = new Map();
    data['institute_id'] = user;
    response = await dio.post(baseUrl + "/removeMyInstitute",
        data: data, options: options);
    return response;
  }

  getSubCategory(String catId) async {
    Map<String, dynamic> data = new Map();
    data['cat_id'] = catId;
    response = await dio.post(baseUrl + "/getSubCategory",
        data: data, options: options);
    return response;
  }

  getPgs(String catId) async {
    Map<String, dynamic> data = new Map();
    data['city'] = catId;
    response = await dio.post(baseUrl + "/getPg", data: data, options: options);
    return response;
  }

  bookTicket(
    String event,
    String userId,
    String name,
    String phone,
    String amount,
  ) async {
    Map<String, dynamic> data = new Map();
    data['user_id'] = userId;
    data['event'] = event;
    data['name'] = name;
    data['phone'] = phone;
    data['total'] = amount;
    response =
        await dio.post(baseUrl + "/bookTicket", data: data, options: options);
    return response;
  }

  getProducts(String subId) async {
    Map<String, dynamic> data = new Map();
    data['sub_id'] = subId;
    response =
        await dio.post(baseUrl + "/getProducts", data: data, options: options);
    return response;
  }

  getQuiz(String subId) async {
    Map<String, dynamic> data = new Map();
    data['sub_id'] = subId;
    response =
        await dio.post(baseUrl + "/getAllQuiz", data: data, options: options);
    return response;
  }

  getSingleQuiz(String subId) async {
    Map<String, dynamic> data = new Map();
    data['quiz_id'] = subId;
    response = await dio.post(baseUrl + "/getSingleQuiz",
        data: data, options: options);
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

  removeCart(String userId) async {
    Map<String, dynamic> data = new Map();
    data['cart_id'] = userId;
    response =
        await dio.post(baseUrl + "/removeCart", data: data, options: options);
    return response;
  }

  couponRecharge(String userId, String couponCode) async {
    Map<String, dynamic> data = new Map();
    data['u_id'] = userId;
    data['coupon'] = couponCode;
    response = await dio.post(baseUrl + "/couponRecharge",
        data: data, options: options);
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

  addInstitute(
      String name,
      String location,
      String contact,
      String email,
      String address,
      String title,
      String exp,
      String education,
      String image,
      String imageurl,
      String city,
      String userId,
      String catId) async {
    Map<String, dynamic> data = new Map();
    data['name'] = title;
    data['location'] = location;
    ;
    data['contact'] = contact;
    ;
    data['email'] = email;
    ;
    data['address'] = address;
    ;
    data['tutor'] = name;
    ;
    data['t_exp'] = exp;
    ;
    data['t_edu'] = education;
    ;
    data['image'] = image;
    ;
    data['imageurl'] = imageurl;
    ;
    data['city'] = city;
    ;
    data['cat_id'] = catId;
    ;
    data['u_id'] = userId;
    response =
        await dio.post(baseUrl + "/addInstitute", data: data, options: options);
    return response;
  }

  addSellBook(
      String title,
      String publication,
      String author,
      String mrp,
      String discount,
      String buy_price,
      String pickup,
      String info,
      String imageurl,
      String image,
      String uId,
      String city,
      String deptId) async {
    Map<String, dynamic> data = new Map();
    data['title'] = title;
    data['publication'] = publication;
    data['author'] = author;
    data['discount'] = discount;
    data['mrp'] = mrp;
    data['buy_price'] = buy_price;
    data['pickup'] = pickup;
    data['info'] = info;
    data['image'] = image;
    data['imageurl'] = imageurl;
    data['u_id'] = uId;
    data['city'] = city;
    data['dept_id'] = deptId;
    response =
        await dio.post(baseUrl + "/addSellBook", data: data, options: options);
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
