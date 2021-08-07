import { Component, OnInit, Inject } from '@angular/core';
import { HttpClient } from "@angular/common/http";
declare var $: any;

@Component({
  selector: 'app-admin-promotion',
  templateUrl: './admin-promotion.component.html',
})
export class AdminPromotionComponent implements OnInit {

  promotions: any = {
    data: [],
    totalRecord: 0,
    page: 1,
    size: 5,
    totalPages: 0,
  };

  promotion: any = {
    promotionId: 0,
    promotionName: "meo",
    discountPercent: 0.0,
    salePercent: "",
    discount: 0,
  };

  key: any = "";
  isEdit: boolean = true;

  constructor(private http: HttpClient, @Inject("BASE_URL") baseUrl: string) { }

  ngOnInit() {
    this.searchPromotion(1);
  }

  // Hiện danh sách giảm giá
  searchPromotion(cPage) {
    let x = {
      page: cPage,
      size: 5,
      keyword: this.key
    };
    this.http
      .post("https://localhost:44320/" + "api/Promotion/search-promotion", x)
      .subscribe(
        (result) => {
          this.promotions = result;
          this.promotions = this.promotions.data;
        },
        (error) => console.error(error)
      );
  }

  searchNext() {
    if (this.promotions.page < this.promotions.totalPages) {
      let nextPage = this.promotions.page + 1;
      let x = {
        page: nextPage,
        size: 5,
        keyword: this.key
      };
      this.http
        .post("https://localhost:44320/api/Promotion/search-promotion", x)
        .subscribe(
          (result) => {
            this.promotions = result;
            this.promotions = this.promotions.data;
          },
          (error) => console.error(error)
        );
    } else {
      alert("Bạn đang ở trang cuối cùng!");
    }
  }

  searchPrevious() {
    if (this.promotions.page > 1) {
      let nextPage = this.promotions.page - 1;
      let x = {
        page: nextPage,
        size: 5,
        keyword: this.key
      };
      this.http
        .post("https://localhost:44320/api/Promotion/search-promotion", x)
        .subscribe(
          (result) => {
            this.promotions = result;
            this.promotions = this.promotions.data;
          },
          (error) => console.error(error)
        );
    } else {
      alert("Bạn đang ở trang đầu tiên!");
    }
  }

  // MODAL 
  deleteModal(index) {
    this.promotion = index;
    $('#myModal').modal("show");
  }

  openModal(isNew, index) {
    if (isNew) {
      this.isEdit = false
      this.promotion = {
        promotionId: 0,
        promotionName: "",
        discount: 0,
      };
    }
    else {
      this.isEdit = true;
      this.promotion = index;
    }
    $('#Modal').modal("show");
  }

  // Thêm
  addPromotion() {
    var x = this.promotion;
    this.promotion.discountPercent = this.promotion.discount / 100;
    this.http.post('https://localhost:44320/api/Promotion/create-promotion', x).subscribe(result=>{
        var res:any = result;
        if(res.success){
          this.promotion = res.data;
          this.isEdit = true;
          alert("Thêm mới thành công!");
          $('#Modal').modal("hide")
          location.reload();
          ;
        }
      }, error => console.error(error));
  }

  // Cập nhật
  updatePromotion() {
    var x = this.promotion;
    this.promotion.discountPercent = this.promotion.discount / 100;
    this.http.post('https://localhost:44320/api/Promotion/update-promotion', x).subscribe(result=>{
        var res:any = result;
        if(res.success){
          this.promotion = res.data;
          this.isEdit = true;
          alert("Cập nhật thành công!");
          $('#Modal').modal("hide");
          location.reload();
        }
      }, error => console.error(error));
  }

  // Xóa
  deletePromotion(index) {
    var x = index;
    this.http.post('https://localhost:44320/api/Promotion/delete-promotion', x)
    .subscribe(result=>{
        var res:any = result;
        if(res.success){
          alert("Xóa thành công!");
          $('#myModal').modal("hide");
          location.reload();
        }
      }, error => console.error(error));
  }
}
