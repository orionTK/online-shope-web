import { Component, OnInit, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-women',
  templateUrl: './women.component.html',
})
export class WomenComponent implements OnInit {
  public res: any;
  public lstCategoryName: [];
  public lstProduct: [];
  public keywords:any;
  flag:string ="1";
  categoryName = "";

  products: any = {
    data: [],
    totalRecord: 0,
    page: 0,
    size: 12,
    totalPages: 0
  }

  constructor(
    private http: HttpClient,
    @Inject('BASE_URL') baseUrl: string) {

  }

  ngOnInit() {
    this.searchProductByGender(1);
  }

  //  Lấy danh sách sản phẩm theo tên của loại sản phẩm chọn ở phân loại
  getProduct(cPage, name) {
    let x = {
      page: cPage,
      size: 12,
      keyword: "",
      categoryName: name,
      gender: true
    }
    this.http.post('https://localhost:44320/' + 'api/Products/get-product-by-categoryName-linq', x).subscribe(result => {
      this.flag = "1";
      this.categoryName = name;
      this.products = result;
      this.products = this.products.data;
      console.log(this.products);
    }, error => console.error(error));
  }

  // Lấy danh sách tên loại sản phẩm để hiển thị lên phân loại
  getCategoryName(cGender) {
    var x = {
      gender: cGender
    }
    this.http.post('https://localhost:44320/' + 'api/Categories/get-categoryname-by-gender-linq', x)
      .subscribe(result => {
        this.res = result;
        this.lstCategoryName = this.res.data;
      }, error => console.error(error));
  }

    searchProductByProductName(cPage) {
      let x = {
        page: cPage,
        size: 12,
        keyword: this.keywords,
        gender: true
      }
      this.http.post("https://localhost:44320/api/Products/search-product-by-gender", x).subscribe(result => {
        this.products = result;
        this.products = this.products.data;
      }, error => console.error(error));
    }

  // Danh sách tất cả mặt hàng của nữ, hiện lên khi load trang Women
  searchProductByGender(cPage) {
    let x = {
      page: cPage,
      size: 12,
      keyword: "",
      gender: true
    }
    this.http.post("https://localhost:44320/api/Products/search-product-by-gender", x).subscribe(result => {
      this.flag = "2";
      this.products = result;
      this.products = this.products.data;
      console.log(this.products);
    }, error => console.error(error));
  }

  // Chia làm 2 trường hợp:
  // flag = 1 : Phân trang theo phân loại sản phẩm.
  // flag = 2 : Phân trang theo sản phẩm Nam.
  searchNext() {
    if (this.flag == "1") {
      if (this.products.page < this.products.totalPages) {
        let nextPage = this.products.page + 1;
        let x = {
          page: nextPage,
          size: 12,
          keyword: "",
        }
        this.http.post('https://localhost:44320/' + 'api/Products/get-product-by-categoryName-linq', x).subscribe(result => {
          this.products = result;
          this.products = this.products.data;
          console.log(this.products);
        }, error => console.error(error));
      }
      else {
        alert("Bạn đang ở trang cuối cùng!");
      }
    }
    else {
      if (this.products.page < this.products.totalPages) {
        let nextPage = this.products.page + 1;
        let x = {
          page: nextPage,
          size: 12,
          keyword: "",
          gender: true
        }
        this.http.post("https://localhost:44320/api/Products/search-product-by-gender", x).subscribe(result => {
          this.products = result;
          this.products = this.products.data;
          console.log(this.products);
        }, error => console.error(error));
      }
      else {
        alert("Bạn đang ở trang cuối cùng!");
      }
    }
  }

  // Tương tự như searchNext()
  searchPrevious() {
    if (this.flag == "1") {
      if (this.products.page > 1) {
        let previous = this.products.page - 1;
        let x = {
          page: previous,
          size: 12,
          keyword: "",
          categoryName: this.categoryName,
          gender: true
        }
        this.http.post('https://localhost:44320/' + 'api/Products/get-product-by-categoryName-linq', x).subscribe(result => {
          this.products = result;
          this.products = this.products.data;
          console.log(this.products);
        }, error => console.error(error));
      }
      else {
        alert("Bạn đang ở trang đầu tiên!");
      }
    }
    else {
      if (this.products.page > 1) {
        let previous = this.products.page - 1;
        let x = {
          page: previous,
          size: 12,
          keyword: "",
          gender: true
        }
        this.http.post("https://localhost:44320/api/Products/search-product-by-gender", x).subscribe(result => {
          this.products = result;
          this.products = this.products.data;
          console.log(this.products);
        }, error => console.error(error));
      }
      else {
        alert("Bạn đang ở trang đầu tiên!");
      }
    }
  }
}