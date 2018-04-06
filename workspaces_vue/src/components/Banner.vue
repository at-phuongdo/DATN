<template>
  <div class="banner">
    <carousel :loop="true" :autoplay="true" :autoplayTimeout="3000" :autoplayHoverPause="true" :perPage="1" :paginationEnabled="false" >
      <slide>
        <div class="slide slide1"></div>
      </slide>
      <slide>
        <div class="slide slide2"></div>
      </slide>
      <slide>
        <div class="slide slide3"></div>
      </slide>
    </carousel>
    <div class="search">
     <b-row>
       <b-col md="4" offset-md="4">
         <h1 class="search-title"><span class="decorate-span">Let's</span> find a workspace</h1>
       </b-col>
     </b-row>
     <b-row>
       <b-col md="4" offset-md="4" class="search-content">
         <input type="text" placeholder="Please enter the name you want to find..." class="search-input" v-if="selected=='name'">
         <input ref="autocomplete" placeholder="Please enter country or city you want to find..." class="search-location" onfocus="value = ''" type="text" v-else/>
         <b-form-select v-model="selected" :options="options"/>
         <b-button variant="success search-button" @click="getAddressData">Search</b-button>
       </b-col>
     </b-row>
   </div>
   <search></search>
 </div>
</template>
<script>
  import { Carousel, Slide } from 'vue-carousel'
  import Search from './workspaces/Search.vue'
  export default {
    components: {
      Carousel,
      Slide,
      'search' : Search
    },
    dependencies : ['workspaceService'],
    mounted() {
      this.autocomplete = new google.maps.places.Autocomplete(
        (this.$refs.autocomplete),
        {types: ['geocode']}
        );
    },
    data() {
      return {
        address: '',
        options: [
        { value: 'location', text: 'Search by location' },
        { value: 'name', text: 'Search by name'}
        ],
        selected: 'location'
      }
    },
    methods: {
      getAddressData: function () {
        let place = this.autocomplete.getPlace()
        let ac = place.address_components
        let lat = place.geometry.location.lat()
        let lon = place.geometry.location.lng()
        let city = ac[0]["short_name"]
        console.log(lat)
        this.searchByLocation()
      },
      searchByLocation: function() {
        this.workspaceService.searchByLocation()
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

  .slide1 {
    background-image: url("https://cmkt-image-prd.global.ssl.fastly.net/0.1.0/ps/494114/1360/906/m1/fpnw/wm1/qlxkg4xc1aychk7rijovkyxz2ulyf1x2unkximhho1yf3fov0febsdyj5w7mynsp-.jpg?1432198111&s=73cdcc0d96480927bb74cf6f638c4630");
  }

  .slide2 {
    background-image: url("https://images.steelcase.com/image/upload/c_fill,dpr_auto,q_70,h_656,w_1166/v1432747698/www.steelcase.com/tour-workspace.jpg")
  }

  .slide3 {
    background-image: url("https://static1.squarespace.com/static/55d279e4e4b0db7d8fd4657d/t/58ab6511be6594a084368f3e/1487627555461/Interior+1.jpg?format=750w")
  }

  .search {
    position: relative;
    top: -350px;
  }

  .search-title {
    color: white;
    text-align: center;
    text-shadow: 6px 6px 4px #000000;
    font-weight: bold;
  }
  .decorate-span {
    font-family: 'Pacifico', cursive;
    color: #28a745;
  }
  .search-content {
    display: inherit;
  }

  .search-button {
    margin-left: 10px;
  }

  .col-md-4,
  .btn-group,
  .btn {
    position: static !important;
  }

  .search-location,
  .search-input {
    display: block;
    width: 80vw;
    margin: 0 auto;
    font-weight: 400;
    outline: none;
    line-height: 30px;
    border-radius: 0.25rem;
    padding-left: 10px;
  }
</style>
