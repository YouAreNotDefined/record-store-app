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
        <Multiselect
          v-model="currentRecords"
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

      <input type="submit" value="Edit Library" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green-400 hover:bg-green-500 block w-full py-4 text-white items-center justify-center">
    </form>
    <router-link to="/libraries" class="inline-block mt-10 bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-3 rounded">&lt; Back</router-link>
  </div>
</template>

<script>
import Multiselect from '@vueform/multiselect'

export default {
  data () {
    return {
      error: '',
      library: {
        name: '',
        content: ''
      },
      currentRecords: [],
      records: []
    }
  },
  components: {
    Multiselect
  },
  created () {
    this.$http.secured.get(`/api/v1/libraries/${this.$route.params.id}`)
      .then(responce => {
        this.library = responce.data.library
        console.log(responce.data.records)
        this.currentRecords = responce.data.records.map(record => record.id)
      })
      .catch(error => this.setError(error, 'Something went wrong'))

    this.$http.secured.get('/api/v1/records')
      .then(responce => { this.records = responce.data })
      .catch(error => this.setError(error, 'Something went wrong'))
  },
  methods: {
    editLibrary () {
      this.$http.secured.patch(`/api/v1/libraries/${this.$route.params.id}`, { library: { name: this.library.name, content: this.library.content, record_ids: this.currentRecords } })
        .then(responce => {
          this.$router.replace('/libraries')
        })
        .catch(error => this.setError(error, 'Can not update'))
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}
</script>

<style src="@vueform/multiselect/themes/default.css"></style>
