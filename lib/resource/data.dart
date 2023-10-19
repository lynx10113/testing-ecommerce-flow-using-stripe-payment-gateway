
class Address {
  String? name;
  String? street;
  String? township;
  String? state;
  String? phoneNumber;
  String? email;

  Address(
      {this.name,
      this.street,
      this.township,
      this.state,
      this.phoneNumber,
      this.email});

  Address.fromMap(Map map):
        name = map["name"],
        street = map["street"],
        township = map["township"],
        state = map["state"],
        phoneNumber = map["phoneNumber"],
        email = map["email"];

  Map toMap(){
    return {
      "name": name,
      "street": street,
      "township": township,
      "state": state,
      "phoneNumber": phoneNumber,
      "email": email
    };
  }

}
//
// class Category {
//   final String name;
//   final String price;
//   final String percent;
//   final String rating;
//   final String duration;
//   final String image;
//
//   Category({required this.name,required this.price, required this.percent, required this.rating, required this.duration, required this.image});
// }
//
// List<Category> data = [
//   Category(
//       name: 'Paradise Plaza',
//       price: '100',
//       percent: '10%-20%',
//       rating: '4.5',
//       duration: '10-20 min',
//       image: 'https://miro.medium.com/v2/resize:fit:1358/1*lDovuExq_O5nXoa3zHjVCA.png'
//   ),
//   Category(
//       name: 'Domino\'s',
//       price: '120',
//       percent: '15%-25%',
//       rating: '4.8',
//       duration: '15-25 min',
//       image: 'https://miro.medium.com/v2/resize:fit:1358/1*N8Z1VhEYJR6vpe5a5DrbjQ.png'
//   ),
//   Category(
//       name: 'California Burrito',
//       price: '140',
//       percent: '20%-30%',
//       rating: '4.9',
//       duration: '20-30 min',
//       image: 'https://miro.medium.com/v2/resize:fit:1358/1*TbjERXN27pf2XQJnuUSdrA.png'
//   ),
//   Category(
//       name: 'China Town',
//       price: '160',
//       percent: '20%-30%',
//       rating: '4.7',
//       duration: '25-35 min',
//       image: 'https://miro.medium.com/v2/resize:fit:1100/format:webp/1*M8OA2dCXwvRZP6h42Zq4AQ.png'
//   ),
// ];

List<Map<String, dynamic>> data = [
  {
    'name': 'Nike Air Force 1 \'07 Premium',
    'price': '145',
    'percent': '1',
    'quantity': 1,
    'rating': '4.5',
    'duration': '10-20 min',
    'image':
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b01e8d15-ffab-4f2b-af64-45031aa5432c/air-force-1-07-premium-mens-shoes-FLRvC9.png',
  },
  {
    'name': 'Nike Air Max 90 Gore-Tex',
    'price': '160',
    'percent': '1',
    'quantity': 1,
    'rating': '4.8',
    'duration': '15-25 min',
    'image': 'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/d4abdad5-4e03-4e34-a790-cb2bbd06e4c2/air-max-90-gore-tex-mens-shoes-cZwz8t.png',
  },
  {
    'name': 'Lebron XXI "Akoya"',
    'price': '200',
    'percent': '3',
    'quantity': 1,
    'rating': '4.9',
    'duration': '20-30 min',
    'image': 'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/0c1b09d2-96f6-4c23-a92e-d6745ff5920f/lebron-xxi-akoya-basketball-shoes-lnQSsH.png',
  },
  {
    'name': 'Air Jordan Legacy 312 Low',
    'price': '145',
    'percent': '1',
    'quantity': 1,
    'rating': '4.7',
    'duration': '25-35 min',
    'image': 'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/hk7hv22ezuxx0qvadlt9/air-jordan-legacy-312-low-mens-shoes-B931hr.png',
  },
  {
    'name': 'Nike InfinityRN 4 Gore-Tex',
    'price': '180',
    'percent': '2',
    'quantity': 1,
    'rating': '4.7',
    'duration': '25-35 min',
    'image': 'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/c7cee966-efba-4fc4-99ce-ab2ccacf9f81/infinityrn-4-gore-tex-mens-waterproof-road-running-shoes-nPh2bZ.png',
  },
];
