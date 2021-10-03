import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'
import '@/assets/style/tailwind.css'

// const config = {
//   el: '#app',
//   securedAxiosInstance,
//   plainAxiosInstance
// }

const app = createApp(App)

app.use(router)

app.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})

app.mount('#app')
