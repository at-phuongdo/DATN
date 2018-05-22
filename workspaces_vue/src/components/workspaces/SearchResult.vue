<template>
  <div class="search-result clearfix">
    <b-row>
      <b-col md="7">
        <div class="filter">
          <div class="filter-type">
            <h4>Looking for? </h4>
            <b-form-group>
              <b-form-radio-group :options="typeSearchOptions" v-model="typeSearch">
              </b-form-radio-group>
            </b-form-group>
          </div>
          <div class="filter-price">
            <h4>How much? </h4>
            <vue-slider ref="slider" v-model="value" :min="100000" :max="100000000" :interval="100000" :piecewise="true"></vue-slider>
            <p>{{value}}</p>
          </div>
        </div>
        <ul v-if="list.length > 0">
          <paginate name="workspacePerPage" :list="list" :per="6">
            <li class="workspace-info clearfix" v-for="workspace in paginated('workspacePerPage')" :key="workspace.id">
              <router-link :to="{ name: 'DetailPage', params: { city: workspace.city, name: workspace.friendly_url }}">
                <div class="search-wrapper" :style="{ 'background-image': 'url(' + workspace.avatar + ')' }">
                  <h3 class="workspace-price">VND {{workspace.price_day}} /DAY</h3>
                </div>
                <div class="content">
                  <h5 class="workspace-name"><strong>{{workspace.name}}</strong></h5>
                  <span v-for="currentRating in rating" :key="currentRating" v-bind:class="[workspace.rating > currentRating ? checkedStar : uncheckStar]"></span>
                  <span>( {{workspace.comments.length}} Reviews)</span>
                </div>
              </router-link>
            </li>
          </paginate>
          <div class="paginate">
            <paginate-links for="workspacePerPage" :limit="2" :show-step-links="true" class="pagination" align="center"></paginate-links>
          </div>
        </ul>
        <div v-else>
          <h1 class="text-center">Opps, Sorry we cannot found</h1>
        </div>
      </b-col>
      <b-col>
       <div class="google-map" id="map-result"></div>
     </b-col>
   </b-row>
 </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  import vueSlider from 'vue-slider-component'
  export default {
    components: {
      vueSlider
    },
    data() {
      return {
        list: [],
        uncheckStar: 'fa fa-star',
        checkedStar: 'fa fa-star checked',
        paginate: ['workspacePerPage'],
        rating: 5,
        markerCoordinates: [],
        typeSearchOptions: [
        { text: 'All', value: 'all' },
        { text: 'Private Room', value: '1' },
        { text: 'Meeting Room', value: '2' },
        { text: 'Open Planing Room', value: '3' }
        ],
        typeSearch: 'all',
        value: [100000,100000000],
        latCenter: '',
        lngCenter: ''
      }
    },
    computed: {
      ...mapState({
        listResult:state => state.workspace.listWorkspaces
      }),
      total() {
        return this.value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
      }
    },  
    methods: {
      ...mapActions({
        searchWorkspace: 'workspace/searchByLocation'
      }),
      generateMap() {
        const element = document.getElementById('map-result')
        const options = {
          zoom: 12,
          center: new google.maps.LatLng(this.latCenter, this.lngCenter)
        }

        const map = new google.maps.Map(element, options)
        this.markerCoordinates.forEach((coord) => {
          const title = coord.title
          var infowindow = new google.maps.InfoWindow({
            content: title
          });
          const position = new google.maps.LatLng(coord.latitude, coord.longitude)
          const marker = new google.maps.Marker({ 
            title: title,
            position,
            map : map
          });
          google.maps.event.addListener(marker, 'mouseover', function(ev){
            infowindow.open(map, marker);
          });
          google.maps.event.addListener(marker, 'mouseout', function () {
            infowindow.close();
          });
        });
      },
      getAllMarkerCoordinates(listResult) {
        this.markerCoordinates = []
        listResult.forEach((workspace) => {
          this.markerCoordinates.push({
            title: workspace.name,
            latitude: workspace.lat,
            longitude: workspace.lng 
          })
        })
      },
      filter(typeSearch, price) {
        if(typeSearch !== 'all') {
          this.list = this.listResult.filter((workspace) => {
            let all_types = []
            workspace.workspace_types.forEach((type) => {
              return ((typeSearch === parseInt(type.type_id)) && isValidPrice())
            })
            return all_types.includes(parseInt(type))
          })
        } else {
          this.list = this.listResult
        }
      }
    },
    created() {
      this.searchWorkspace(this.$route.params.key)
    },
    watch: {
      listResult() {
        this.list = this.listResult
        this.latCenter = this.listResult[0].lat
        this.lngCenter = this.listResult[0].lng
        this.getAllMarkerCoordinates(this.listResult)
        this.generateMap()
      },
      typeSearch() {
        this.filter(this.typeSearch, this.value)
        if(this.list.length > 0) {
          this.getAllMarkerCoordinates(this.list)
          this.generateMap()
        }
      },
      value() {
        this.filter(this.typeSearch, this.value)
      }
    }
  }
</script>
<style scoped>
  .clearfix:after {
    content: "";
    display: table;
    clear: both;
  } 

  .filter {
    padding-left: 90px;
  }

  .search-result {
    padding: 100px 0;
  }

  a {
    color: #000000;
  }

  a:hover {
    text-decoration: none;
  }

  .workspace-info {
    float: left;
    width: 30%;
    margin: 10px;
    height: 350px;
    border: 1px solid #e6e6e6;
  }

  .search-wrapper {
    height: 200px;
    background-size: cover;
    position: relative;
  }

  .workspace-price {
    position: absolute;
    bottom: 0;
    color: white;
  }

  li {
    list-style-type: none;
  }

  li:hover {
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  }

  .content {
    padding: 10px;
  }

  .checked {
    color: orange;
  }

  .paginate {
    clear: both;
    display: table;
    margin: auto;
  }

  .google-map {
    width: 100%;
    height: 100%;
    margin: 0 auto;
    background: gray;
    margin-top: 10px;
  }
</style>
