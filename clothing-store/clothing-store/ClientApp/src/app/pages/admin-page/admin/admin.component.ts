import { Component, OnInit, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
})
export class AdminComponent implements OnInit {
  // Declare
  kw: String = "";
  users: any = {
    data: [],
    totalRecord: 0,
    page: 0,
    size: 9,
    totalPages: 0
  }

  user: any = {
    userId: "",
    userName: "string",
    password: "string",
    phoneNumber: "string",
    email: "string",
    dob: "string",
    roleId: 0
  }

  constructor(private http: HttpClient, @Inject('BASE_URL') baseUrl: string) {
  }

  // Get current data when open Modal
  openModal(index) {
    var item = this.users.data[index];
    this.user = {
      userId: item.userId,
      userName: item.userName,
      password: item.password,
      phoneNumber: item.phoneNumber,
      email: item.email,
      dob: item.dob,
      roleId: item.roleId
    }
  }

  // Search Username by ID
  search() { this.searchUser(1); };
  searchUser(cPage) {
    var x = {
      page: cPage,
      size: 5,
      keyword: this.kw
    }
    this.http.post('https://localhost:44320/api/Users/search-user', x)
      .subscribe(result => {
        var res: any = result;
        if (res.success) {
          this.users = res.data;
        }
        else {
          alert(res.message);
        }
      }, error => console.error(error));
  }

  // Functions
  updateUser() {
    var x = {
      UserId: this.user.userId,
      UserName: this.user.userName.trim().toString(),
      Password: this.user.password.trim(),
      PhoneNumber: this.user.phoneNumber.trim(),
      Dob: this.user.dob.trim(),
      Email: this.user.email.trim(),
      RoleId: parseInt(this.user.roleId)
    };
    this.http.post('https://localhost:44320/api/Users/update-user', x)
      .subscribe(result => {
        var res: any = result;
        if (res.success) {
          this.user = res.data;
          alert("Cập nhật thành công!")
          this.searchUser(1);
        }
        else {
          alert("Cập nhật thất bại!");
        }
      }, error => console.error(error));
  }

  deleteUser(index) {
    var r = confirm("Bạn muốn xóa thông tin tài khoản này?");
    if (r == true)
      this.user = this.users.data[index];
    var x = this.user;
    this.http.post('https://localhost:44320/api/Users/delete-user', x)
      .subscribe(result => {
        var res: any = result;
        if (res == 1) {
          this.searchUser(1);
          alert("Xóa thành công!");
        }
        else {
          alert("Xóa thất bại!");
        }
      }, error => console.error(error));
  }

  // Pagination
  searchNext() {
    if (this.users.page < this.users.totalPages) {
      let nextPage = this.users.page + 1;
      let x = {
        page: nextPage,
        size: 5,
        keyword: this.kw,
      };
      this.http.post('https://localhost:44320/api/Users/search-user', x)
        .subscribe(result => {
          var res: any = result;
          console.log(res);
          if (res.success) {
            this.users = res.data;
          }
          else {
            alert(res.message);
          }
        }, error => console.error(error));
    } else {
      alert("Bạn đang ở trang cuối cùng!");
    }
  }
  
  searchPrevious() {
    if (this.users.page > 1) {
      let nextPage = this.users.page - 1;
      let x = {
        page: nextPage,
        size: 5,
        keyword: this.kw,
      };
      this.http.post('https://localhost:44320/api/Users/search-user', x)
        .subscribe(result => {
          var res: any = result;
          console.log(res);
          if (res.success) {
            this.users = res.data;
          }
          else {
            alert(res.message);
          }
        }, error => console.error(error));
    } else
      alert("Bạn đang ở trang đầu tiên!");
  }

  ngOnInit() {
    this.searchUser(1);
  }
}
