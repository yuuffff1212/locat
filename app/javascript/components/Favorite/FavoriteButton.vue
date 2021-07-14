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
// axios と rails-ujsのメソッドインポート
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
// CSRFトークンの取得とリクエストヘッダへの設定をしてくれます
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  // propsでrailsのviewからデータを受け取る
  props: ['userId', 'uploadId'],
  data() {
    return {
      favoriteList: []  // いいね一覧を格納するための変数　{ id: 1, user_id: 1, post_id: 1 } がArrayで入る
    }
  },
  // 算出プロパティ ここではlikeListが変更される度に、count、isLiked が再構築される (watchで監視するようにしても良いかも)
  computed: {
    // いいね数を返す
    count() {
      return this.favoriteList.length
    },
    // ログインユーザが既にいいねしているかを判定する
    isFavorited() {
      if (this.favoriteList.length === 0) { return false }
      return Boolean(this.findFavoriteId())
    }
  },
  // Vueインスタンスの作成・初期化直後に実行される
  created: function() {
    this.fetchFavoriteByUploadId().then(result => {
      this.favoriteList = result
    })
  },
  methods: {
    // rails側のindexアクションにリクエストするメソッド
    fetchFavoriteByUploadId: async function() {
      const res = await axios.get(`/api/favorites/?upload_id=${this.uploadId}`)
      if (res.status !== 200) { process.exit() }
      return res.data
    },
    // rails側のcreateアクションにリクエストするメソッド
    registerFavorite: async function() {
      const res = await axios.post('/api/favorites', { upload_id: this.uploadId })
      if (res.status !== 201) { process.exit() }
      this.fetchFavoriteByUploadId().then(result => {
        this.favoriteList = result
      })
    },
    // rails側のdestroyアクションにリクエストするメソッド
    deleteFavorite: async function() {
      const favoriteId = this.findFavoriteId()
      const res = await axios.delete(`/api/favorites/${favoriteId}`)
      if (res.status !== 200) { process.exit() }
      this.favoriteList = this.favoriteList.filter(n => n.id !== favoriteId)
    },
    // ログインユーザがいいねしているlikeモデルのidを返す
    findFavoriteId: function() {
      const favorite = this.favoriteList.find((favorite) => {
        return (favorite.user_id === this.userId)
      })
      if (favorite) { return favorite.id }
    }
  }
}
</script>