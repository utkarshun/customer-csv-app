import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { CustomerService } from '../../services/customer.service';
import { Customer } from '../../models/customer.model';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent implements OnInit {
  models: string[] = [];
  selectedFilterType: 'all' | 'model' | 'due' = 'all';
  selectedFilterValue: string = 'all';
  searchTerm: string = '';
  customers: Customer[] = [];
  filteredCustomers: Customer[] = [];
  selectedRowIndex: number | null = null;
  totalCustomers = 0;
  totalModels = 0;
  dueSoon = 0;

  constructor(
    private customerService: CustomerService,
    private router: Router,
  ) {}

  ngOnInit(): void {
    this.customers = this.customerService.getCustomer();
    this.filteredCustomers = [...this.customers];

    this.totalCustomers = this.customers.length;

    const models = new Set(this.customers.map((c) => c.Model));
    this.models = ['All', ...Array.from(models)];
    this.totalModels = models.size;

    this.calculateDueSoon();
  }
  onFilterTypeChange(event: Event) {
    this.selectedFilterType = (event.target as HTMLSelectElement).value as
      | 'all'
      | 'model'
      | 'due';
    this.selectedFilterValue = 'all';
    this.applyCombinedFilters();
  }

  onFilterValueChange(event: Event) {
    this.selectedFilterValue = (event.target as HTMLSelectElement).value;
    this.applyCombinedFilters();
  }

  get filterValues(): string[] {
    if (this.selectedFilterType === 'model') {
      return this.models;
    }

    if (this.selectedFilterType === 'due') {
      return ['all', 'due7', 'overdue'];
    }

    return ['all'];
  }
  calculateDueSoon() {
    const today = new Date();
    const next7Days = new Date();
    next7Days.setDate(today.getDate() + 7);

    this.dueSoon = this.customers.filter((c) => {
      const due = new Date(c['Due Date']);

      return due >= today && due <= next7Days;
    }).length;
  }

  applyFilter(event: Event): void {
    this.searchTerm = (event.target as HTMLInputElement).value.toLowerCase();
    this.applyCombinedFilters();
  }

  applyCombinedFilters() {
    const today = new Date();
    const next7 = new Date();
    next7.setDate(today.getDate() + 7);

    this.filteredCustomers = this.customers.filter((c) => {
      const matchesSearch =
        c.Name.toLowerCase().includes(this.searchTerm) ||
        c.phno.toLowerCase().includes(this.searchTerm) ||
        c['Registration No'].toLowerCase().includes(this.searchTerm);

      const due = new Date(c['Due Date']);

      let matchesTypeFilter = true;
      if (this.selectedFilterType === 'model') {
        matchesTypeFilter =
          this.selectedFilterValue === 'All' ||
          c.Model === this.selectedFilterValue;
      } else if (this.selectedFilterType === 'due') {
        matchesTypeFilter =
          this.selectedFilterValue === 'all' ||
          (this.selectedFilterValue === 'due7' &&
            due >= today &&
            due <= next7) ||
          (this.selectedFilterValue === 'overdue' && due < today);
      }

      return matchesSearch && matchesTypeFilter;
    });
  }
  openCustomer(index: number): void {
    this.selectedRowIndex = index;
    this.router.navigate(['/customer', index]);
  }
  isDueSoon(date: string) {
    const today = new Date();
    const next7 = new Date();
    next7.setDate(today.getDate() + 7);
    const due = new Date(date);
    return due >= today && due <= next7;
  }
  isOverdue(date: string) {
    const today = new Date();
    const due = new Date(date);
    return due < today;
  }
}
