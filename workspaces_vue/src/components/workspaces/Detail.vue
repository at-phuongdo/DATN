<template>
  <div class="detail">
    <div class="avatar" :style="{ 'background-image': 'url(' + workspace.avatar + ')' }">
    </div>
    <div class="container">
      <div class="overview">
        <h1><strong>{{workspaceDetail.name}}</strong></h1>
        <p><span class="fa fa-map-marker"></span>{{workspaceDetail.address}}</p>
      </div>
      <hr>
      <div class="description">
        <h4><span class="fa fa-bullseye"></span><strong> Overview</strong></h4>
        <div class="opening-hour">
          <h3><strong>Opening hours</strong></h3>
          <hr>
          <div class="mon-fri" v-if="monToFriSame()">
            <p><strong>Mon-fri</strong></p>
            <p>{{workspaceDetail.open_mon}}</p>
          </div>
          <div v-else>
            <p><strong>Mon</strong></p>
            <p>{{workspaceDetail.open_mon}}</p>
            <p><strong>Tues</strong></p>
            <p>{{workspaceDetail.open_tue}}</p>
            <p><strong>Wed</strong></p>
            <p>{{workspaceDetail.open_wed}}</p>
            <p><strong>Thurs</strong></p>
            <p>{{workspaceDetail.open_thurs}}</p>
            <p><strong>Fri</strong></p>
            <p>{{workspaceDetail.open_fri}}</p>
          </div>
          <div class="weekend">
            <p><strong>Sat</strong></p>
            <p v-if="workspaceDetail.open_sat != '-'">{{workspaceDetail.open_sat}}</p>
            <p v-else>Closed</p>
            <p><strong>Sun</strong></p>
            <p v-if="workspaceDetail.open_sun != '-'">{{workspaceDetail.open_sun}}</p>
            <p v-else>Closed</p>
          </div>
        </div>
        <div class="description" v-html="workspaceDetail.description">
        </div>
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
            <td>{{row.type.name}}</td>
            <td>{{row.name}}</td>
            <td>{{row.number_of_people}}</td>
            <td>{{row.price_hour}}</td>
            <td>{{row.price_day}}</td>
            <td>{{row.price_week}}</td>
            <td>{{row.price_month}}</td>
            <td>{{row.price_year}}</td>
            <td><b-button variant="outline-success" @click="openOrderModal(row)">Reserve</b-button></td>
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
    <order-modal :officeOrder = "currentOffice"></order-modal>
  </div>
</template>
<script>
  import { mapActions, mapState } from 'vuex'
  import Comments from './Comments.vue'
  import OrderModal from './OrderModal.vue'
  export default {
    components: {
      'workspace-comment': Comments,
      'order-modal': OrderModal
    },
    data() {
      return {
        workspaceDetail: {},
        mapName: this.name + "-map",
        markerCoordinates: {},
        currentOffice: {},
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
      },
      monToFriSame() {
        return this.workspaceDetail.open_mon == this.workspaceDetail.open_tue
        && this.workspaceDetail.open_tue == this.workspaceDetail.open_wed
        && this.workspaceDetail.open_wed == this.workspaceDetail.open_thurs
        && this.workspaceDetail.open_thurs == this.workspaceDetail.open_fri
      },
      openOrderModal(office) {
        this.currentOffice = office
        this.$root.$emit('bv::show::modal', 'orderModal')
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

  .opening-hour {
    float: right;
    border: 1px solid #28a745;
    padding: 10px;
    border-radius: 10px;
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

  .notice {
    color: red;
  }
</style>