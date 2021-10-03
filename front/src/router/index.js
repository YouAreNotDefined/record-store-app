import { createRouter, createWebHistory } from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Artists from '@/components/artists/Artists.vue'
import Records from '@/components/records/Records.vue'

export default createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/artists',
      name: 'Artists',
      component: Artists
    },
    {
      path: '/records',
      name: 'Records',
      component: Records
    }
  ]
})
