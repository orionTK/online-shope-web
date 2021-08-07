import { Component, OnInit, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { CookieService } from 'ngx-cookie-service';
import { Observable, Subject} from 'rxjs'

@Component({
  selector: 'app-cart',
  templateUrl: './cart.component.html',
  styleUrls: ['./cart.component.scss']
})

export class CartComponent implements OnInit {
  userId: any;
  cart: any = {
    data: []
  };

  user: any = {
    data: []
  }
  totalMoney: number = 0;
  m: number = 1;
  SumPro: any;
  constructor(private activateRoute: ActivatedRoute, private http: HttpClient,
    @Inject('BASE_URL') baseUrl: string, private cookieService: CookieService) {

  }

  ngOnInit() {
    this.userId = parseInt(this.cookieService.get("userId"));
    this.getCart(this.userId);
  }

  getCart(id) {
    this.http.get("https://localhost:44320/api/Carts/get-cart/" + id, id).subscribe(result => {
      this.cart = result;
      this.cart = this.cart.data;
      this.SumPro = "Tổng tiền (" + this.cart.length  + " sản phẩm): "; 
      this.cart.forEach(element => {
        this.totalMoney += element.total;
      });
      console.log(this.userId);
      console.log(this.cart);
    }, error => console.error(error));
  }

  DeleteProductCart(p) {
    console.log(p);
    var r = confirm("Bạn có chắn chắn muốn xóa sản phẩm?")
    if (r == true) {
      var x = p;
      this.http.post("https://localhost:44320/api/Carts/delete-product-cart", x).subscribe(result => {
        var res: any = result;
        if (res.success) {
          alert("Bạn đã xóa một sản phẩm ra khỏi giỏ!")
          this.getCart(this.userId);
          window.location.reload();
        }
        console.log(x);
      }, error => {
        console.error(error);
        alert(error);
      }
      );
    }

  }

  ThanhToan() {
    // Lấy thông tin user
    var a = {
      id: this.userId,  
      Keyword: ""
    };

    this.http.post("https://localhost:44320/api/Users/get-by-id", a).subscribe(result => {
      this.user = result;
      this.user = this.user.data;
    }, error => {
      console.error(error);
      alert(error);
    }
    );

    // Thêm vào bảng Order
    let b = {
      "orderId": 0,
      "userId": this.userId,
      "orderDate": "",
      "shipName": "ABC",
      "shipAddress": this.user.address,
      "shipPhoneNumber": this.user.phoneNumber,
      "status": false
    };
    this.http.post("https://localhost:44320/api/Order/create-order", a).subscribe(result => {
      var res: any = result;
      if (res.success)
        alert("Bạn có một hóa đơn!")
    }, error => {
      console.error(error);
    }
    );

    // Thêm vào bảng orderDetails
    this.cart.forEach(element => {
      let c = {
        "orderId": 0,
        "productId": element.productId,
        "size": element.size,
        "unitPrice": element.unitPrice,
        "quantity": element.quantity,
        "discount": element.discountPercent
      };
      this.http.post("https://localhost:44320/api/Order/create-order-detail", c).subscribe(result => {
        var res: any = result;
        if (res.success)
          alert("Bạn có một hóa đơn!")
      }, error => {
        console.error(error);
        alert(error);
      }
      );
    }); 


    // Xóa giỏ
    this.cart.forEach(element => {
      var x = element;
      this.http.post("https://localhost:44320/api/Carts/delete-product-cart", x).subscribe(result => {
        var res: any = result;
        console.log(x);
      }, error => {
        console.error(error);
        alert(error);
      }
      );
    });
    alert("Bạn đã đặt hàng thành công!")
  }
}