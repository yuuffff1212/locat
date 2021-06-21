<template>
  <div>
    <div v-if="isFavorited" @click="deleteFavorite()" class="container">
      <span class="favorites">✔︎いいね!</span>
      <span class="counter">
        <span class="counterBefore"></span>{{ count }}
      </span>
    </div>
    <div v-else @click="registerFavorite()" class="container">
      <span class="favorites">いいね!</span>
      <span class="counter">
        <span class="counterBefore"></span>{{ count }}
      </span>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import {csrfToken} from 'rails-ujs'

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
      if (this.favoriteList.length === 0) {
        return false
      }
      return Boolean(this.findFavoriteId())
    }
  },
  created: function () {
    this.fetchFavoriteByUploadId().then(result => {
      this.favoriteList = result
    })
  },
  methods: {
    fetchFavoriteByUploadId: async function () {
      const res = await axios.get(`/api/favorites/?upload_id=${this.uploadId}`)
      if (res.status !== 200) {
        process.exit()
      }
      return res.data
    },
    registerFavorite: async function () {
      const res = await axios.post('/api/favorites', {upload_id: this.uploadId})
      if (res.status !== 201) {
        process.exit()
      }
      this.fetchFavoriteByUploadId().then(result => {
        this.favoriteList = result
      })
    },
    deleteFavorite: async function () {
      const favoriteId = this.findFavoriteId()
      const res = await axios.delete(`/api/favorites/${favoriteId}`)
      if (res.status !== 200) {
        process.exit()
      }
      this.favoriteList = this.favoriteList.filter(n => n.id !== favoriteId)
    },
    findFavoriteId: function () {
      const favorite = this.favoriteList.find((favorite) => {
        return (favorite.user_id === this.userId)
      })
      if (favorite) {
        return favorite.id
      }
    }
  }
}
</script>

<style scoped>
.container {
  font-family: "helvetica, arial, 'hiragino kaku gothic pro', meiryo, 'ms pgothic', sans-serif", serif;
  font-size: 11px;
}

.favorites{
  display: inline-block;
  background: #3b5998;
  padding: 0 5px;
  border-radius: 2px;
  color: #ffffff;
  cursor: pointer;
  float: left;
  height: 20px;
  line-height: 20px;
}

.counter{
  display: block;
  background: #fafafa;
  box-sizing: border-box;
  border: 1px solid #aaa;
  float: left;
  padding: 0 8px;
  border-radius: 2px;
  margin-left: 8px;
  height: 20px;
  line-height: 20px;
}

.counterBefore {
  display: block;
  float: left;
  width: 6px;
  height: 6px;
  background: #fafafa;
  margin-left: -12px;
  border-right: 10px;
  transform: rotate(45deg);
  -webkit-transform: rotate(45deg);
  margin-top: 6px;
  border-left: 1px solid #aaa;
  border-bottom: 1px solid #aaa;
}
</style>