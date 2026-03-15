import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { CustomerService } from 'src/app/services/customer.service';
import { Customer } from 'src/app/models/customer.model';

@Component({
  selector: 'app-customer-details',
  templateUrl: './customer-details.component.html',
  styleUrls: ['./customer-details.component.css'],
})
export class CustomerDetailsComponent implements OnInit {
  customer!: Customer;

  constructor(
    private route: ActivatedRoute,
    private customerService: CustomerService,
    private router: Router,
  ) {}

  ngOnInit(): void {
    const id = this.route.snapshot.params['id'];

    const customers = this.customerService.getCustomer();

    this.customer = customers[id];
  }

  goBack() {
    this.router.navigate(['/dashboard']);
  }
}
