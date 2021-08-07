import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';

// CUSTOMER PAGES
import { HomePageComponent } from './pages/customer-page/home-page/home-page.component';
import { MenComponent } from './pages/customer-page/men/men.component';
import { WomenComponent } from './pages/customer-page/women/women.component';
import { SaleComponent } from './pages/customer-page/sale/sale.component';
import { AccessoriesComponent } from './pages/customer-page/accessories/accessories.component';
import { ContactComponent } from './pages/customer-page/contact/contact.component';
import { CartComponent } from './pages/customer-page/cart/cart.component';
import { CheckoutComponent } from './pages/customer-page/checkout/checkout.component';
import { ProductComponent } from './pages/customer-page/product/product.component';

// ADMIN PAGES
import { AdminComponent } from './pages/admin-page/admin/admin.component';
import { AdminProductsComponent } from './pages/admin-page/admin-products/admin-products.component';
import { AdminCategoryComponent } from './pages/admin-page/admin-category/admin-category.component';
import { AdminPromotionComponent } from './pages/admin-page/admin-promotion/admin-promotion.component';

import { SignupComponent } from './pages/signup/signup.component';
import { LoginComponent } from './pages/login/login.component';


const routes: Routes = [
  // CUSTOMER
  { path: '', component: HomePageComponent },
  { path: 'men', component: MenComponent },
  { path: 'women', component: WomenComponent },
  { path: 'sale', component: SaleComponent },
  { path: 'accessories', component: AccessoriesComponent },
  { path: 'contact', component: ContactComponent },
  { path: 'cart', component: CartComponent },
  { path: 'check-out', component: CheckoutComponent },
  { path: 'product-detail', component: ProductComponent },
  
  // ADMIN
  { path: 'admin', component: AdminComponent },
  { path: 'admin-products', component: AdminProductsComponent },
  { path: 'admin-category', component: AdminCategoryComponent },
  { path: 'admin-promotion', component: AdminPromotionComponent },



  // FUNCTIONS
  { path: 'login', component: LoginComponent },
  { path: 'signup', component: SignupComponent },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
