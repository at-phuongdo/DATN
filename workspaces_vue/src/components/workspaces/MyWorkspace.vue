<template>
  <div>
    <div class="container">
      <div class="form-workspace">
        <!-- Description -->
        <b-btn v-b-toggle.description class="colapse-btn">Description</b-btn>
        <b-collapse visible id="description">
          <h3>Tell us about your space</h3>
          <div class="form-content">
            <b-form>
              <b-form-group id="group-name" label="Workspace's name" label-for="workspace-name">
                <b-form-input id="workspace-name" type="text" v-model="workspace.name" placeholder="Enter name">
                </b-form-input>
              </b-form-group>
              <b-form-group id="group-description" label="Description" label-for="workspace-description">
                <ckeditor 
                v-model="workspace.description" 
                :config="config">
              </ckeditor>
            </b-form-group>
          </b-form>
        </div>
      </b-collapse>
      <!-- /Description -->
      <!-- Contact -->
      <b-btn v-b-toggle.contact class="colapse-btn">Contact</b-btn>
      <b-collapse visible id="contact">
        <h3>How can I contact you? </h3>
        <div class="official-contact">
          <h4>Official contact details</h4>
          <div class="form-content">
            <b-form>
              <b-form-group id="group-contact-email" label="Email" label-for="workspace-email">
                <b-form-input id="workspace-email" type="email" v-model="workspace.email" placeholder="Enter email">
                </b-form-input>
              </b-form-group>
              <b-form-group id="group-contact-phone" label="Phone" label-for="workspace-phone">
                <b-form-input id="workspace-phone" type="text" v-model="workspace.phone" placeholder="Enter phone number">
                </b-form-input>
              </b-form-group>
              <b-form-group id="group-contact-website" label="Website URL" label-for="workspace-website">
                <b-form-input id="workspace-website" type="text" v-model="workspace.website" placeholder="Enter website">
                </b-form-input>
              </b-form-group>
            </b-form>
          </div>
        </div>
        <div class="social-contact">
          <h4>Social contact</h4>
          <div class="form-content">
            <b-form>
              <b-form-group id="group-contact-facebook" label="Facebook" label-for="workspace-facebook">
                <b-form-input id="workspace-facebook" type="text" v-model="workspace.facebook" placeholder="Enter facebook">
                </b-form-input>
              </b-form-group>
            </b-form>
          </div>
        </div>
      </b-collapse>
      <!-- /Contact -->
      <!-- Location -->
      <b-btn v-b-toggle.location class="colapse-btn">Location</b-btn>
      <b-collapse visible id="location">
        <google-map
        name="location" @getAddress="getAddress" :addressWorkspace="workspaceInfo"
        ></google-map>
      </b-collapse>
      <!-- /Location -->
      <!-- Amenities -->
      <b-btn v-b-toggle.amenities class="colapse-btn">Amenities</b-btn>
      <b-collapse visible id="amenities">
        <h3>Tell us about your amenities</h3>
        <div class="form-content">
          <b-form-group label="Amenities of our workspace">
            <span v-for="amenity in amenities" :key="amenity.id">
              <input
              type='checkbox'
              :value="amenity.id"
              v-model='amenities_selected'> {{amenity.name}}
              <br>
            </span>
          </b-form-group>
        </div>
      </b-collapse>
      <!-- /Amenities -->
      <b-row class="submit-btn">
        <b-button type="button" variant="primary next-btn" @click="submit">Save</b-button>
      </b-row>
    </div>
  </div>
  <div class="loading style-2" v-if="loading"><div class="loading-wheel"></div></div>
</div>
</template>
<script>
  import {Circle4} from 'vue-loading-spinner'
  import MapComponent from './Map.vue'
  import Photos from './Photos.vue'
  import Ckeditor from 'vue-ckeditor2'
  import { mapActions, mapState } from 'vuex'
  export default {
    components: {
      Circle4
    },
    dependencies : ['workspaceService'],
    components: {
      'google-map' : MapComponent,
      'workspace-photos' : Photos,
      'ckeditor' : Ckeditor
    },
    data() {
      return {
        config: {
          toolbar: [
          [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript' ]
          ],
          height: 300
        },
        checked: 'fa fa-check',
        typing: 'typing',
        amenities: [],
        amenities_selected: [],
        unit_price: 'vnd',
        workspace: {
          name: '',
          description: '',
          avatar: '',
          email: '',
          phone: '',
          website: '',
          facebook: '',
          street: '',
          town: '',
          district: '',
          city: '',
          country: '',
          lat: '',
          lng: '',
          open_mon: '',
          open_tue: '',
          open_wed: '',
          open_thurs: '',
          open_fri: '',
          open_sat: '',
          open_sun: '',
          price_hour: '',
          price_day: '',
          price_week: '',
          price_month: '',
          price_year: '',
          unit: ''
        },
        loading: false,
        currentUser: null,
        mapName: this.name + "-map",
        markerCoordinates: {}
      }
    },
    created() {
      this.getCurrentUser(localStorage.getItem("token"))
      this.getConvenient()
    },

    computed: {
      ...mapState({
        userLogin:state => state.user.currentUser,
        convenients:state => state.convenient.listConvenient,
        workspaceInfo:state => state.workspace.workspaceDetail
      })
    },
    methods: {
      ...mapActions({
        getCurrentUser: 'user/getCurrentUser',
        getWorkspace: 'workspace/getDetail',
        getConvenient: 'convenient/getAllConvenient',
        updateWorkspace: 'workspace/update'
      }),
      getAddress: function(address) {
        this.workspace.country = address.country
        this.workspace.city = address.city
        this.workspace.district = address.district
        this.workspace.town = address.town
        this.workspace.street = address.street
        this.workspace.lat = address.lat
        this.workspace.lng = address.lng
      },
      submit: async function() {
        this.updateWorkspace({
          workspace: this.workspace,
          amenities: this.amenities_selected,
        })
      },
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
    },
    watch: {
      userLogin() {
        this.currentUser = this.userLogin
        this.getWorkspace(this.userLogin.workspaces[0].friendly_url)
      },
      workspaceInfo() {
        this.workspace = this.workspaceInfo
        this.amenities_selected = this.workspaceInfo.convenient.map((item) => {
          return item.id
        })
      },
      convenients: function() {
        this.amenities = this.convenients
      }
    }
  }
</script>
<style scoped>
  .container {
    padding: 100px 0;
  }

  .colapse-btn {
    width: 100%;
    background-color: #40838c;
    margin: 5px;
  }

  .collapse {
    padding: 20px;
  }

  .form-workspace {
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    padding: 20px;
  }

  .google-map {
    width: 100%;
    height: 500px;
    margin: 0 auto;
    background: gray;
  }

  .form-content {
    background-color: #F9F9F9;
    padding: 10px;
  }

  li {
    list-style-type: none;
    border: 1px solid black;
    border-radius: 5px;
    padding: 10px;
    margin: 10px 0;
    background-color: #F9F9F9;
  }

  li i {
    float: right;
  }

  .submit-btn {
    display: table;
    margin: auto;
  }

  .typing {
    background-color: #28a745;
    color: white;
  }

  select {
    width: 10%;
  }
  .loading {
    width: 100%;
    height: 100%;
    position: fixed;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    background-color: rgba(0,0,0,.5);
  }
  .loading-wheel {
    width: 20px;
    height: 20px;
    margin-top: -40px;
    margin-left: -40px;
    
    position: absolute;
    top: 50%;
    left: 50%;
    
    border-width: 30px;
    border-radius: 50%;
    -webkit-animation: spin 1s linear infinite;
  }
  .style-2 .loading-wheel {
    border-style: double;
    border-color: #ccc transparent;
  }
  @-webkit-keyframes spin {
    0% {
      -webkit-transform: rotate(0);
    }
    100% {
      -webkit-transform: rotate(-360deg);
    }
  }
</style>
