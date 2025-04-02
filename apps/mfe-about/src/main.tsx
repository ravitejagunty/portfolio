// main.tsx
async function init() {
  // Rspack/Vite require manual shared scope setup
  // @ts-expect-error
  await __webpack_init_sharing__('default');

   // @ts-expect-error
  const container = window.mfe_home; // or whatever your remote name is
  if (container?.init) {
     // @ts-expect-error
    await container.init(__webpack_share_scopes__.default);
  }

  await import('./bootstrap');
}

init();