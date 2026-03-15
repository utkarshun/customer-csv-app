import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
// import { NgModule } from '@angular/core';
import { UploadComponent } from './components/upload/upload.component';
// import { CustomerListComponent } from './upload/upload.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { CustomerDetailsComponent } from './components/customer-details/customer-details.component';
import { LoginComponent } from './components/login/login.component';
import { SignupComponent } from './components/signup/signup.component';
const routes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'signup', component: SignupComponent },
  { path: 'upload', component: UploadComponent },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'customer/:id', component: CustomerDetailsComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
