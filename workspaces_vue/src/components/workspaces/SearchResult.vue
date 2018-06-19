<template>
  <div class="search-result clearfix">
    <b-row>
      <div class="filter">
        <div class="filter-type">
          <b-row>
            <b-col md="2">
              <h4>Looking for? </h4>
            </b-col>
            <b-col md="10">
              <b-form-group>
                <b-form-radio-group :options="typeSearchOptions" v-model="typeSearch">
                </b-form-radio-group>
              </b-form-group>
            </b-col>
          </b-row>
        </div>

        <div class="filter-price" v-if="typeSearch!=='all'">
          <b-row>
            <b-col md="2">
              <h4>How much? </h4>
            </b-col>
            <b-col md="10" v-if="typeSearch==='1'">
              <vue-slider ref="slider" v-model="value" :min="0" :max="10000000" :interval="500000" :piecewise="true"></vue-slider>
              <span>From <strong>{{priceMin}} VND</strong> to <strong>{{priceMax}} VND per month</strong></span>
            </b-col>
            <b-col md="10" v-else>
              <vue-slider ref="slider" v-model="value" :min="0" :max="500000" :interval="100000" :piecewise="true"></vue-slider>
              <span>From <strong>{{priceMin}} VND</strong> to <strong>{{priceMax}} VND per day</strong></span>
            </b-col>
          </b-row>
        </div>
      </div>
    </b-row>
    <b-row>
      <b-col md="7" v-if="listWorkspaceToDisplay.length > 0">
        <ul>
          <paginate name="workspacePerPage" :list="listWorkspaceToDisplay" :per="6">
            <li class="workspace-info clearfix" v-for="workspace in paginated('workspacePerPage')" :key="workspace.id">
              <router-link :to="{ name: 'DetailPage', params: { city: workspace.city, name: workspace.friendly_url }}">
                <div class="search-wrapper" :style="{ 'background-image': 'url(' + workspace.avatar + ')' }">
                  <h4 class="workspace-price" v-if="havePrivateRoom(workspace)">{{priceMonth}} VND /Month</h4>
                  <h4 class="workspace-price" v-else>{{priceDay}} VND /Day</h4>
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
      </b-col>
      <b-col v-show="listWorkspaceToDisplay.length > 0">
       <div class="google-map" id="map-result"></div>
     </b-col>
     <b-col md="7" offset="3">
       <div v-show="listWorkspaceToDisplay.length == 0">
        <h1 class="text-center">Opps, sorry. We don't have this type</h1>
      </div>
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
        value: [0,500000],
        latCenter: '',
        lngCenter: '',
        priceMonth: '',
        priceDay: ''
      }
    },
    computed: {
      ...mapState({
        listResult:state => state.workspace.listWorkspaces
      }),
      total() {
        return this.value.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
      },
      isPriceDay() {
        console.log('a')
        return this.typeSearch === '1'
      },
      isPriceMonth() {
        return this.typeSearch === '2' || this.typeSearch === '3'
      },
      listWorkspaceToDisplay() {
        return this.list
      },
      priceMin() {
        return this.formatPrice(this.value[0])
      },
      priceMax() {
        return this.formatPrice(this.value[1])
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
            let validWorkspace = false
            workspace.workspace_types.forEach((type) => {
              let validPrice = this.isValidPrice(typeSearch, type.price_day, type.price_month)
              validWorkspace = (parseInt(typeSearch) === type.type_id) && validPrice
              if(validWorkspace == true) {
                return
              }
            })
            return validWorkspace
          })
        } else {
          this.list = this.listResult
        }
      },
      havePrivateRoom(workspace) {
        let roomType = []
        workspace.workspace_types.forEach((type) => {
          roomType.push(type.type_id)
          this.priceMonth = this.formatPrice(type.price_month)
          this.priceDay = this.formatPrice(type.price_day)
        })
        return roomType.includes(1) ? true :false
      },
      isValidPrice(typeSearch, priceDay, priceMonth) {
        if (typeSearch === '1') {
          return parseInt(priceMonth) >= this.value[0] && parseInt(priceMonth) <= this.value[1]
        } else {
          return parseInt(priceDay) >= this.value[0] && parseInt(priceDay) <= this.value[1]
        }
      },
      formatPrice(price) {
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")
      }
    },
    created() {
      this.searchWorkspace(
      { 
        city: this.$route.params.city, 
        district:this.$route.params.district
      }
      )
    },
    watch: {
      listResult() {
        this.list = this.listResult
        if (this.list.length > 0) {
          this.latCenter = this.listResult[0].lat
          this.lngCenter = this.listResult[0].lng
          this.getAllMarkerCoordinates(this.listResult)
          this.generateMap()
        }
      },
      list() {
        if (this.list.length > 0) {
          this.getAllMarkerCoordinates(this.list)
          this.generateMap()
        }
      },
      typeSearch() {
        this.value = [0,500000]
        this.filter(this.typeSearch, this.value)
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
    width: 100%;
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
