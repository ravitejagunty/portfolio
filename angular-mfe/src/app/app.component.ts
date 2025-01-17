import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import {HeaderLibraryComponent} from 'header-library'

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, HeaderLibraryComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'angular-mfe';
}
