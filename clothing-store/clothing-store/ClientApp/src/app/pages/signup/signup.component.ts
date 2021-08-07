import { Component, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import * as bcrypt from 'bcryptjs';

@Component({
  selector: 'app-signup',
  templateUrl: './signup.component.html',
})
export class SignupComponent {

  passworldEnter: any
  users: any = {
    userName: null,
    passWord: null,
    email: null,
    dob: null,
    phoneNumber: null,
    roleId: 2
  }

  constructor(private http: HttpClient, @Inject('BASE_URL') baseUrl: string) {

  }

  addUser() {
    var x = this.users;
    bcrypt.hash(this.passworldEnter, 10, (err, hash) => {
      if (!err) {
        x.passWord = hash;
        this.http.post('https://localhost:44320/api/Users/create-user', x)
          .subscribe(result => {
            var res: any = result;
            if (res.success) {
              alert("Đăng kí thành công!");
              window.open('https://localhost:44320/login','_self')
            }
            else {
              alert("Đăng kí thành công");
            }
          }, error => console.error(error));
      } else {
        alert("Đăng kí không thành công");
        console.log('Error: ', err)
      }
    })
  }
}