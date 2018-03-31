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
        <b-form-input type="text" placeholder="Please enter country or city you want to find..." class="search-input"></b-form-input>
        <b-dropdown text="All spaces" variant="dropdown-button">
          <b-dropdown-item-button>All spaces</b-dropdown-item-button>
          <b-dropdown-item-button>Meeting spaces</b-dropdown-item-button>
          <b-dropdown-item-button>Workspace</b-dropdown-item-button>
        </b-dropdown>
        <b-button variant="success search-button">Search</b-button>
      </b-col>
    </b-row>
  </div>
</div>
</template>
<script>
  import { Carousel, Slide } from 'vue-carousel';
  export default {
    components: {
      Carousel,
      Slide
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

  .btn-dropdown-button,
  .search-input {
    border-radius: 0;
  }

  .search-button {
    margin-left: 10px;
  }

  .col-md-4,
  .btn-group,
  .btn {
    position: static !important;
  }
</style>
