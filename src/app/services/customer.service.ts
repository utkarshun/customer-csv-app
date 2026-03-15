import { Injectable } from '@angular/core';
import { Customer } from '../models/customer.model';
@Injectable({
  providedIn: 'root',
})
export class CustomerService {
  customers: Customer[] = [];
  setCustomers(data: Customer[]) {
    this.customers = data;
  }
  getCustomer() {
    return this.customers;
  }
  getCustomerById(regNo: string): Customer | undefined {
    return this.customers.find((c) => c['Registration No'] == regNo);
  }
  constructor() {}
}
