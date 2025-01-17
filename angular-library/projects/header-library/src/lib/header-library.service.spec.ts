import { TestBed } from '@angular/core/testing';

import { HeaderLibraryService } from './header-library.service';

describe('HeaderLibraryService', () => {
  let service: HeaderLibraryService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HeaderLibraryService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
