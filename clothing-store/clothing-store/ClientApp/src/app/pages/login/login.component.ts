import { Component, OnInit, Inject } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { CookieService } from 'ngx-cookie-service';
import * as bcrypt from 'bcryptjs';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
})
export class LoginComponent {
  headerFooter: boolean;

  usertk: any = {
    data: []
  };
  user: string = null;
  pass: string = null;
  result: any = [];
  constructor(private http: HttpClient, @Inject('BASE_URL') baseUrl: string, private cookieService: CookieService) {

  }

  login() {
    var x = {
      username: this.user,
      password: this.pass
    };
    this.http.post('https://localhost:44320/api/Users/check-tai-khoan', x)
      .subscribe(result => {
        var res: any = result;
        var userId;
        this.result = res.data;
        if (res.success && res.data.length > 0) {
          bcrypt.compare(x.password, this.result[0].password, (err, res) => {
            if (res == true) {
              if (this.result[0].roleId == 1) {
                alert("Bạn đang được chuyển hướng với quyền truy cập của ADMIN!");
                window.open('https://localhost:44320/admin', '_self');
              }
              else {
                alert("Đăng nhập thành công!");
                window.open('https://localhost:44320','_self');
                userId = (this.result[0].userId).toString();
              }
              this.cookieService.set("userId", this.result[0].userId.toString());
            }
            else {
              alert("Mật khẩu không đúng!");
              console.log('Error: ', err)
            }
          });
        } else {
          alert("Tài khoản không đúng!!!");
        }
      }, error => console.error(error));
  }
}
