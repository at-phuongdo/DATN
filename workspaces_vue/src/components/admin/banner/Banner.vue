<template>
  <div class="banner-content">
    <div v-if="slideUrl.length > 0">
      <h2>Current banners</h2>
      <p>Slide 1</p>
      <img :src="slideUrl[0].url">
      <p>Slide 2</p>
      <img :src="slideUrl[1].url">
      <p>Slide 3</p>
      <img :src="slideUrl[2].url">
    </div>
  </div>
</template>
<script>
  import { mapState, mapActions } from 'vuex'
  export default {
    data() {
      return {
        slideUrl: []
      }
    },
    created() {
      this.getBanner()
    },
    computed: {
      ...mapState({
        banners:state => state.banner.listBanner
      })
    },
    methods: {
      ...mapActions({
        'getBanner': 'banner/getBanner'
      })
    },
    watch: {
      banners() {
        this.slideUrl = this.banners
      }
    }
  }
</script>
<style>
  .banner-content {
    width: 85%;
    float: right;
    padding: 20px;
  }

  img {
    max-width: 100%;
  }
</style>