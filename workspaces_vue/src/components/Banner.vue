<template>
  <div class="banner">
    <carousel :loop="true" :autoplay="true" :autoplayTimeout="3000" :autoplayHoverPause="true" :perPage="1" :paginationEnabled="false" >
      <slide >
        <div class="slide slide1" :style="{ 'background-image': 'url(' + slideUrl[0].url + ')' }"></div>
      </slide>
      <slide>
        <div class="slide slide2" :style="{ 'background-image': 'url(' + slideUrl[1].url + ')' }"></div>
      </slide>
      <slide>
        <div class="slide slide3" :style="{ 'background-image': 'url(' + slideUrl[2].url + ')' }"></div>
      </slide>
    </carousel>
    <search></search>
  </div>
</template>
<script>
  import { Carousel, Slide } from 'vue-carousel'
  import Search from './workspaces/Search.vue'
  import { mapState, mapActions } from 'vuex'
  export default {
    components: {
      Carousel,
      Slide,
      'search' : Search
    },
    data() {
      return {
        slideUrl: [
        "https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/494114/1360/906/m1/fpnw/wm1/qlxkg4xc1aychk7rijovkyxz2ulyf1x2unkximhho1yf3fov0febsdyj5w7mynsp-.jpg?1432198111&s=73cdcc0d96480927bb74cf6f638c4630",
        "https://images.steelcase.com/image/upload/c_fill,dpr_auto,q_70,h_656,w_1166/v1432747698/www.steelcase.com/tour-workspace.jpg", 
        "https://static1.squarespace.com/static/55d279e4e4b0db7d8fd4657d/t/58ab6511be6594a084368f3e/1487627555461/Interior+1.jpg?format=750w"]
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
  @import url('https://fonts.googleapis.com/css?family=Pacifico');
  .banner {
    height: 700px;
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
  }

  .slide {
    height: 700px;
    z-index: -99;
    background-size: cover;
  }

  .col-md-4,
  .btn-group,
  .btn {
    position: static !important;
  }

  .decorate-span {
    font-family: 'Pacifico', cursive;
    color: #28a745;
  }
</style>
