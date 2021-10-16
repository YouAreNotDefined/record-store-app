<template>
  <header class="bg-gray-100 py-4" v-if="rerendering">
    <div class="max-w-screen-lg mx-auto flex flex-wrap items-center justify-end">
      <div class="flex-1 flex items-center">
        <svg class="fill-current text-indigo-400" viewBox="0 0 24 24" width="24" height="24"><title>record vinyl</title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"></path></svg>

        <a href="/" class="uppercase text-sm font-mono pl-4 font-semibold no-underline text-indigo-400 hover:text-indigo-darker">Record Store</a>
      </div>
      <div>
        <router-link to="/" class="link-grey px-2 no-underline font-semibold hover:opacity-70" active-class="pointer-events-none text-indigo-400" v-if="!signedIn()">Sign in</router-link>
        <router-link to="/signup" class="link-grey px-2 no-underline font-semibold hover:opacity-70" active-class="pointer-events-none text-indigo-400" v-if="!signedIn()">Sign Up</router-link>
        <router-link to="/records" class="link-grey px-2 no-underline font-semibold hover:opacity-70" active-class="pointer-events-none text-indigo-400" v-if="signedIn()">Records</router-link>
        <router-link to="/artists" class="link-grey px-2 no-underline font-semibold hover:opacity-70" active-class="pointer-events-none text-indigo-400" v-if="signedIn()">Artists</router-link>
        <a href="#" @click.prevent="signOut" class="link-grey px-2 no-underline font-semibold hover:opacity-70" v-if="signedIn()">Sign out</a>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
  data () {
    return {
      error: '',
      rerendering: true
    }
  },
  created () {
    this.signedIn()
  },
  updated () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  },
  watch: {
    $route (to, from) {
      const nextPath = to.path
      const oldPath = from.path

      if ((oldPath === '/' && nextPath === '/records') || (nextPath === '/' && oldPath !== '/signup' && oldPath !== '/') || (nextPath === '/records' && oldPath === '/signup')) {
        this.rerendering = false
        this.$nextTick(() => (this.rerendering = true))
      }
    }
  }
}
</script>
