import { Component, OnInit, Inject } from "@angular/core";
import { HttpClient } from "@angular/common/http";
declare var $:any;

@Component({
  selector: "app-admin-products",
  templateUrl: "./admin-products.component.html",
  //styleUrls: ["./admin-products.component.scss"],
})
export class AdminProductsComponent implements OnInit {
  products: any = {
    data: [],
    totalRecord: 0,
    page: 0,
    size: 10,
    totalPages: 0,
  };

  product: any = {
    productId: "1",
    productName: "Áo thun",
    categoryId: 1,
    price: 250000,
    stock: 20,
    dateCreate: "",
    description: "",
    imageSource: "",
    promotionId: 0
  };

  categories: any = {
  }

  promotion: any = {
  }

  key :any = "";
  isEdit: boolean = true;

  constructor(private http: HttpClient, @Inject("BASE_URL") baseUrl: string) {}

  ngOnInit() {
    this.searchProduct(1);
    this.getCategories();
    this.getPromotion();
  }

  // Lấy ds giảm giá để hiển thị lên select control
  getPromotion() {
    this.http
      .post("https://localhost:44320/" + "api/Promotion/get-by-all", null)
      .subscribe(
        (result) => {
          this.promotion = result;
          console.log(this.promotion);
        },
        (error) => console.error(error)
      );
  }

  // Lấy ds phân loại để hiển thị lên select control
  getCategories() {
    this.http
      .post("https://localhost:44320/" + "api/Categories/get-all", null)
      .subscribe(
        (result) => {
          this.categories = result;
          console.log(this.categories);
        },
        (error) => console.error(error)
      );
  }

  // Hiện danh sách sản phẩm
  searchProduct(cPage) {
    let x = {
      page: cPage,
      size: 10,
      keyword: this.key
    };
    this.http
      .post("https://localhost:44320/" + "api/Products/search-product", x)
      .subscribe(
        (result) => {
          this.products = result;
          this.products = this.products.data;
          console.log(this.products);
        },
        (error) => console.error(error)
      );
  }

  searchNext() {
    if (this.products.page < this.products.totalPages) {
      let nextPage = this.products.page + 1;
      let x = {
        page: nextPage,
        size: 10,
        keyword: this.key
      };
      this.http
        .post("https://localhost:44320/api/Products/search-product", x)
        .subscribe(
          (result) => {
            this.products = result;
            this.products = this.products.data;
          },
          (error) => console.error(error)
        );
    } else {
      alert("Bạn đang ở trang cuối cùng!");
    }
  }

  searchPrevious() {
    if (this.products.page > 1) {
      let nextPage = this.products.page - 1;
      let x = {
        page: nextPage,
        size: 10,
        keyword: this.key
      };
      this.http
        .post("https://localhost:44320/api/Products/search-product", x)
        .subscribe(
          (result) => {
            this.products = result;
            this.products = this.products.data;
          },
          (error) => console.error(error)
        );
    } else {
      alert("Bạn đang ở trang đầu tiên!");
    }
  }

  // MODAL
  deleteModal(index)
  {
    this.product = index;
    $('#myModal').modal("show");
  }

  openModal(isNew, index)
  {
    if(isNew)
    {
      this.isEdit = false
      this.product={
        categoryId: 1,
        productName: "",
        price: 0,
        stock: 1,
        dateCreate: new Date().toJSON("yyyy/MM/dd HH:mm"),
        description: "",
        imageSource: "",
        promotionId: 0
      }
    }
    else
    {
      this.isEdit = true;
      this.product = index;
    }
    $('#Modal').modal("show");
  }

  // Thêm
  addProduct()
  {
    var x = this.product;
    console.log(x);
    this.http.post('https://localhost:44320/api/Products/create-product', x).subscribe(result=>{
        var res:any = result;
        if(res.success){
          this.product = res.data;
          this.isEdit = true;
          alert("Thêm mới thành công!");
          $('#Modal').modal("hide");
          location.reload();
        }
      }, error => console.error(error));
  }

  // Cập nhật
  updateProduct()
  {
    var x = this.product;
    this.http.post('https://localhost:44320/api/Products/update-product', x).subscribe(result=>{
        var res:any = result;
        if(res.success){
          this.product = res.data;
          this.isEdit = true;
          alert("Cập nhật thành công!");
          $('#Modal').modal("hide");
          location.reload();
        }
      }, error => console.error(error));
  }

  // Xóa
  deleteProduct(index)
  {
    var x = index;
    this.http.post('https://localhost:44320/api/Products/delete-product', x).subscribe(result=>{
        var res:any = result;
        if(res.success){
          alert("Xóa thành công!");
          $('#myModal').modal("hide");
          location.reload();
        }
      }, error => console.error(error));
  }
}
