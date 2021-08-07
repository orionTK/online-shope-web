import { Component, OnInit, Inject } from "@angular/core";
import { HttpClient } from "@angular/common/http";
declare var $: any;

@Component({
  selector: 'app-admin-category',
  templateUrl: './admin-category.component.html',
})
export class AdminCategoryComponent implements OnInit {

  categories: any = {
    data: [],
    totalRecord: 0,
    page: 1,
    size: 10,
    totalPages: 0,
  };

  category: any = {
    categoryId: 1,
    categoryName: "",
    title: "",
    description: "",
    gender: true,
    gioiTinh: "",
  };

  key: any = "";
  isEdit: boolean = true;

  constructor(private http: HttpClient, @Inject("BASE_URL") baseUrl: string) { }

  ngOnInit() {
    this.searchCategory(1);
  }

  // Hiển thị danh sách loại sản phẩm
  searchCategory(cPage) {
    let x = {
      page: cPage,
      size: 10,
      keyword: this.key
    };
    this.http
      .post("https://localhost:44320/" + "api/Categories/search-category", x)
      .subscribe(
        (result) => {
          this.categories = result;
          this.categories = this.categories.data;
          console.log(this.categories);
        },
        (error) => console.error(error)
      );
  }

  searchNext() {
    if (this.categories.page < this.categories.totalPages) {
      let nextPage = this.categories.page + 1;
      let x = {
        page: nextPage,
        size: 10,
        keyword: this.key
      };
      this.http
        .post("https://localhost:44320/api/Categories/search-category", x)
        .subscribe(
          (result) => {
            this.categories = result;
            this.categories = this.categories.data;
          },
          (error) => console.error(error)
        );
    } else {
      alert("Bạn đang ở trang cuối cùng!");
    }
  }

  searchPrevious() {
    if (this.categories.page > 1) {
      let nextPage = this.categories.page - 1;
      let x = {
        page: nextPage,
        size: 10,
        keyword: this.key
      };
      this.http
        .post("https://localhost:44320/api/Categories/search-category", x)
        .subscribe(
          (result) => {
            this.categories = result;
            this.categories = this.categories.data;
          },
          (error) => console.error(error)
        );
    } else {
      alert("Bạn đang ở trang đầu tiên!");
    }
  }

  // MODAL
  deleteModal(index) {
    this.category = index;
    $('#myModal').modal("show");
  }

  openModal(isNew, index) {
    if (isNew) {
      this.isEdit = false
      this.category = {
        categoryName: "",
        title: "",
        description: "",
        gender: false,
      }
    }
    else {
      this.isEdit = true;
      this.category = index;
    }
    $('#Modal').modal("show");
  }

  // Sau khi thêm/ xóa/ sửa sẽ dialog và refresh lại trang bằng hàm location.reload()
  // Thêm
  addCategory() {
    var x = this.category;
    this.http.post('https://localhost:44320/api/Categories/create-category', x).subscribe(result=>{
        var res:any = result;
        if(res.success){
          this.category = res.data;
          this.isEdit = true;
          alert("Thêm mới thành công!");
          $('#Modal').modal("hide");
          location.reload();
        }
      }, error => console.error(error));
  }

  // Sửa
  updateCategory() {
    var x = this.category;
    this.http.post('https://localhost:44320/api/Categories/update-category', x).subscribe(result=>{
        var res:any = result;
        if(res.success){
          this.category = res.data;
          this.isEdit = true;
          alert("Cập nhật thành công!");
          $('#Modal').modal("hide");
          location.reload();
        }
      }, error => console.error(error));
  }

  // Xóa
  deleteCategory(index) {
    var x = index;
    this.http.post('https://localhost:44320/api/Categories/delete-category', x).subscribe(result=>{
        var res:any = result;
        if(res.success){
          alert("Xóa thành công!");
          $('#myModal').modal("hide");
          location.reload();
        }
      }, error => console.error(error));
  }
}
