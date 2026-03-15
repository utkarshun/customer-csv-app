import { Component } from '@angular/core';
import { Router } from '@angular/router';
import * as Papa from 'papaparse';
import { CustomerService } from '../../services/customer.service';
import { Customer } from '../../models/customer.model';

@Component({
  selector: 'app-upload',
  templateUrl: './upload.component.html',
  styleUrls: ['./upload.component.css'],
})
export class UploadComponent {
  selectedFile: File | null = null;
  isDragging = false;

  constructor(
    private customerService: CustomerService,
    private router: Router,
  ) {}

  onFileSelect(event: any) {
    this.selectedFile = event.target.files[0];
  }

  onDragOver(event: DragEvent) {
    event.preventDefault();
    this.isDragging = true;
  }

  onDragLeave(event: DragEvent) {
    event.preventDefault();
    this.isDragging = false;
  }

  onFileDrop(event: DragEvent) {
    event.preventDefault();
    this.isDragging = false;
    if (event.dataTransfer?.files) {
      this.selectedFile = event.dataTransfer.files[0];
    }
  }

  uploadFile() {
    if (!this.selectedFile) {
      alert('Please select a CSV file first');
      return;
    }

    Papa.parse(this.selectedFile, {
      header: true,
      skipEmptyLines: true,

      complete: (result: any) => {
        const data: Customer[] = result.data;

        this.customerService.setCustomers(data);

        this.router.navigate(['/dashboard']);
      },
    });
  }
}
