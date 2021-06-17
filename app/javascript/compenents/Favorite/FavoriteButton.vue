<template>
  <div>
    <div v-if="isFavorited" @click="deleteFavorite()">
      いいねを取り消す {{ count }}
    </div>
    <div v-else @click="registerFavorite()">
      いいねする {{ count }}
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: ['userId', 'uploadId'],
  data() {
    return {
      favoriteList: []
    }
  },
  computed: {
    count() {
      return this.favoriteList.length
    },
    isFavorited() {
      if (this.favoriteList.length === 0) { return false }
      return Boolean(this.findFavoriteId())
    }
  },
  created: function() {
    this.fetchFavoriteByUploadId().then(result => {
      this.favoriteList = result
    })
  },
  methods: {
    fetchFavoriteByUploadId: async function() {
      const res = await axios.get(`/api/favorites/?upload_id=${this.uploadId}`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },
    registerFavorite: async function() {
      const res = await axios.post('/api/favorites', { upload_id: this.uploadId })
      if (res.status !== 201) { process.exit() }
      this.fetchFavoriteByUploadId().then(result => {
        this.favoriteList = result
      })
    },
    deleteFavorite: async function() {
      const favoriteId = this.findFavoriteId()
      const res = await axios.delete(`/api/favorites/${favoriteId}`)
      if (res.status !== 200) { process.exit() }
      this.favoriteList = this.favoriteList.filter(n => n.id !== favoriteId)
    },
    findFavoriteId: function() {
      const favorite = this.favoriteList.find((favorite) => {
        return (favorite.user_id === this.userId)
      })
      if (favorite) { return favorite.id }
    }
  }
}
</script>