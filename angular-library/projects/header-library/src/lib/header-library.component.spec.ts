import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeaderLibraryComponent } from './header-library.component';

describe('HeaderLibraryComponent', () => {
  let component: HeaderLibraryComponent;
  let fixture: ComponentFixture<HeaderLibraryComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HeaderLibraryComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(HeaderLibraryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
