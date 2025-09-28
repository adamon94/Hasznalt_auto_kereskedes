import { createApp } from 'vue'
import { createPinia } from 'pinia';

import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap";
import App from './App.vue'
import router from './routeConfig';

const pinia = createPinia()
createApp(App).use(router).use(pinia).mount('#app')
