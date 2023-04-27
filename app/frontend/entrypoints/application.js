// import 'bootstrap/js/src/alert'
// import 'bootstrap/js/src/button'
// import 'bootstrap/js/src/carousel'
import 'bootstrap/js/src/collapse'
import 'bootstrap/js/src/dropdown'
// import 'bootstrap/js/src/modal'
import 'chart.js'
import 'chartkick'
// import 'bootstrap/js/src/popover'
import 'bootstrap/js/src/scrollspy'
// import 'bootstrap/js/src/tab'
// import 'bootstrap/js/src/toast'
// import 'bootstrap/js/src/tooltip'

import * as bootstrap from 'bootstrap';
window.bootstrap = bootstrap;
import * as echarts from 'echarts';
import 'echarts/theme/dark';

window.echarts = echarts;

import SvelteLoader from '@/global/javascript/svelte_loader'

// To see this message, add the following to the `<head>` section in your
// views/layouts/application.html.erb
//
//    <%= vite_client_tag %>
//    <%= vite_javascript_tag 'application' %>
console.log('Vite ⚡️ Rails')

// If using a TypeScript entrypoint file:
//     <%= vite_typescript_tag 'application' %>
//
// If you want to use .jsx or .tsx, add the extension:
//     <%= vite_javascript_tag 'application.jsx' %>

const viewComponentJSModules = import.meta.globEager('../../components/**/*_component.js')
const viewComponentCSSModules = import.meta.globEager('../../components/**/*_component.css')
{ viewComponentJSModules, viewComponentCSSModules }

// Example: Load Rails libraries in Vite.
//

import Turbolinks from 'turbolinks'
Turbolinks.start()
//
// import ActiveStorage from '@rails/activestorage'
// ActiveStorage.start()
//
// // Import all channels.
const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'

window.SvelteRailsUJS = SvelteLoader
SvelteLoader.start()
