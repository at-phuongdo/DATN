<template>
  <div class="search">
   <b-row>
     <b-col md="4" offset-md="4">
       <h1 class="search-title"><span class="decorate-span">Let's</span> find a workspace</h1>
     </b-col>
   </b-row>
   <b-row>
     <b-col md="4" offset-md="4" class="search-content">
       <div class="search-input">
         <input ref="autocomplete" placeholder="Please enter country or city you want to find..." class="search-location" type="text" v-show="selected=='location'"/>
         <input placeholder="Please enter the name you want to find..." class="search-name" type="text" v-model="nameSearch" v-show="selected=='name'" v-on:keyup="searchName($event.target.value)"/>
       </div>
       <div class="button-search">
         <b-form-select v-model="selected" :options="options"/>
         <b-button variant="success search-button" @click="getAddressData" v-if="selected=='location'">Search</b-button>
         <b-button variant="success search-button" @click="searchName" v-else>Search</b-button>
       </div>
     </b-col>
   </b-row>
   <b-row>
    <b-col md="4" offset-md="4">
      <ul class="search-result">
        <li v-for="workspace in listWorkspaceByName" :key="workspace.id">
         <router-link :to="{ name: 'DetailPage', params: { city: workspace.city, name: workspace.friendly_url }}">
           <span class="fa fa-map-marker"></span> {{workspace.name}} 
         </router-link>
       </li>
     </ul>
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
        selected: 'location',
        nameSearch: '',
        listWorkspaceByName: []
      }
    },
    computed: {
      ...mapState({
        listWorkspace:state => state.workspace.listWorkspaces
      })
    },
    methods: {
      ...mapActions({
        searchByLocations: 'workspace/searchByLocation',
        searchByName: 'workspace/searchByName',
     
      }),
      getAddressData: function() {
        let place = this.autocomplete.getPlace()
        if (place) {
          let ac = place.address_components
          let lat = place.geometry.location.lat()
          let lon = place.geometry.location.lng()
          let address = ac[0]["long_name"]
          this.searchByLocations(address)
          this.$router.push('/search/' + address)
        }
      },
      searchName: function(search) {
        this.searchByName(search)
      },
      workspaceDetail: function(id) {
        this.getDetail(id)
      }
    },
    watch: {
      listWorkspace: function() {
        this.listWorkspaceByName = this.listWorkspace
      },
      selected: function() {
        this.listWorkspaceByName = []
      }
    }
  }
</script>
<style scoped>
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

  .search-input {
    width: 60%;
  }

  .search-location,
  .search-name {
    display: block;
    width: 100%;
    margin: 0 auto;
    font-weight: 400;
    outline: none;
    line-height: 30px;
    border-radius: 0.25rem;
    padding-left: 10px;
  }

  .button-search {
    display: inline;
    width: 50%;
  }

  select {
    width: 50%;
  }

  .search-result {
    width: 60%;
    background-color: white;
    margin-top: -20px;
    width: 55%;
  }

  ul.search-result li {
    list-style-type: none;
    margin-left: -40px;
    padding-left: 10px;
  }

  .search-result li:hover {
    background-color: #28a745;
  }

  a {
    color: #2c3e50;
  }

  a:hover {
    text-decoration: none;
  }
</style>
