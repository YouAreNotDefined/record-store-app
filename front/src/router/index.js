import { createRouter, createWebHistory } from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Artists from '@/components/artists/Artists.vue'
import Records from '@/components/records/Records.vue'
import Libraries from '@/components/libraries/Libraries.vue'
import library from '@/components/libraries/_id.vue'

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
    },
    {
      path: '/libraries',
      name: 'Libraries',
      component: Libraries
    },
    {
      path: '/libraries/:id',
      component: library
    }
  ]
})
