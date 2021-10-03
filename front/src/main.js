import Vue from 'vue'
import App from './App.vue'
import './assets/style/tailwind.css'
import router from './router'
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './backend/axios'

Vue.use(VueAxios, {
  secured: securedAxiosInstance,
  plain: plainAxiosInstance
})
// Vue.use(Router)

const config = {
  el: '#app',
  router,
  securedAxiosInstance,
  plainAxiosInstance,
  components: { App },
  template: '<App/>'
}

const vm = new Vue()

vm.$mount(config)
