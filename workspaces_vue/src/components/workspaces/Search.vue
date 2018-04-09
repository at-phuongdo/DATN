<template>
  <div class="search">
   <b-row>
     <b-col md="4" offset-md="4">
       <h1 class="search-title"><span class="decorate-span">Let's</span> find a workspace</h1>
     </b-col>
   </b-row>
   <b-row>
     <b-col md="4" offset-md="4" class="search-content">
       <input type="text" placeholder="Please enter the name you want to find..." class="search-input" v-if="selected=='name'">
       <input ref="autocomplete" placeholder="Please enter country or city you want to find..." class="search-location" type="text" v-else/>
       <b-form-select v-model="selected" :options="options"/>
       <b-button variant="success search-button" @click="getAddressData">Search</b-button>
     </b-col>
   </b-row>
 </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  export default {
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
    computed: {

    },
    methods: {
      ...mapActions({
        searchByLocations: 'workspace/searchByLocation'
      }),
      getAddressData: function () {
        let place = this.autocomplete.getPlace()
        let ac = place.address_components
        let lat = place.geometry.location.lat()
        let lon = place.geometry.location.lng()
        console.log(ac)
        let city = ac[0]["short_name"]
        console.log(city)
        this.searchByLocations()
      },
    }
  }
</script>
<style>
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
