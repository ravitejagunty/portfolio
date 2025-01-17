import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'lib-header-library',
  standalone: true,
  imports: [CommonModule],
  template: `
    <p>
      header-library works {{test}}!
    </p>
  `,
  styles: ``
})
export class HeaderLibraryComponent {
  public test: string = 'as a library'
}
