class Restaurant{
  String id;
  String name;
  String image;
  String address;
  double latitude;
  double longitude;
  String description;
  double rating;

  Restaurant({this.id, this.name,this.image, this.address, this.latitude, this.longitude, this.description,this.rating});

  List<Restaurant> initData(){
    List<Restaurant> data = List<Restaurant>();
    data.add(new Restaurant(id:"1", name:'Quán Ốc Liên',image: 'https://res.cloudinary.com/tf-lab/image/upload/w_656,h_368,c_fill,g_auto:subject,q_auto,f_auto/restaurant/564f17bf-d702-452e-9dd3-4dd59a0f125d/18d166c3-e809-4ea1-aec0-e1f35a30d9db.jpg', address:'số 39 Lê Văn Lương, Tân Kiểng, Quận 7, Thành phố Hồ Chí Minh, Việt Nam', latitude:10.7494967, longitude:106.7037482,description: 'Mở cửa lúc 17:00',rating: 4.0));
    data.add(new Restaurant(id:"2", name:'Nhà Hàng - Hầm Rượu - Karaoke SOS',image: 'https://media-kyna.cdn.vccloud.vn/uploads/courses/1207/img/video_cover_image_url-1534308746.crop-730x436.jpg',address:'122 Số 7, P, Quận 7, Thành phố Hồ Chí Minh, Việt Nam', latitude:10.74834, longitude: 106.704304,description: 'xé phay ngon, giá rẻ, thái độ phục vụ nhẹ nhàng chu đáo, hứa sẽ dẫn bạn bè quay lại',rating: 5.0));
    data.add(new Restaurant(id:"3",name: 'Bò Lá Lốt Tân Quy',image: 'https://lh3.googleusercontent.com/proxy/T0Gr38SatLVMBSsQpWO5iINb3cEGELd5rXsuZw3OVBRudXM7AOrkDAt-lnIg9vH4NqtWzfs7NnhUFeEJTR3Jg_ErLOm2j5RxiiKmh0hu16MvoPUfaE9PA71xhJG9Z16uEMfgykzr4zM0ia0ZR0zd6ZnZeguxHuQ', address:'24 Đường 67, Tân Quy, Quận 7, Thành phố Hồ Chí Minh, Việt Nam',latitude: 10.7443983, longitude:106.7054696, description:'Bò lá lốt siêu ngon, thơm và ngọt. Ăn từ khi giá 25k, nay đã lên 45k rồi.',rating: 4.5));
    data.add(new Restaurant(id:"4", name:'Sushi 88', image: 'https://grandtouranehotel.com/uploads/product/sp_49.jpg',address:'43-45 Nguyễn Thị Thập, Khu đô thị Him Lam, Quận 7, Thành phố Hồ Chí Minh, Việt Nam', latitude: 10.744099,longitude: 106.6956455, description:'Bàn ghế và sàn sạch sẽ. Ra món nhanh. Trang trí món bắt mắt. Tuy nhiên nhân viên đùa giỡn ồn ào trong giờ làm một cách khó chấp nhận.',rating: 4.0));
    return data;
  }
}