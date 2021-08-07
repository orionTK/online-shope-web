import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

// CUSTOMER PAGES
import { HomePageComponent } from './pages/customer-page/home-page/home-page.component';
import { MenComponent } from './pages/customer-page/men/men.component';
import { WomenComponent } from './pages/customer-page/women/women.component';
import { SaleComponent } from './pages/customer-page/sale/sale.component';
import { AccessoriesComponent } from './pages/customer-page/accessories/accessories.component';
import { ContactComponent } from './pages/customer-page/contact/contact.component';
import { CartComponent } from './pages/customer-page/cart/cart.component';
import { ProductComponent } from './pages/customer-page/product/product.component';
import { CheckoutComponent } from './pages/customer-page/checkout/checkout.component';

// ADMIN PAGES
import { AdminComponent } from './pages/admin-page/admin/admin.component';
import { AdminProductsComponent } from './pages/admin-page/admin-products/admin-products.component';
import { AdminCategoryComponent } from './pages/admin-page/admin-category/admin-category.component';
import { AdminPromotionComponent } from './pages/admin-page/admin-promotion/admin-promotion.component';

// COMPONENTS
import { NavbarComponent } from './components/navbar/navbar.component';
import { FooterComponent } from './components/footer/footer.component';
import { SidebarComponent } from './components/sidebar/sidebar.component';
import { LoginComponent } from './pages/login/login.component';
import { SignupComponent } from './pages/signup/signup.component';


@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    HomePageComponent,
    SaleComponent,
    FooterComponent,
    ContactComponent,
    LoginComponent,
    SignupComponent,
    CartComponent,
    MenComponent,
    WomenComponent,
    AccessoriesComponent,
    ProductComponent,
    AdminComponent,
    AdminProductsComponent,
    AdminCategoryComponent,
    AdminPromotionComponent,
    SidebarComponent,
    CheckoutComponent,
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    HttpClientModule,
    FormsModule,
    AppRoutingModule,
    ReactiveFormsModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

