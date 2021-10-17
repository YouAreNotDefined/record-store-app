<template>
  <div class="max-w-lg m-auto py-10">
    <div class="text-red-400" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new library</h3>

    <form @submit.prevent="addLibrary">
      <div class="mb-6">
        <label for="name" class="label">Name</label>
        <input
          type="text"
          id="name"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a library name"
          v-model="newLibrary.name">
      </div>

      <div class="mb-6">
        <label for="content" class="label">Content</label>
        <textarea class="w-full p-2 rounded-md border border-gray-300 outline-none focus:border-gray-400"
        placeholder="Enter info about library" name="content" id="content" cols="30" rows="5" v-model="newLibrary.content">
        </textarea>
      </div>

      <div class="mb-6">
        <label for="record" class="label">Record</label>
        <Multiselect
          v-model="newLibrary.records"
          :options="records"
          mode="multiple"
          placeholder="Select some record"
          value-prop="id"
          label="title">
            <template v-slot:multiplelabel="{ values }">
              <div class="absolute left-0 flex">
                <div
                  class="text-xs font-bold leading-sm py-1 px-2 bg-green-200 text-green-700 rounded-full ml-2"
                  v-for="value in values"
                  :key="value.id">
                  {{ value.title }} - {{ value.year }}
                </div>
              </div>
            </template>
        </Multiselect>
      </div>

      <input type="submit" value="Add Library" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-400 hover:bg-green-500 block w-full py-4 text-white items-center justify-center">
    </form>

    <hr class="border border-grey-light my-6" />

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="library in libraries" :key="library.id" :library="library">
        <div class="flex items-center justify-between flex-wrap">
          <div class="flex-1 flex justify-between flex-wrap pr-4">
          <p class="block flex font-mono font-semibold flex items-center">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 24 24" width="24" height="24"><title>record vinyl</title><path d="M23.938 10.773a11.915 11.915 0 0 0-2.333-5.944 12.118 12.118 0 0 0-1.12-1.314A11.962 11.962 0 0 0 12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12c0-.414-.021-.823-.062-1.227zM12 16a4 4 0 1 1 0-8 4 4 0 0 1 0 8zm0-5a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" ></path></svg>
            {{ library.name }}
          </p>
        </div>

        <router-link :to="`/libraries/${library.id}`" class="bg-transparent text-sm hover:bg-blue-400 hover:text-white text-blue-400 border border-blue-400 no-underline font-bold py-2 px-4 mr-2 rounded">Edit</router-link>

        <button class="bg-transparent text-sm hover:bg-red-400 text-red-400 hover:text-white no-underline font-bold py-2 px-4 rounded border border-red-400"
          @click.prevent="removeLibrary(library)">Delete</button>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import Multiselect from '@vueform/multiselect'

export default {
  name: 'Libraries',
  data () {
    return {
      error: '',
      libraries: [],
      records: [],
      newLibrary: {
        name: '',
        content: '',
        records: []
      }
    }
  },
  components: {
    Multiselect
  },
  created () {
    this.$http.secured.get('/api/v1/libraries')
      .then(responce => { this.libraries = responce.data })
      .catch(error => this.setError(error, 'Something went wrong'))

    this.$http.secured.get('/api/v1/records')
      .then(responce => { this.records = responce.data })
      .catch(error => this.setError(error, 'Something went wrong'))
  },
  methods: {
    addLibrary () {
      this.$http.secured.post('/api/v1/libraries', { library: { name: this.newLibrary.name, content: this.newLibrary.content } })
        .then(responce => {
          this.libraries.push(responce.data)
          this.newLibrary = {
            name: '',
            content: '',
            records: ''
          }
          this.error = ''
        })
        .catch(error => this.setError(error, 'Cannot create library'))
    },
    removeLibrary (library) {
      this.$http.secured.delete(`/api/v1/libraries/${library.id}`)
        .then(responce => {
          this.libraries.splice(this.libraries.indexOf(library), 1)
          this.error = ''
        })
        .catch(error => this.setError(error, 'Cannot delete library'))
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}
</script>

<style src="@vueform/multiselect/themes/default.css"></style>
