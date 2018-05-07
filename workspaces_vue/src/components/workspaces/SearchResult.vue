<template>
  <div class="search-result clearfix">
    <b-row>
      <b-col md="7">
        <ul v-if="list.length > 0">
          <paginate name="workspacePerPage" :list="list" :per="6">
            <li class="workspace-info clearfix" v-for="workspace in paginated('workspacePerPage')" :key="workspace.id">
              <router-link :to="{ name: 'DetailPage', params: { city: workspace.city, name: workspace.friendly_url }}">
                <div class="search-wrapper" :style="{ 'background-image': 'url(' + workspace.avatar + ')' }">
                </div>
                <div class="content">
                  <h5 class="workspace-name"><strong>{{workspace.name}}</strong></h5>
                  <span v-for="currentRating in rating" :key="currentRating" v-bind:class="[workspace.rating > currentRating ? checkedStar : uncheckStar]"></span>
                  <span>( {{workspace.comments.length}} Reviews)</span>
                  <h3 class="workspace-price">VND {{workspace.price_day}} /DAY</h3>
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
  export default {
    data() {
      return {
        list: [],
        uncheckStar: 'fa fa-star',
        checkedStar: 'fa fa-star checked',
        paginate: ['workspacePerPage'],
        rating: 5,
        markerCoordinates: [{
          latitude: 16.056115,
          longitude: 108.190248
        }],
      }
    },
    computed: {
      ...mapState({
        listResult:state => state.workspace.listWorkspaces
      })
    },
    methods: {
      ...mapActions({
        searchWorkspace: 'workspace/searchByLocation'
      }),
      generateMap: function() {
        const element = document.getElementById('map-result')
        const options = {
          zoom: 12,
          center: new google.maps.LatLng(16.056115,108.190248)
        }
        const map = new google.maps.Map(element, options)
        this.markerCoordinates.forEach((coord) => {
          const position = new google.maps.LatLng(coord.latitude, coord.longitude)
          const marker = new google.maps.Marker({ 
            position,
            map : map
          });
          google.maps.event.addListener(marker, 'dragend', function(ev){
            alert(marker.getPosition())
          });
        });
      },
      getAllMarkerCoordinates(listResult) {
        listResult.forEach((workspace) => {
          this.markerCoordinates.push({
            latitude: workspace.lat,
            longitude: workspace.lng 
          })
        })
      }
    },
    created: function() {
      this.searchWorkspace(this.$route.params.key)
    },
    watch: {
      listResult: function() {
        this.list = this.listResult
        this.getAllMarkerCoordinates(this.listResult)
        this.generateMap()
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
  }
</style>
