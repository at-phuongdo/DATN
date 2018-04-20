d<template>
  <div class="detail">
    <div class="avatar" :style="{ 'background-image': 'url(' + workspace.avatar + ')' }">
    </div>
    <div class="container">
      <div class="description">
        <h1><strong>{{workspaceDetail.name}}</strong></h1>
        <p><span class="fa fa-map-marker"></span>{{workspaceDetail.address}}</p>
        <hr>
        <h4><span class="fa fa-bullseye"></span><strong> Overview</strong></h4>
        <div v-html="workspaceDetail.description"></div>
      </div>
      <hr>
      <div class="amenities">
        <h4><span class="fa fa-gratipay"></span><strong> Amenities</strong></h4>
        <ul>
          <li v-for="amenity in workspaceDetail.convenient" :key="amenity.id">{{amenity.name}}</li>
        </ul>
      </div>
      <hr>
      <div class="room-type">
        <h4><span class="fa fa-building"></span><strong> Office type & Price</strong></h4>
        <table class="room-table">
          <tr>
            <th>Office type</th>
            <th>Name</th>
            <th>Number Of People</th>
            <th>Price Hour</th>
            <th>Price Day</th>
            <th>Price Week</th>
            <th>Price Month</th>
            <th>Price Year</th>
            <th>Availability</th>
          </tr>
          <tr v-for="row in workspaceDetail.workspace_types" :key="row.id">
            <td v-if="row.type_id==1">Private Room</td>
            <td v-if="row.type_id==2">Meeting Room</td>
            <td v-if="row.type_id==3">Open Plan Room</td>
            <td>{{row.name}}</td>
            <td>{{row.number_of_people}}</td>
            <td>{{row.price_hour}}</td>
            <td>{{row.price_day}}</td>
            <td>{{row.price_week}}</td>
            <td>{{row.price_month}}</td>
            <td>{{row.price_year}}</td>
            <td><b-button variant="outline-success" >Enquire</b-button></td>
          </tr>
        </table>
      </div>
      <hr>
      <div class="photos">
        <h4><span class="fa fa-camera"></span><strong> Photos</strong></h4>
        <img class="workspace-photo" v-for="workspace in workspaceDetail.workspace_images" :src="workspace.images" :key="workspace.id">
      </div>
      <hr>
      <div class="location">
        <h4><span class="fa fa-map-marker"></span><strong> Location</strong></h4>
        <div class="google-map" :id="mapName"></div>
      </div>
      <div class="review">
        <h4><span class="fa fa-comment"></span><strong> Review</strong></h4>
        <workspace-comment></workspace-comment>
      </div>
    </div>
  </div>
</template>
<script>
  import { mapActions } from 'vuex'
  import { mapState } from 'vuex'
  import Comments from './Comments.vue'
  export default {
    components: {
      'workspace-comment': Comments
    },
    data() {
      return {
        workspaceDetail: {},
        mapName: this.name + "-map",
        markerCoordinates: {}
      }
    },
    created() {
      this.getDetail(this.$route.params.name)
    },
    computed: {
      ...mapState({
        workspace:state => state.workspace.workspaceDetail
      })
    },
    methods: {
      ...mapActions({
        getDetail: 'workspace/getDetail'
      }),
      generateMap: function() {
        this.markerCoordinates = {
          latitude: this.workspaceDetail.lat,
          longitude: this.workspaceDetail.lng
        }
        const element = document.getElementById(this.mapName)
        const options = {
          zoom: 15,
          center: new google.maps.LatLng(this.workspaceDetail.lat,this.workspaceDetail.lng)
        }
        const map = new google.maps.Map(element, options)
        const position = new google.maps.LatLng(this.markerCoordinates.latitude, this.markerCoordinates.longitude)
        const marker = new google.maps.Marker({ 
          position,
          draggable: true,
          map : map
        });
        google.maps.event.addListener(marker, 'dragend', function(ev){
          alert(marker.getPosition())
        });
      }
    },
    watch: {
      workspace: function() {
        this.workspaceDetail = this.workspace
        this.generateMap()
      }
    }
  }
</script>
<style scoped>
  .detail {
    padding: 50px 0;
  }
  .avatar{
    height: 500px;
    background-size: cover;
    background-position: center;
  }

  .room-table {
    width: 100%;
    text-align: center;
  }

  .room-table th, td{
    border: 1px solid #e5e5e5;
  }

  .workspace-photo {
    width: 33.33%;
    padding: 10px;
  }
  .google-map {
    width: 100%;
    height: 500px;
    margin: 0 auto;
    background: gray;
  }
</style>