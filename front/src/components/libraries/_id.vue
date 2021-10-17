<template>
  <div class="max-w-lg m-auto py-10">
    <div class="text-red-400" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Library</h3>

    <form @submit.prevent="editLibrary">
      <div class="mb-6">
        <label for="name" class="label">Name</label>
        <input
          type="text"
          id="name"
          class="input"
          autofocus
          autocomplete="off"
          placeholder="Type a library name"
          v-model="library.name">
      </div>

      <div class="mb-6">
        <label for="content" class="label">Content</label>
        <textarea class="w-full p-2 rounded-md border border-gray-300 outline-none focus:border-gray-400"
        placeholder="Enter info about library" name="content" id="content" cols="30" rows="5" v-model="library.content">
        </textarea>
      </div>

      <div class="mb-6">
        <label for="record" class="label">Record</label>
        <select id="record" class="select">
          <option disabled value="">Select a record</option>
          <option :value="record.id" v-for="record in records" :key="record.id">{{ record.title }} &mdash; {{ record.year }}</option>
        </select>
      </div>

      <input type="submit" value="Edit Library" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-400 hover:bg-green-500 block w-full py-4 text-white items-center justify-center">
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      error: '',
      library: {
        name: '',
        content: ''
      },
      records: []
    }
  },
  created () {
    this.$http.secured.get(`/api/v1/libraries/${this.$route.params.id}`)
      .then(responce => {
        this.library = responce.data
      })
      .catch(error => this.setError(error, 'Something went wrong'))

    this.$http.secured.get('/api/v1/records')
      .then(responce => { this.records = responce.data })
      .catch(error => this.setError(error, 'Something went wrong'))
  },
  methods: {
    editLibrary () {

    }
  }
}
</script>
